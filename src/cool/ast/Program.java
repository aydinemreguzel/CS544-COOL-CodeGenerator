package cool.ast;

import java.util.List;
import java.util.Optional;

public class Program {
    public final List<Klass> classes;

    public Program(List<Klass> classes) {
        this.classes = classes;
    }

    public Klass root() {
        Optional<Klass> root = classes.stream().filter(k -> k.name.equals("Object")).findFirst();
        if (root.isPresent())
            return root.get();
        else {
            throw new Error("Root class Object is not available yet.");
        }
    }
}
