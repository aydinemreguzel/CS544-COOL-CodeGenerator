package cool.ast;

import cool.visitor.Visitor;
import java.util.List;

public class Program {
    public final List<Klass> classes;

    public Program(List<Klass> classes) {
        this.classes = classes;
    }
}
