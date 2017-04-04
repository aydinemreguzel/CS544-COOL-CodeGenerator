package cool.ast;

public class Loop extends Expr {
    public final Expr condition;
    public final Expr body;

    public Loop(Expr condition, Expr body) {
        this.condition = condition;
        this.body = body;
    }

    @Override
    public <R> R accept(Visitor<R> visitor) {
        return visitor.visitLoop(this);
    }
}
