package cool.ast;

import java.util.List;

public class StaticDispatch extends Expr {
    public final Expr receiver;
    public final String targetClass;
    public final String name;
    public final List<Expr> arguments;

    public StaticDispatch(Expr receiver, String targetClass, String name, List<Expr> arguments) {
        this.receiver = receiver;
        this.targetClass = targetClass;
        this.name = name;
        this.arguments = arguments;
    }

    @Override
    public <R> R accept(Visitor<R> visitor) {
        return visitor.visitStaticDispatch(this);
    }
}
