package cool.cgen;

import cool.ast.*;
import cool.ast.Visitor;
import cool.util.Environment;

import java.util.Collections;
import java.util.HashMap;
import java.util.LinkedList;

public class ConstantPool implements Visitor<Object> {
    private final Environment<IRValue> env;
    private final HashMap<Object, IRConstant> constants;
    private int counter; // counter to be used for giving id numbers to string constants

    public ConstantPool(Environment<IRValue> env) {
        this.env = env;
        constants = new HashMap<>();
        counter = 0;
    }

    public IRConstant getIRConstant(Object n) {
        return constants.get(n);
    }

    public void emitInto(StringBuilder buffer) {
        populate();

        buffer.append(";;;;;;;;;;;;;;;;;;;;;\n");
        buffer.append(";;; CONSTANT POOL ;;;\n");
        buffer.append(";;;;;;;;;;;;;;;;;;;;;\n");

        // Sort the keys to get consistent order in the output
        LinkedList<IRConstant> values = new LinkedList<>(constants.values());
        Collections.sort(values, ((c1, c2) -> c1.name().compareTo(c2.name())));
        for (IRConstant value : values) {
            value.emitInto(buffer);
        }
    }

    private void populate() {
        // Default values first
        constants.put(0, new IRIntConstant(0));
        constants.put(true, new IRBoolConstant(true));
        constants.put(false, new IRBoolConstant(false));
        constants.put("", new IRStringConstant("", counter++));

        // Now the constants from the user-defined program
        env.getRoot().accept(this);
    }

    @Override
    public void visitClass(Klass klass) {
        // TODO: Add the class name as a String constant.
    }

    @Override
    public void visitField(Field field) {
        if (field.initialization != null) {
            field.initialization.accept(this);
        }
    }

    @Override
    public void visitMethod(Method method) {
        method.body.accept(this);
    }

    @Override
    public Object visitAssignment(Assignment assignment) {
        assignment.rhs.accept(this);
        return null;
    }

    @Override
    public Object visitBinary(Binary binary) {
        binary.left.accept(this);
        binary.right.accept(this);
        return null;
    }

    @Override
    public Object visitBlock(Block block) {
        for (Expr expr : block.exprs) {
            expr.accept(this);
        }
        return null;
    }

    @Override
    public Object visitBoolConst(BoolConst boolConst) {
        // TODO: Add this bool const to the pool
        return null;
    }

    @Override
    public Object visitCase(Case caseExpr) {
        caseExpr.expr.accept(this);
        for (Branch branch : caseExpr.branches) {
            branch.expr.accept(this);
        }
        return null;
    }

    @Override
    public Object visitConditional(Conditional conditional) {
        conditional.condition.accept(this);
        conditional.thenBranch.accept(this);
        conditional.elseBranch.accept(this);
        return null;
    }

    @Override
    public Object visitDynamicDispatch(DynamicDispatch dynDispatch) {
        dynDispatch.receiver.accept(this);
        for (Expr arg : dynDispatch.arguments) {
            arg.accept(this);
        }
        return null;
    }

    @Override
    public Object visitId(Id id) {
        return null;
    }

    @Override
    public Object visitIntConst(IntConst intConst) {
        // TODO: Add this int const to the pool
        return null;
    }

    @Override
    public Object visitIsVoid(IsVoid isVoid) {
        isVoid.expr.accept(this);
        return null;
    }

    @Override
    public Object visitLet(Let let) {
        if (let.initialization != null)
            let.initialization.accept(this);
        let.body.accept(this);
        return null;
    }

    @Override
    public Object visitLoop(Loop loop) {
        loop.condition.accept(this);
        loop.body.accept(this);
        return null;
    }

    @Override
    public Object visitNegation(Negation negation) {
        negation.expr.accept(this);
        return null;
    }

    @Override
    public Object visitNew(New newExpr) {
        return null;
    }

    @Override
    public Object visitNot(Not notExpr) {
        notExpr.expr.accept(this);
        return null;
    }

    @Override
    public Object visitStaticDispatch(StaticDispatch staticDispatch) {
        staticDispatch.receiver.accept(this);
        for (Expr arg : staticDispatch.arguments) {
            arg.accept(this);
        }
        return null;
    }

    @Override
    public Object visitStringConst(StringConst stringConst) {
        // TODO: Add this string const to the pool
        return null;
    }
}
