package cool.ast;

import cool.visitor.Visitor;

public class New extends Expr {
    public final String type;

    public New(String type) {
        this.type = type;
    }

    @Override
    public <R> R accept(Visitor<R> visitor) {
        return visitor.visitNew(this);
    }
}
