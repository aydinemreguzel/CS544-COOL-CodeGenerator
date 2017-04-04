package cool.ast;

public class Let extends Expr {
    public final String name;
    public final String className;
    public final Expr initialization;
    public final Expr body;

    public Let(String name, String className, Expr initialization, Expr body) {
        this.name = name;
        this.className = className;
        this.initialization = initialization;
        this.body = body;
    }

    @Override
    public <R> R accept(Visitor<R> visitor) {
        return visitor.visitLet(this);
    }
}
