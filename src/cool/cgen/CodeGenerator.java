package cool.cgen;

import cool.ast.*;
import cool.util.Environment;

public class CodeGenerator {
    private final Klass root;

    public CodeGenerator(Klass root) {
        this.root = root;
    }

    public String generate() {
        StringBuilder buffer = new StringBuilder();

        Environment<IRValue> environment = new Environment<>(root);

        ConstantPool constantPool = new ConstantPool(environment);
        constantPool.emitInto(buffer);

        DataLayout dataLayout = new DataLayout(constantPool, environment);
        dataLayout.emitInto(buffer);

        CodeEmitter emitter = new CodeEmitter(constantPool, environment);
        emitter.emitInto(buffer);

        return buffer.toString();
    }
}
