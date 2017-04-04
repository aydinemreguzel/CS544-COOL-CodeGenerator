package cool.util;

import cool.ast.*;

public class Printer implements Visitor<Object> {
    private int indentationLevel = 0;

    public void print(Program program) {
        System.out.println("Program:");
        indentationLevel++;
        for (Klass klass: program.classes) {
            klass.accept(this);
        }
        indentationLevel--;
    }

    @Override
    public void visitClass(Klass klass) {
        if (!isBuiltin(klass)) {
            indent();
            System.out.println("Class: " + klass.name + " inherits " + klass.supername);
            indentationLevel++;
            klass.features.stream().forEachOrdered(f -> f.accept(this));
            indentationLevel--;
        }
        klass.children.stream().forEachOrdered(c -> c.accept(this));
    }

    private boolean isBuiltin(Klass klass) {
        return  "Object".equals(klass.name) ||
                "Int".equals(klass.name) ||
                "Bool".equals(klass.name) ||
                "String".equals(klass.name) ||
                "IO".equals(klass.name);
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

    private String typeinfo(Expr expr) {
        if (expr.type == null) return "";
        return " [" + expr.type + "]";
    }
    @Override
    public Object visitAssignment(Assignment assignment) {
        indent();
        System.out.println("Assign: " + assignment.name + typeinfo(assignment));
        indentationLevel++;
        assignment.rhs.accept(this);
        indentationLevel--;
        return null;
    }

    @Override
    public Object visitBinary(Binary binary) {
        indent();
        System.out.println("Binary: " + binary.op + typeinfo(binary));
        indentationLevel++;
        binary.left.accept(this);
        binary.right.accept(this);
        indentationLevel--;
        return null;
    }

    @Override
    public Object visitBlock(Block block) {
        indent();
        System.out.println("Block: " + typeinfo(block));
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
        System.out.println("Bool: " + boolConst.value + typeinfo(boolConst));
        return null;
    }

    @Override
    public Object visitCase(Case caseExpr) {
        indent();;
        System.out.println("Case: " + typeinfo(caseExpr));
        indentationLevel++;
        caseExpr.expr.accept(this);
        for (Branch branch: caseExpr.branches) {
            indent();
            System.out.println("Branch: " + branch.name + ": " + branch.className);
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
        System.out.println("If:" + typeinfo(conditional));
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
        System.out.println("DynDispatch: " + dynDispatch.name + typeinfo(dynDispatch));
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
        System.out.println("Id: " + id.name + typeinfo(id));
        return null;
    }

    @Override
    public Object visitIntConst(IntConst intConst) {
        indent();
        System.out.println("Int: " + intConst.value + typeinfo(intConst));
        return null;
    }

    @Override
    public Object visitIsVoid(IsVoid isVoid) {
        indent();
        System.out.println("IsVoid:" + typeinfo(isVoid));
        indentationLevel++;
        isVoid.expr.accept(this);
        indentationLevel--;
        return null;
    }

    @Override
    public Object visitLet(Let let) {
        indent();
        System.out.println("Let: " + let.name + ": " + let.className + typeinfo(let));
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
        System.out.println("Loop:" + typeinfo(loop));
        indentationLevel++;
        loop.condition.accept(this);
        loop.body.accept(this);
        indentationLevel--;
        return null;
    }

    @Override
    public Object visitNegation(Negation negation) {
        indent();
        System.out.println("Negate:" + typeinfo(negation));
        indentationLevel++;
        negation.expr.accept(this);
        indentationLevel--;
        return null;
    }

    @Override
    public Object visitNew(New newExpr) {
        indent();
        System.out.println("New: " + newExpr.className + typeinfo(newExpr));
        return null;
    }

    @Override
    public Object visitNot(Not notExpr) {
        indent();
        System.out.println("Not:" + typeinfo(notExpr));
        indentationLevel++;
        notExpr.expr.accept(this);
        indentationLevel--;
        return null;
    }

    @Override
    public Object visitStaticDispatch(StaticDispatch staticDispatch) {
        indent();
        System.out.println("StaDispatch: " + staticDispatch.name + "@" + staticDispatch.targetClass + typeinfo(staticDispatch));
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
        System.out.println("String: \"" + stringConst.unescaped() + "\"" + typeinfo(stringConst));
        return null;
    }

    private void indent() {
        for (int i = 0; i < indentationLevel; i++) {
            System.out.print("  ");
        }
    }
}
