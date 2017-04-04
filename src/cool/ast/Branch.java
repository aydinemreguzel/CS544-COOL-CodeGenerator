package cool.ast;

public class Branch {
    public final String name;
    public final String className;
    public final Expr expr;

    public Branch(String name, String className, Expr expr) {
        this.name = name;
        this.className = className;
        this.expr = expr;
    }
}
