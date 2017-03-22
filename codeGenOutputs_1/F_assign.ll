#name "codeGenInputs_1/F_assign.cl"
Program:
  Class: Main inherits Object
    Method: main (): Int
      Let: c: Int
        Int: 10
        Block: 
          Assign: c
            Int: 42
------------------------------------------
Exception in thread "main" java.lang.Error: Not implemented yet.
	at cool.visitor.CodeGenerator.visitLet(CodeGenerator.java:120)
	at cool.visitor.CodeGenerator.visitLet(CodeGenerator.java:18)
	at cool.ast.Let.accept(Let.java:20)
	at cool.visitor.CodeGenerator.visitMethod(CodeGenerator.java:55)
	at cool.ast.Method.accept(Method.java:21)
	at cool.visitor.CodeGenerator.emitClass(CodeGenerator.java:41)
	at cool.visitor.CodeGenerator.generate(CodeGenerator.java:33)
	at cool.Main.main(Main.java:52)
