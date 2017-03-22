package cool.ast;

import cool.visitor.Visitor;

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
