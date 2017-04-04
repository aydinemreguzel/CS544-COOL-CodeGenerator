package cool.ast;

public class BoolConst extends Expr {
    public final boolean value;

    public BoolConst(boolean value) {
        this.value = value;
    }

    @Override
    public <R> R accept(Visitor<R> visitor) {
        return visitor.visitBoolConst(this);
    }
}
