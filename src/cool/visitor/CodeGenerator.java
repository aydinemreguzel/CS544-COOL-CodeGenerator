package cool.visitor;

import cool.ast.*;

// This simple class represents the virtual registers in LLVM IR
class Reg {
    final int number;

    Reg(int number) {
        this.number = number;
    }

    public String toString() {
        return "%r" + number;
    }
}

public class CodeGenerator implements Visitor<Reg> {
    private Program program;
    private StringBuilder buffer;
    private Klass surroundingClass;
    private Method surroundingMethod;
    private int registerCounter, labelCounter;

    public CodeGenerator(Program program) {
        this.program = program;
    }

    public String generate() {
        buffer = new StringBuilder();
        for (Klass klass : program.classes) {
            emitClass(klass);
        }
        emitMainMethod();
        return buffer.toString();
    }

    private void emitClass(Klass klass) {
        surroundingClass = klass;
        for (Feature feature : klass.features) {
            feature.accept(this);
        }
    }

    @Override
    public void visitField(Field field) {
        throw new Error("To be implemented in Part II.");
    }

    @Override
    public void visitMethod(Method method) {
        surroundingMethod = method;
        registerCounter = labelCounter = 1;

        String name = surroundingClass.name + "_" + surroundingMethod.name;
        String returnType = "i32"; //TODO
        String parameters = "()";  //TODO

        emit("define " + returnType + " @" + name + parameters + " {");
        emit(freshLabel("entry") + ":");
        Reg result = method.body.accept(this);
        emitInst("ret " + returnType + " " + result);
        emit("}");
    }

    @Override
    public Reg visitAssignment(Assignment assignment) {
        return null;
    }

    @Override
    public Reg visitBinary(Binary binary) {
        return null;
    }

    @Override
    public Reg visitBlock(Block block) {
        return null;
    }

    @Override
    public Reg visitBoolConst(BoolConst boolConst) {
        return null;
    }

    @Override
    public Reg visitCase(Case expr) {
        throw new Error("To be implemented in Part II.");
    }

    @Override
    public Reg visitConditional(Conditional conditional) {
        return null;
    }

    @Override
    public Reg visitDynamicDispatch(DynamicDispatch dynDispatch) {
        throw new Error("To be implemented in Part II.");
    }

    @Override
    public Reg visitId(Id id) {
        return null;
    }

    @Override
    public Reg visitIntConst(IntConst intConst) {
        return null;
    }

    @Override
    public Reg visitIsVoid(IsVoid isVoid) {
        throw new Error("To be implemented in Part II.");
    }

    @Override
    public Reg visitLet(Let let) {
        return null;
    }

    @Override
    public Reg visitLoop(Loop loop) {
        return null;
    }

    @Override
    public Reg visitNegation(Negation negation) {
        return null;
    }

    @Override
    public Reg visitNew(New expr) {
        throw new Error("To be implemented in Part II.");
    }

    @Override
    public Reg visitNot(Not not) {
        return null;
    }

    @Override
    public Reg visitStaticDispatch(StaticDispatch staticDispatch) {
        throw new Error("To be implemented in Part II.");
    }

    @Override
    public Reg visitStringConst(StringConst stringConst) {
        throw new Error("To be implemented in Part II.");
    }

    ///////////////////
    /// Helper methods
    ///////////////////

    // The most general emit function.
    // Useful for emitting block labels, method headers and footers, etc.
    private void emit(String s) {
        buffer.append(s + "\n");
    }

    // Emit method to be used for instructions without return values,
    // such as store and ret.
    private void emitInst(String s) {
        buffer.append("  " + s + "\n");
    }

    // Emit method to be used for instructions with return values.
    private void emitInst(Reg reg, String s) {
        buffer.append("  " + reg + " = " + s + "\n");
    }

    // Emit the method that will be invoked by lli.
    private void emitMainMethod() {
        emit("define i32 @main() {");
        emitInst("%r = call i32 @Main_main()");
        emitInst("ret i32 %r");
        emit("}");
    }

    private Reg freshName() {
        return new Reg(registerCounter++);
    }

    private String freshLabel(String prefix) {
        if (prefix == null || prefix.isEmpty())
            prefix = "lbl";
        return prefix + "_" + (labelCounter++);
    }

    private String llvmTypeFor(String type) {
        switch (type) {
            case "Int": return "i32";
            case "Bool": return "i1";
            default:
                System.err.println("Cannot handle type '" + type + "' yet.");
                System.exit(1);
                return null;
        }
    }

    private String llvmInstFor(BinaryOperator op) {
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
}
