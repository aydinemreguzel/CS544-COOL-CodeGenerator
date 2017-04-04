package cool.cgen;

import cool.ast.*;
import cool.util.Environment;
import cool.ast.Visitor;

import java.util.LinkedList;
import java.util.List;

import static cool.sema.Type.SELF_TYPE;
import static java.lang.String.format;

public class CodeEmitter implements Visitor<IRValue> {
    private final ConstantPool constantPool;
    private final Environment<IRValue> env;
    private StringBuilder buffer;
    private int registerCounter;
    private int labelCounter;

    public CodeEmitter(ConstantPool constantPool, Environment<IRValue> env) {
        this.constantPool = constantPool;
        this.env = env;
    }

    // This is the entry method into this code emitter object
    public void emitInto(StringBuilder buffer) {
        this.buffer = buffer;
        emitln(";;;;;;;;;;;;;;;;;;;;;");
        emitln(";;;    METHODS    ;;;");
        emitln(";;;;;;;;;;;;;;;;;;;;;");

        env.getRoot().accept(this);

        emitMainMethod();
    }

    @Override
    public void visitClass(Klass klass) {
        if (!env.isBuiltin(klass)) {
            env.setCurrentClass(klass);
            emitConstructor();
            for (Feature feature : klass.features)
                feature.accept(this);
        }
        for (Klass child : klass.children)
            child.accept(this);
    }

    private void emitConstructor() {
        registerCounter = labelCounter = 0;
        String coolType = env.getCurrentClass().name;
        int numFields = env.getFields(env.getCurrentClass()).size();
        numFields += 1; // +1 for the vtable pointer
        int objectSize = numFields * 8;

        emitln("define %" + coolType + "* @" + coolType + "_new() {");
        IRReg rawMalloc = freshName("i8*");
        emitInst(rawMalloc, "call i8* @malloc(i64 " + objectSize + ")");
        IRValue ptr = emitCast(rawMalloc, "%" + coolType + "*");

        // Set vtable pointer
        emitln("  ;; setting vtable");
        IRReg vtablePtrPtr = freshName("%" + coolType + "_vtable**");
        emitInst(vtablePtrPtr, "getelementptr " + ptr.getBaseType() + ", " + ptr.fullName() + ", i32 0, i32 0");
        emitInst("store %" + coolType + "_vtable* @" + coolType + "_vtable_prototype, " + vtablePtrPtr.fullName());

        // Set fields to default values
        int offset = 1;
        for (Field field : env.getFields(env.getCurrentClass())) {
            emitln("  ;; default-initializing field '" + field.name + "'");
            String rawType = field.type.equals(SELF_TYPE) ? coolType : field.type;
            String llvmType = "%" + rawType + "*";
            IRReg fieldPtr = freshName(llvmType + "*");
            emitInst(fieldPtr, "getelementptr " + ptr.getBaseType() + ", " + ptr.fullName() + ", i32 0, i32 " + offset);
            IRValue v = new IRNull(llvmType);
            if ("Int".equals(rawType) || "Bool".equals(rawType) || "String".equals(rawType)) {
                IRReg defaultVal = freshName(llvmType);
                emitInst(defaultVal, "call " + llvmType + " @" + rawType + "_new()");
                v = defaultVal;
            }
            emitInst("store " + v.fullName() + ", " + fieldPtr.fullName());
            offset++;
        }

        env.push("self", ptr);

        // Custom initialization of fields
        env.getFields(env.getCurrentClass()).stream().filter(f -> f.initialization != null).forEachOrdered(f -> {
            emitln("  ;; initializing field '" + f.name + "'");
            IRValue rhs = f.initialization.accept(this);
            IRValue fieldPtr = lookup(f.name);
            IRValue cast = emitCast(rhs, fieldPtr.getBaseType());
            emitInst("store " + cast.fullName() + ", " + fieldPtr.fullName());
        });

        env.pop(); // self

        emitInst("ret " + ptr.fullName());
        emitln("}\n");
    }

    private IRValue emitCast(IRValue value, String toType) {
        // Omit cast operation if the types are already the same
        if (!value.getType().equals(toType)) {
            IRReg result = freshName(toType);
            emitInst(result, "bitcast " + value.fullName() + " to " + toType);
            return result;
        } else {
            return value;
        }
    }

