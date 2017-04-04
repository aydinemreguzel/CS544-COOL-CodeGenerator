package cool.ast;

public abstract class Feature {
    public Klass owner;
    public abstract void accept(Visitor<? extends Object> visitor);
}
