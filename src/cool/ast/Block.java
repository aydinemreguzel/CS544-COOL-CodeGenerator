package cool.ast;

import java.util.List;

public class Block extends Expr {
    public final List<Expr> exprs;

    public Block(List<Expr> exprs) {
        this.exprs = exprs;
    }

    @Override
    public <R> R accept(Visitor<R> visitor) {
        return visitor.visitBlock(this);
    }
}
