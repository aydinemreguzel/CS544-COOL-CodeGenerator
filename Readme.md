# CS544 Compilers

Starter code for a code generator from [Cool](http://theory.stanford.edu/~aiken/software/cool/cool.html)
to LLVM IR.

Scanner is at <http://github.com/aktemur/CS544-COOL-Scanner>.

Parser is at <http://github.com/aktemur/CS544-COOL-Parser>.

## General Flow

First of all, take a look at the [Main file](src/coolMain.java).
After we parse a given text and build an AST,
[we populate the program](src/cool/Main.java#L40) with built-in class
definitions. This way, we obtain a fully closed program.
We then [pass the program through semantic analysis](src/cool/Main.java#L46)
If no semantic errors are detected (e.g. type errors, circular inheritance, etc.)
semantic analysis build **an inheritance tree**.
At this point, we can refer to the whole program using only its **root**,
that is, the `Object` class.

Given a `Klass`, you can access its child classes via the `children` field,
 and it parent via the `parent` field.
 
[CodeGenerator](src/cool/cgen/CodeGenerator.java) takes the program root,
 and generates LLVM IR code. For this, the following steps are taken
 as can be seen in the `generate()` method of `CodeGenerator`:
 
 * Build an `Environment`.
 * Build a pool of the constants that appear in the program. 
   Emit the constants to the outputs.
 * Determine the data layout and vtables for the classes.
   Emit these definitions.
 * Generate IR code for the methods (including the constructor) for all the classes.
 
 No code for built-in classes is emitted. For these, we use the 
 manually-written [builtin.ll](builtin/builtin.ll) file.
 
## Tasks
 
Several spots in the code has been left incomplete.
Your assignment is to complete these. Look for the `TODO` comments
in the following files:

* [Environment.java](src/cool/util/Environment.java)
* [ConstantPool.java](src/cool/cgen/ConstantPool.java)
* [CodeEmitter.java](src/cool/cgen/CodeEmitter.java)
  
The provided code has been commented in various places.
Do NOT blindly start coding right away.
Make sure to spend a good amount of time reading and navigating the given code.

**START EARLY!!!** This is not a trivial assignment.
It will likely take several days for you to complete it.
But the experience and the joy you will gain is priceless!

## Tests

As usual, you've been given many test cases with expected outputs.
Frequently check the provided `.ll` outputs to understand what's going on.

## Execution

To run a particular file, emit a `.ll` file, than append it to the `builtin.ll`
file, and finally feed it to `lli`.
E.g. in the root folder of this project, run the following command
to execute the `1_constInt.cl` program:

```
java -cp out/production/CS544-COOL-CodeGenerator/:libs/obf-cool.jar:$CLASSPATH cool.Main tests/codeGenInputs/1_constInt.cl | cat builtin/builtin.ll - | lli
```




