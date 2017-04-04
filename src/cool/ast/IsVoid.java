package cool.ast;

public class IsVoid extends Expr {
    public final Expr expr;

    public IsVoid(Expr expr) {
        this.expr = expr;
    }

    @Override
    public <R> R accept(Visitor<R> visitor) {
        return visitor.visitIsVoid(this);
    }
}
