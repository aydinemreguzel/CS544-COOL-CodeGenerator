package cool.ast;

import java.util.List;

public class Case extends Expr {
    public final Expr expr;
    public final List<Branch> branches;

    public Case(Expr expr, List<Branch> branches) {
        this.expr = expr;
        this.branches = branches;
    }

    @Override
    public <R> R accept(Visitor<R> visitor) {
        return visitor.visitCase(this);
    }
}
