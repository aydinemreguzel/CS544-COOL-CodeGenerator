package cool.ast;

import java.util.List;

public class DynamicDispatch extends Expr {
    public final Expr receiver;
    public final String name;
    public final List<Expr> arguments;

    public DynamicDispatch(Expr receiver, String name, List<Expr> arguments) {
        this.receiver = receiver;
        this.name = name;
        this.arguments = arguments;
    }

    @Override
    public <R> R accept(Visitor<R> visitor) {
        return visitor.visitDynamicDispatch(this);
    }
}
