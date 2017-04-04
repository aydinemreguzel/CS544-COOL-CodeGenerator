package cool.util;

import cool.ast.Klass;
import cool.ast.Program;
import cool.parser.Parser;
import cool.scanner.Scanner;

/**
 * Populates a user-provided program with the definitions
 * of the builtin classes Object, Int, Bool, String, and IO.
 */
public class BuiltinPopulator {
    public void populate(Program program) {
        program.classes.add(objectClassDefinition());
        program.classes.add(intClassDefinition());
        program.classes.add(boolClassDefinition());
        program.classes.add(stringClassDefinition());
        program.classes.add(ioClassDefinition());
    }

    // Below are dummy definitions for the built-in classes.
    // We won't generate IR code for them; the corresponding IR code is already
    // manually prepared in the `builtin` folder.
    // Therefore, the method bodies below are dummy.
    // However, method signatures and method body types are correct and useful
    // for semantic analysis. Therefore, we keep these built-in class definitions
    // in the program AST.
    private static Klass objectClassDefinition() {
        String dummyDefinition =
                "class Object {" +
                        "  type_name(): String { \"\" };" +
                        "  abort(): Object { self };" +
                        "};";
        return parseClass(dummyDefinition);
    }

    private static Klass parseClass(String definition) {
        Scanner scanner = new Scanner(definition);
        Parser parser = new Parser(scanner.scanTokens());
        return parser.parseProgram().classes.get(0);
    }

    private static Klass intClassDefinition() {
        String dummyDefinition =
                "class Int { };";
        return parseClass(dummyDefinition);
    }

    private static Klass boolClassDefinition() {
        String dummyDefinition =
                "class Bool { };";
        return parseClass(dummyDefinition);
    }

    private static Klass stringClassDefinition() {
        String dummyDefinition =
                "class String {" +
                        "  length(): Int { 0 }; " +
                        "  concat(x: String): String { \"\" }; " +
                        "  substr(from: Int, len: Int): String { \"\" }; " +
                        "};";
        return parseClass(dummyDefinition);
    }
    private static Klass ioClassDefinition() {
        String dummyDefinition =
                "class IO {" +
                        "  out_string(x: String): IO { self }; " +
                        "  out_int(x: Int): IO { self }; " +
                        "  in_int(): Int { 0 }; " +
                        "};";
        return parseClass(dummyDefinition);
    }
}
