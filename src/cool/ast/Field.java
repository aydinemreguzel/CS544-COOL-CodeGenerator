package cool.ast;

public class Field extends Feature {
    public final String name;
    public final String type;
    public final Expr initialization;

    public Field(String name, String type, Expr initialization) {
        this.name = name;
        this.type = type;
        this.initialization = initialization;
    }

    @Override
    public void accept(Visitor<? extends Object> visitor) {
        visitor.visitField(this);
    }
}
