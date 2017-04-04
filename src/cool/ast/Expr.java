package cool.ast;

import cool.sema.Type;

public abstract class Expr {
    public Type type;
    public abstract <R> R accept(Visitor<R> visitor);
}
