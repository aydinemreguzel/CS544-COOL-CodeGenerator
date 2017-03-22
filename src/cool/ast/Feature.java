package cool.ast;

import cool.visitor.Visitor;

public abstract class Feature {
    public abstract void accept(Visitor<? extends Object> visitor);
}
