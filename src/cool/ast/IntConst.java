package cool.ast;

public class IntConst extends Expr {
    public final int value;

    public IntConst(int value) {
        this.value = value;
    }

    @Override
    public <R> R accept(Visitor<R> visitor) {
        return visitor.visitIntConst(this);
    }
}