    private IRValue lookup(String name) {
        IRValue ptr = env.lookup(name);
        if (ptr == null) {
            // TODO: If the name is not found in the local object map, search in env.getFields(env.getCurrentClass())
        }
        return ptr;
    }

    @Override
    public void visitField(Field field) {
        // Do nothing. Fields are handled inside emitConstructor.
    }

    @Override
    public void visitMethod(Method method) {
        registerCounter = labelCounter = 0;
        // TODO
    }

    private void emitMethodHeader(Method method) {
        String className = method.owner.name;
        String returnType = method.returnType.equals(SELF_TYPE) ? className : method.returnType;
        emit(format("define %%%s* @%s_%s(%%%s* %%self",
                returnType, className, method.name, className));
        for (Formal formal : method.formals) {
            emit(", %" + formal.type + "* %" + formal.name);
        }
        emitln(") {");
        emitln(freshLabel("entry") + ":");
    }

    ///
    /// Visitor methods
    ///

    @Override
    public IRValue visitAssignment(Assignment assignment) {
        // TODO
        throw new Error("To be implemented.");
    }

    @Override
    public IRValue visitBinary(Binary binary) {
        IRValue left = binary.left.accept(this);
        IRValue right = binary.right.accept(this);
        // The 'if' below is a guard against the EQUALS operator
        // which is defined between any types, not just Int and Bool.
        if (binary.op != BinaryOperator.EQUALS || left.getType().equals("%Int*") || left.getType().equals("%Bool*")) {
            left = unbox(left);
            right = unbox(right);
        }
        String primType = binary.op.isArithmeticOp() ? "i32" : "i1";
        IRReg sum = freshName(primType);
        String op = llvmInstFor(binary.op);
        emitInst(sum, op + " " + left.fullName() + ", " + right.name());
        IRValue result = box(sum);
        return result;
    }

    @Override
    public IRValue visitBlock(Block block) {
        IRValue result = null;
        for (Expr expr : block.exprs) {
            result = expr.accept(this);
        }
        return result;
    }

    @Override
    public IRValue visitBoolConst(BoolConst boolConst) {
        return constantPool.getIRConstant(boolConst.value);
    }

    @Override
    public IRValue visitCase(Case caseExpr) {
        emitInst(";; Emitting case expr");

        String exprType = caseExpr.expr.type.name;
        IRValue exprValue = caseExpr.expr.accept(this);
        exprValue = emitCast(exprValue, "%Object*");

        IRReg vtablePtrPtr = freshName("%Object_vtable**");
        emitInst(vtablePtrPtr, "getelementptr %Object, %Object* " + exprValue.name() + ", i32 0, i32 0");
        IRReg vtablePtr = freshName(vtablePtrPtr.getBaseType());
        emitInst(vtablePtr, "load " + vtablePtrPtr.getBaseType() + ", " + vtablePtrPtr.fullName());

        IRReg tagPtr = freshName("i32*");
        emitInst(tagPtr, "getelementptr " + vtablePtr.getBaseType() + ", " + vtablePtr.fullName() + ", i32 0, i32 0");
        IRReg tagVal = freshName(tagPtr.getBaseType());
        emitInst(tagVal, "load " + tagPtr.getBaseType() + ", " + tagPtr.fullName());

        IRReg resultPtr = freshName("%" + caseExpr.type.name +"**");
        emitInst(resultPtr, "alloca %" + caseExpr.type.name +"*");

        int maxTag = env.getNumClasses();
        String exit = freshLabel("exit");
        // More specific (i.e. "deeper") classes have higher tags.
        // Therefore, give priority to them.
        for (int tag = maxTag; tag >= 0; tag--) {
            for (Branch branch : caseExpr.branches) {
                if (env.getClassTag(branch.className) == tag) {
                    emitInst(";; checking for case " + branch.className);
                    IRReg cmpGTE = freshName("i1");
                    IRReg cmpLTE = freshName("i1");
                    IRReg inRange = freshName("i1");
                    emitInst(cmpGTE, "icmp sge i32 " + tagVal.name() + ", " + tag);
                    emitInst(cmpLTE, "icmp sle i32 " + tagVal.name() + ", " + maxChildTag(env.getClass(branch.className)));
                    emitInst(inRange, "and i1 " + cmpGTE.name() + ", " + cmpLTE);
                    String trueCase = freshLabel("true");
                    String falseCase = freshLabel("false");
                    emitInst("br i1 " + inRange.name() + ", label %" + trueCase + ", label %" + falseCase);
                    emitln(trueCase + ":");
                    // Execute branch expr.
                    String llvmType = "%" + branch.className + "*";
                    exprValue = emitCast(exprValue, llvmType);
                    IRReg caseVar = freshName(llvmType + "*");
                    emitInst(caseVar, "alloca " + llvmType);
                    emitInst("store " + exprValue.fullName() + ", " + caseVar.fullName());
                    env.push(branch.name, caseVar);
                    IRValue branchVal = branch.expr.accept(this);
                    branchVal = emitCast(branchVal, resultPtr.getBaseType());
                    emitInst("store " + branchVal.fullName() + ", " + resultPtr.fullName());
                    env.pop();
                    emitInst("br label %" + exit);
                    emitln(falseCase + ":");
                }
            }
        }

        emitInst(";; Match failure. ");
        emitInst("call void @abort()");
        emitInst("unreachable");

        emitln(exit + ":");
        IRReg finalValue = freshName(resultPtr.getBaseType());
        emitInst(finalValue, "load " + resultPtr.getBaseType() + ", " + resultPtr.fullName());
        return finalValue;
    }

