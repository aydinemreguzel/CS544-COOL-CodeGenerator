package cool.ast;

import cool.visitor.Visitor;
import java.util.List;

public class Klass {
    public final String name;
    public final String supername;
    public final List<Feature> features;

    public Klass(String name, String supername, List<Feature> features) {
        this.name = name;
        this.supername = supername;
        this.features = features;
    }
}
