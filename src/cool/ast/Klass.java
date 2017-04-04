package cool.ast;

import java.util.LinkedList;
import java.util.List;

public class Klass {
    public final String name;
    public final String supername;
    public final List<Feature> features;
    public List<Klass> children;
    public Klass parent;

    public Klass(String name, String supername, List<Feature> features) {
        this.name = name;
        this.supername = supername;
        this.features = features;
        for (Feature f : features)
            f.owner = this;
        // The fields below are set after some sanity checks in Semantic Analysis
        this.children = new LinkedList<>();
        this.parent = null;
    }

    public void addChild(Klass child) {
        children.add(child);
        child.parent = this;
    }

    public void accept(Visitor<? extends Object> visitor) {
        visitor.visitClass(this);
    }
}
