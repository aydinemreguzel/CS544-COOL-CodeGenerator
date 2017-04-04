package cool.ast;

public interface Visitor<R> {
    void visitClass(Klass klass);
    void visitField(Field field);
    void visitMethod(Method method);

    // Expr's
    R visitAssignment(Assignment assignment);
    R visitBinary(Binary binary);
    R visitBlock(Block block);
    R visitBoolConst(BoolConst boolConst);
    R visitCase(Case expr);
    R visitConditional(Conditional conditional);
    R visitDynamicDispatch(DynamicDispatch dynDispatch);
    R visitId(Id id);
    R visitIntConst(IntConst intConst);
    R visitIsVoid(IsVoid isVoid);
    R visitLet(Let let);
    R visitLoop(Loop loop);
    R visitNegation(Negation negation);
    R visitNew(New expr);
    R visitNot(Not expr);
    R visitStaticDispatch(StaticDispatch staticDispatch);
    R visitStringConst(StringConst stringConst);
}
