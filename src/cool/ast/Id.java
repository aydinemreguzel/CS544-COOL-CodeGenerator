package cool.ast;

public class Id extends Expr {
    public final String name;

    public Id(String name) {
        this.name = name;
    }

    @Override
    public <R> R accept(Visitor<R> visitor) {
        return visitor.visitId(this);
    }
}
