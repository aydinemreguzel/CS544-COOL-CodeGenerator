package cool;

import cool.ast.Program;
import cool.parser.Parser;
import cool.scanner.*;
import cool.cgen.CodeGenerator;
import cool.sema.*;
import cool.util.BuiltinPopulator;
import cool.util.Printer;

import java.io.*;
import java.util.LinkedList;
import java.nio.file.*;
import java.nio.charset.Charset;

public class Main {
    public static void main(String[] args) throws IOException {
        String source = "";
        if (args.length > 1) {
            System.out.println("Usage: Main [filename]");
        } else if (args.length == 1) {
            String path = args[0];
            byte[] bytes = Files.readAllBytes(Paths.get(path));
            source = new String(bytes, Charset.defaultCharset());
        } else {
            System.out.print("> ");

            InputStreamReader input = new InputStreamReader(System.in);
            BufferedReader reader = new BufferedReader(input);
            source = reader.readLine();
        }

        try {
            Scanner scanner = new Scanner(source);
            LinkedList<Token> tokens = scanner.scanTokens();
            Parser parser = new Parser(tokens);
            Program program = parser.parseProgram();

            // Add the built-in class definitions for semantic analysis
            BuiltinPopulator populator = new BuiltinPopulator();
            populator.populate(program);

            // Run semantic analysis.
            // If there is a semantic problem, an Error will be thrown.
            // Otherwise, the type checker annotates the AST with type information.
            SemanticAnalyzer analyzer = new SemanticAnalyzer();
            analyzer.analyze(program);

            // At this point, the 'program' has been type-annotated,
            // and all child-parent links between classes have been set.
            // The "root" of the inheritance can be used to access anywhere in the program.
            CodeGenerator generator = new CodeGenerator(program.root());
            String irCode = generator.generate();
            // For simplicity, the generated code is stored as a String.
            // Ideally we would store it in a data structure that's appropriate
            // for further processing.
            // E.g.: LLVM keeps an IR as a graph of basic blocks.

            System.out.println(irCode);
        } catch (Error error) {
            System.err.println("ERROR: " + error.getMessage());
        }
    }
}