    private int maxChildTag(Klass klass) {
        if (klass.children.isEmpty())
            return env.getClassTag(klass);
        else {
            return klass.children.stream().map(this::maxChildTag).max(Integer::compareTo).get();
        }
    }

    @Override
    public IRValue visitConditional(Conditional conditional) {
        // TODO
        throw new Error("To be implemented.");
    }

    @Override
    public IRValue visitDynamicDispatch(DynamicDispatch dynDispatch) {
        // TODO
        throw new Error("To be implemented.");
    }

    private LinkedList<IRValue> emitArguments(List<Expr> arguments, List<Formal> formals) {
        LinkedList<IRValue> args = new LinkedList<>();
        for (int i = 0; i < formals.size(); i++) {
            Formal formal = formals.get(i);
            IRValue arg = arguments.get(i).accept(this);
            arg = emitCast(arg, "%" + formal.type + "*");
            args.add(arg);
        }
        return args;
    }

    @Override
    public IRValue visitId(Id id) {
        // TODO
        throw new Error("To be implemented.");
    }

    @Override
    public IRValue visitIntConst(IntConst intConst) {
        return constantPool.getIRConstant(intConst.value);
    }

    @Override
    public IRValue visitIsVoid(IsVoid isVoid) {
        // TODO
        throw new Error("To be implemented.");
    }

    @Override
    public IRValue visitLet(Let let) {
        String llvmDeclaredType = "%" + let.className + "*";
        IRReg reg = freshName(llvmDeclaredType + "*");
        emitInst(reg, "alloca " + llvmDeclaredType);
        IRValue ptr = reg;
        String rawType = let.className;
        String llvmType = "%" + rawType + "*";
        IRValue rhs = new IRNull(llvmType);
        if (let.initialization != null) {
            rhs = let.initialization.accept(this);
            rhs = emitCast(rhs, ptr.getBaseType());
        } else if ("Int".equals(rawType) || "Bool".equals(rawType) || "String".equals(rawType)) {
            IRReg v = freshName(llvmType);
            emitInst(v, "call " + llvmType + " @" + rawType + "_new()");
            rhs = v;
        }
        emitInst("store " + rhs.fullName() + ", " + ptr.fullName());
        env.push(let.name, ptr);
        IRValue result = let.body.accept(this);
        env.pop();

        return result;
    }

    @Override
    public IRValue visitLoop(Loop loop) {
        String conditionBlock = freshLabel("cond");
        String bodyBlock = freshLabel("body");
        String endBlock = freshLabel("end");

        emitInst("br label %" + conditionBlock);

        emitln(conditionBlock + ":");
        IRValue cond = loop.condition.accept(this);
        IRValue primCond = unbox(cond);
        emitInst("br " + primCond.fullName() + ", label %" + bodyBlock + ", label %" + endBlock);

        emitln(bodyBlock + ":");
        IRValue body = loop.body.accept(this);
        emitInst("br label %" + conditionBlock);

        emitln(endBlock + ":");
        IRValue nullValue = new IRNull("%Object*");

        return nullValue;
    }

