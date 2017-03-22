package cool;

import cool.ast.Program;
import cool.parser.Parser;
import cool.scanner.Scanner;
import cool.scanner.Token;
import cool.visitor.CodeGenerator;
import cool.visitor.Printer;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.LinkedList;
import java.nio.file.Files;
import java.nio.file.Paths;
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

        Scanner scanner = new Scanner(source);
        LinkedList<Token> tokens = scanner.scanTokens();
        Parser parser = new Parser(tokens);
        Program program = parser.parseProgram();

        // Normally, we should run semantic analysis (e.g. type checking)
        // over 'program' at this point. However, we don't have enough time
        // to cover this topic. So, we skip semantic analysis and directly
        // go to code generation, assuming that the input program does
        // not have semantic errors (i.e. it's compilable).

        CodeGenerator codeGen = new CodeGenerator(program);
        String irCode = codeGen.generate();
        // For simplicity, the generated code is stored as a String.
        // Ideally we would store it in a data structure that's appropriate
        // for further processing.
        // E.g.: LLVM keeps an IR as a graph of basic blocks.
        System.out.println(irCode);
    }
}