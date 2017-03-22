define i32 @Main_main() {
entry_1:
  %r1 = add i32 0, 10
  %r2 = alloca i32
  store i32 %r1, i32* %r2
  %r3 = add i32 0, 10
  store i32 %r3, i32* %r2
  %r4 = load i32, i32* %r2
  %r5 = add i32 0, 7
  %r6 = add i32 %r4, %r5
  store i32 %r6, i32* %r2
  %r7 = load i32, i32* %r2
  %r8 = load i32, i32* %r2
  %r9 = add i32 0, 8
  %r10 = add i32 %r8, %r9
  store i32 %r10, i32* %r2
  %r11 = load i32, i32* %r2
  %r12 = add i32 %r7, %r11
  ret i32 %r12
}
define i32 @main() {
  %r = call i32 @Main_main()
  ret i32 %r
}

