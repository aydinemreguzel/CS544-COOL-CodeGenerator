package cool.ast;

public class New extends Expr {
    public final String className;

    public New(String className) {
        this.className = className;
    }

    @Override
    public <R> R accept(Visitor<R> visitor) {
        return visitor.visitNew(this);
    }
}
