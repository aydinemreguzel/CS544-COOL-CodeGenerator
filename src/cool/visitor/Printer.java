package cool.visitor;

import cool.ast.*;

public class Printer implements Visitor<Object> {
    private int indentationLevel = 0;

    public void print(Program program) {
        System.out.println("Program:");
        indentationLevel++;
        for (Klass klass: program.classes) {
            printClass(klass);
        }
        indentationLevel--;
    }

    private void printClass(Klass klass) {
        indent();
        System.out.println("Class: " + klass.name + " inherits " + klass.supername);
        indentationLevel++;
        for(Feature feature: klass.features) {
            feature.accept(this);
        }
        indentationLevel--;
    }

    @Override
    public void visitField(Field field) {
        indent();
        System.out.println("Field: " + field.name + ": " + field.type);
        if (field.initialization != null) {
            indentationLevel++;
            field.initialization.accept(this);
            indentationLevel--;
        }
    }

    @Override
    public void visitMethod(Method method) {
        indent();
        System.out.print("Method: " + method.name);
        System.out.print(" (");
        for (Formal formal : method.formals) {
            formal.print();
            System.out.print(", ");
        }
        System.out.println("): " + method.returnType);
        indentationLevel++;
        method.body.accept(this);
        indentationLevel--;
    }

    @Override
    public Object visitAssignment(Assignment assignment) {
        indent();
        System.out.println("Assign: " + assignment.name);
        indentationLevel++;
        assignment.rhs.accept(this);
        indentationLevel--;
        return null;
    }

    @Override
    public Object visitBinary(Binary binary) {
        indent();
        System.out.println("Binary: " + binary.op);
        indentationLevel++;
        binary.left.accept(this);
        binary.right.accept(this);
        indentationLevel--;
        return null;
    }

    @Override
    public Object visitBlock(Block block) {
        indent();
        System.out.println("Block: ");
        indentationLevel++;
        for (Expr expr: block.exprs) {
            expr.accept(this);
        }
        indentationLevel--;
        return null;
    }

    @Override
    public Object visitBoolConst(BoolConst boolConst) {
        indent();
        System.out.println("Bool: " + boolConst.value);
        return null;
    }

    @Override
    public Object visitCase(Case caseExpr) {
        indent();;
        System.out.println("Case: ");
        indentationLevel++;
        caseExpr.expr.accept(this);
        for (Branch branch: caseExpr.branches) {
            indent();
            System.out.println("Branch: " + branch.name + ": " + branch.type);
            indentationLevel++;
            branch.expr.accept(this);
            indentationLevel--;
        }
        indentationLevel--;
        return null;
    }

    @Override
    public Object visitConditional(Conditional conditional) {
        indent();
        System.out.println("If:");
        indentationLevel++;
        conditional.condition.accept(this);
        conditional.thenBranch.accept(this);
        conditional.elseBranch.accept(this);
        indentationLevel--;
        return null;
    }

    @Override
    public Object visitDynamicDispatch(DynamicDispatch dynDispatch) {
        indent();
        System.out.println("DynDispatch: " + dynDispatch.name);
        indentationLevel++;
        dynDispatch.receiver.accept(this);
        for (Expr arg: dynDispatch.arguments) {
            arg.accept(this);
        }
        indentationLevel--;
        return null;
    }

    @Override
    public Object visitId(Id id) {
        indent();
        System.out.println("Id: " + id.name);
        return null;
    }

    @Override
    public Object visitIntConst(IntConst intConst) {
        indent();
        System.out.println("Int: " + intConst.value);
        return null;
    }

    @Override
    public Object visitIsVoid(IsVoid isVoid) {
        indent();
        System.out.println("IsVoid:");
        indentationLevel++;
        isVoid.expr.accept(this);
        indentationLevel--;
        return null;
    }

    @Override
    public Object visitLet(Let let) {
        indent();
        System.out.println("Let: " + let.name + ": " + let.type);
        indentationLevel++;
        if (let.initialization != null)
            let.initialization.accept(this);
        let.body.accept(this);
        indentationLevel--;
        return null;
    }

    @Override
    public Object visitLoop(Loop loop) {
        indent();
        System.out.println("Loop:");
        indentationLevel++;
        loop.condition.accept(this);
        loop.body.accept(this);
        indentationLevel--;
        return null;
    }

    @Override
    public Object visitNegation(Negation negation) {
        indent();
        System.out.println("Negate:");
        indentationLevel++;
        negation.expr.accept(this);
        indentationLevel--;
        return null;
    }

    @Override
    public Object visitNew(New newExpr) {
        indent();
        System.out.println("New: " + newExpr.type);
        return null;
    }

    @Override
    public Object visitNot(Not notExpr) {
        indent();
        System.out.println("Not:");
        indentationLevel++;
        notExpr.expr.accept(this);
        indentationLevel--;
        return null;
    }

    @Override
    public Object visitStaticDispatch(StaticDispatch staticDispatch) {
        indent();
        System.out.println("StaDispatch: " + staticDispatch.name + "@" + staticDispatch.targetClass);
        indentationLevel++;
        staticDispatch.receiver.accept(this);
        for (Expr arg: staticDispatch.arguments) {
            arg.accept(this);
        }
        indentationLevel--;
        return null;
    }

    @Override
    public Object visitStringConst(StringConst stringConst) {
        indent();
        System.out.println("String: \"" + stringConst.value + "\""); //TODO: Unescape the value
        return null;
    }

    private void indent() {
        for (int i = 0; i < indentationLevel; i++) {
            System.out.print("  ");
        }
    }
}
