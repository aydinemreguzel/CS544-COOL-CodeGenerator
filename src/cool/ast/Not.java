package cool.ast;

import cool.visitor.Visitor;

public class Not extends Expr {
    public final Expr expr;

    public Not(Expr expr) {
        this.expr = expr;
    }

    @Override
    public <R> R accept(Visitor<R> visitor) {
        return visitor.visitNot(this);
    }
}