    @Override
    public IRValue visitNegation(Negation negation) {
        // TODO
        throw new Error("To be implemented.");
    }

    @Override
    public IRValue visitNew(New expr) {
        String llvmType = "%" + expr.className + "*";
        IRReg reg = freshName(llvmType);
        emitInst(reg, "call " + llvmType + " @" + expr.className + "_new()");
        return reg;
    }

    @Override
    public IRValue visitNot(Not notExpr) {
        // TODO
        throw new Error("To be implemented.");
    }

    @Override
    public IRValue visitStaticDispatch(StaticDispatch staticDispatch) {
        // TODO
        throw new Error("To be implemented.");
    }

    @Override
    public IRValue visitStringConst(StringConst stringConst) {
        return constantPool.getIRConstant(stringConst.value);
    }

    private void emitMainMethod() {
        registerCounter = labelCounter = 0;
        // Emit code for "(new Main).main()".
        String coolType = env.lookupMethod(env.getClass("Main"), "main").returnType;
        String llvmType = "%" + coolType + "*";
        emitln("define i32 @main() {");
        emitInst("%mainobj = call %Main* @Main_new()");
        IRReg val = freshName(llvmType);
        emitInst(val, "call " + llvmType + " @Main_main(%Main* %mainobj)");
        if (coolType.equals("Int")) {
            IRValue val1 = unbox(val);
            emitInst(format("ret %s %s", val1.getType(), val1.name()));
        } else {
            emitInst("ret i32 0");
        }
        emitln("}");
    }

    ///
    /// Helper methods
    ///
    IRReg freshName(String type) {
        return new IRReg(type, "%r" + registerCounter++);
    }

    String freshLabel(String prefix) {
        if (prefix == null || prefix.isEmpty())
            prefix = "lbl";
        return prefix + "_" + (labelCounter++);
    }

    String llvmInstFor(BinaryOperator op) {
        switch (op) {
            case ADD: return "add";
            case SUBTRACT: return "sub";
            case MULTIPLY: return "mul";
            case DIVIDE: return "sdiv";
            case LESSTHAN: return "icmp slt";
            case LESSTHANEQ: return "icmp sle";
            case EQUALS: return "icmp eq";
        }
        return null;
    }

    // Designed for %Int* and %Bool*.
    private IRValue unbox(IRValue value) {
        emitInst(";; unboxing " + value.fullName());
        // TODO
        throw new Error("To be implemented.");
    }

    private String llvmPrimTypeFor(String coolType) {
        switch (coolType) {
            case "%Int": return "i32";
            case "%Bool": return "i1";
            default:
                throw new Error("Unrecognized type: " + coolType);
        }
    }

    // Designed for %Int* and %Bool*.
    private IRValue box(IRReg n) {
        emitInst(";; boxing " + n.fullName());
        String primPtrType = n.getType() + "*";
        String coolType = llvmCoolTypeFor(n.getType());
        String llvmType = "%" + coolType + "*";
        IRReg newobj = freshName(llvmType);
        emitInst(newobj, format("call %s @%s_new()", llvmType, coolType));
        IRReg ptr = freshName(primPtrType);
        emitInst(ptr, "getelementptr " + newobj.getBaseType() + ", " + newobj.fullName() + ", i32 0, i32 1");
        emitInst("store " + n.fullName() + ", " + ptr.fullName());
        return newobj;
    }

    private String llvmCoolTypeFor(String primType) {
        switch (primType) {
            case "i32": return "Int";
            case "i1": return "Bool";
            default:
                throw new Error("Unrecognized type: " + primType);
        }
    }

    private void emit(String s) {
        buffer.append(s);
    }

    private void emitln(String s) {
        buffer.append(s + "\n");
    }

    private void emitInst(String s) {
        emitln("  " + s);
    }

    private void emitInst(IRReg reg, String s) {
        emitInst(reg + " = " + s);
    }
}
