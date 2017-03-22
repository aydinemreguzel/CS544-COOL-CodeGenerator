package cool.ast;

import cool.visitor.Visitor;

public class StringConst extends Expr {
    public final String value;

    public StringConst(String value) {
        this.value = value;
    }

    @Override
    public <R> R accept(Visitor<R> visitor) {
        return visitor.visitStringConst(this);
    }
}
