package cool.cgen;

import cool.ast.StringConst;

public abstract class IRValue {
    private String type;

    protected IRValue(String llvmType) {
        this.type = llvmType;
    }

    public String getType() {
        return type;
    }

    public String getBaseType() {
        if (type.charAt(type.length()-1) != '*') {
            throw new Error("Cannot get base type of the non-pointer type " + type);
        }
        return type.substring(0, type.length()-1);
    }

    public abstract String name();

    public String fullName() {
        return getType() + " " + name();
    }

    @Override
    public String toString() {
        return name();
    }
}

// This simple class represents the virtual registers in LLVM IR
class IRReg extends IRValue {
    private final String name;

    IRReg(String llvmType, String name) {
        super(llvmType);
        this.name = name;
    }

    @Override
    public String name() {
        return name;
    }
}

abstract class IRConstant extends IRValue {
    protected IRConstant(String llvmType) {
        super(llvmType);
    }

    abstract void emitInto(StringBuilder buffer);
}

// This class represents the null value for the given type
class IRNull extends IRValue {
    IRNull(String llvmType) {
        super(llvmType);
    }

    @Override
    public String name() {
        return "null";
    }
}

class IRIntConstant extends IRConstant {
    private int value;

    public IRIntConstant(int value) {
        super("%Int*");
        this.value = value;
    }

    @Override
    void emitInto(StringBuilder buffer) {
        buffer.append(name() + " = constant %Int {\n" +
                      "  %Int_vtable* @Int_vtable_prototype,\n" +
                      "  i32 " + value + "\n" +
                      "}\n");
    }

    @Override
    public String name() {
        return "@int_" + value;
    }

    @Override
    public boolean equals(Object obj) {
        if (obj instanceof IRIntConstant)
            return this.value == ((IRIntConstant)obj).value;
        else
            return false;
    }
}

class IRBoolConstant extends IRConstant {
    private boolean value;

    public IRBoolConstant(boolean value) {
        super("%Bool*");
        this.value = value;
    }

    @Override
    void emitInto(StringBuilder buffer) {
        buffer.append(name() + " = constant %Bool {\n" +
                "  %Bool_vtable* @Bool_vtable_prototype,\n" +
                "  i1 " + (value ? 1 : 0) + "\n" +
                "}\n");
    }

    @Override
    public String name() {
        return "@bool_" + value;
    }

    @Override
    public boolean equals(Object obj) {
        if (obj instanceof IRBoolConstant)
            return this.value == ((IRBoolConstant)obj).value;
        else
            return false;
    }
}

class IRStringConstant extends IRConstant {
    private String value;
    private int id;

    public IRStringConstant(String value, int id) {
        super("%String*");
        this.value = value;
        this.id = id;
    }

    @Override
    void emitInto(StringBuilder buffer) {
        int len = value.length();
        int lenp1 = len + 1;
        buffer.append("\n");
        buffer.append("@str_" + id + " = constant [" + lenp1 + " x i8] c\"" + StringConst.unescape(value) + "\\00\";\n");
        buffer.append(name() + " = constant %String {\n" +
                "  %String_vtable* @String_vtable_prototype,\n" +
                "  i32 " + len + ",\n" +
                "  i8* getelementptr (["+ lenp1 + " x i8], [" + lenp1 + " x i8]* @str_" + id + ", i32 0, i32 0)\n" +
                "}\n");
    }

    @Override
    public String name() {
        return "@string_" + id;
    }

    @Override
    public boolean equals(Object obj) {
        if (obj instanceof IRStringConstant)
            return this.value.equals(((IRStringConstant)obj).value);
        else
            return false;
    }
}
