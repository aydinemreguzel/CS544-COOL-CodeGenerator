package cool.ast;

public class Conditional extends Expr {
    public final Expr condition;
    public final Expr thenBranch;
    public final Expr elseBranch;

    public Conditional(Expr condition, Expr thenBranch, Expr elseBranch) {
        this.condition = condition;
        this.thenBranch = thenBranch;
        this.elseBranch = elseBranch;
    }

    @Override
    public <R> R accept(Visitor<R> visitor) {
        return visitor.visitConditional(this);
    }
}
