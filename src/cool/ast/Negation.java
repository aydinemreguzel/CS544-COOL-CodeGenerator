package cool.ast;

import cool.visitor.Visitor;

public class Negation extends Expr {
    public final Expr expr;

    public Negation(Expr expr) {
        this.expr = expr;
    }

    @Override
    public <R> R accept(Visitor<R> visitor) {
        return visitor.visitNegation(this);
    }
}
