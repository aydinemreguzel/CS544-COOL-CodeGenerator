package cool.ast;

public class Assignment extends Expr {
    public final String name;
    public final Expr rhs;

    public Assignment(String name, Expr rhs) {
        this.name = name;
        this.rhs = rhs;
    }

    @Override
    public <R> R accept(Visitor<R> visitor) {
        return visitor.visitAssignment(this);
    }
}
