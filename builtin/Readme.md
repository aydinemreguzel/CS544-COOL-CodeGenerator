## Built-in class definitions

LLVM IR definitions for the five built-in classes of Cool.

To run a program (e.g. `sampleprogram.ll`), append the program to
`builtin.ll` and feed the result to `lli`:

```
cat builtin.ll sampleprogram.ll | lli
```
