define i32 @Main_main() {
entry_1:
  %r1 = add i32 0, 10
  %r2 = alloca i32
  store i32 %r1, i32* %r2
  %r3 = add i32 0, 32
  %r4 = alloca i32
  store i32 %r3, i32* %r4
  %r5 = load i32, i32* %r2
  %r6 = load i32, i32* %r4
  %r7 = add i32 %r5, %r6
  ret i32 %r7
}
define i32 @main() {
  %r = call i32 @Main_main()
  ret i32 %r
}

