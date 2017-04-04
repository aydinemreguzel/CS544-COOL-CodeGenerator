package cool.cgen;

import cool.ast.*;
import cool.util.Environment;

import java.util.*;

import static cool.sema.Type.SELF_TYPE;

public class DataLayout {
    private final ConstantPool constantPool;
    private final Environment<IRValue> env;
    private StringBuilder buffer;

    public DataLayout(ConstantPool constantPool, Environment<IRValue> environment) {
        this.constantPool = constantPool;
        this.env = environment;
    }

    public void emitInto(StringBuilder buffer) {
        this.buffer = buffer;
        emitln(";;;;;;;;;;;;;;;;;;;;;");
        emitln(";;;  DATA LAYOUT  ;;;");
        emitln(";;;;;;;;;;;;;;;;;;;;;");
        emitClassAndChildren(env.getRoot());
    }

    private void emitln(String s) {
        buffer.append(s + "\n");
    }

    private void emit(String s) {
        buffer.append(s);
    }

    // This recursive method traverses the inheritance tree in pre-order.
    // This makes class tag assignment straightforward;
    // simply increase the tag value for each visited class.
    private void emitClassAndChildren(Klass klass) {
        if (!env.isBuiltin(klass)) {
            emitLayout(klass);
            emitVTableDefinition(klass);
            emitNodeVTablePrototype(klass);
        }
        klass.children.forEach(c -> emitClassAndChildren(c));
    }

    private void emitLayout(Klass klass) {
        emitln("%" + klass.name + " = type {");
        emit("  %" + klass.name + "_vtable*");
        for (Field field : env.getFields(klass)) {
            String type = field.type.equals(SELF_TYPE) ? klass.name : field.type;
            emit(",\n  %" + type + "*");
        }
        emitln("\n}");
    }

    private void emitVTableDefinition(Klass klass) {
        emitln("%" + klass.name + "_vtable = type {");
        emitln("  i32, ;; class tag");
        emitln("  %String*, ;; type name");
        String selfType = "%" + klass.name + "*";
        emit("  " + selfType +" () *"); // constructor
        for (Method method : env.getMethods(klass)) {
            emit(",\n  " + llvmSignature(selfType, method));
        }
        emitln("\n}");
    }

    private String llvmSignature(String selfType, Method method) {
        StringJoiner params = new StringJoiner(", ");
        params.add(selfType); // implicit self
        for (Formal formal : method.formals) {
            params.add("%" + formal.type + "*");
        }

        String returnType = method.returnType.equals(SELF_TYPE) ? selfType : "%" + method.returnType + "*";
        return returnType + " (" + params + ")*";
    }

    private void emitNodeVTablePrototype(Klass klass) {
        String className = klass.name;
        emitln("@" + className + "_vtable_prototype = constant %" + className + "_vtable {");
        emitln("  i32 " + env.getClassTag(klass) + ",");
        emitln("  " + constantPool.getIRConstant(className).fullName() + ",");
        emit("  %" + className + "* () * @" + className + "_new");
        for (Method method : env.getMethods(klass)) {
            emit(",\n  " + vtableEntry(klass.name, method));
        }
        emitln("\n}");
    }

    private String vtableEntry(String selfName, Method method) {
        String selfType = "%" + selfName + "*";
        String ownerType = "%" + method.owner.name + "*";
        String desiredType = llvmSignature(selfType, method);
        String foundType = llvmSignature(ownerType, method);
        String llvmMethodName = " @" + method.owner.name + "_" + method.name;
        if (desiredType.equals(foundType))
            return desiredType + llvmMethodName;
        else
            return  desiredType + " bitcast (" + foundType + llvmMethodName + " to " + desiredType +")";
    }
}
