package cool.ast;

public class Branch {
    public final String name;
    public final String type;
    public final Expr expr;

    public Branch(String name, String type, Expr expr) {
        this.name = name;
        this.type = type;
        this.expr = expr;
    }
}
