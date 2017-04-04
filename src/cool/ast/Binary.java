package cool.ast;

public class Binary extends Expr {
    public final BinaryOperator op;
    public final Expr left;
    public final Expr right;

    public Binary(BinaryOperator op, Expr left, Expr right) {
        this.op = op;
        this.left = left;
        this.right = right;
    }

    @Override
    public <R> R accept(Visitor<R> visitor) {
        return visitor.visitBinary(this);
    }
}
