package cool.ast;

public class Formal {
    public final String name;
    public final String type;

    public Formal(String name, String type) {
        this.name = name;
        this.type = type;
    }

    public void print() {
        System.out.print(name + ": " + type);
    }
}
