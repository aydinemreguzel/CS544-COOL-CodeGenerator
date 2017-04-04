package cool.ast;

import java.util.List;

public class Method extends Feature {
    public final String name;
    public final List<Formal> formals;
    public final String returnType;
    public final Expr body;

    public Method(String name, List<Formal> formals, String returnType, Expr body) {
        this.name = name;
        this.formals = formals;
        this.returnType = returnType;
        this.body = body;
    }

    @Override
    public void accept(Visitor<? extends Object> visitor) {
        visitor.visitMethod(this);
    }
}
