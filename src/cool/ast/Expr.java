package cool.ast;

import cool.visitor.Visitor;

public abstract class Expr {
    public abstract <R> R accept(Visitor<R> visitor);
}
