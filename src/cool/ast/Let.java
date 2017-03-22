package cool.ast;

import cool.visitor.Visitor;

public class Let extends Expr {
    public final String name;
    public final String type;
    public final Expr initialization;
    public final Expr body;

    public Let(String name, String type, Expr initialization, Expr body) {
        this.name = name;
        this.type = type;
        this.initialization = initialization;
        this.body = body;
    }

    @Override
    public <R> R accept(Visitor<R> visitor) {
        return visitor.visitLet(this);
    }
}
