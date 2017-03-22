define i32 @Main_main() {
entry_1:
  %r1 = add i32 0, 10
  %r2 = alloca i32
  store i32 %r1, i32* %r2
  %r3 = load i32, i32* %r2
  %r4 = add i32 0, 22
  %r5 = add i32 %r3, %r4
  %r6 = alloca i32
  store i32 %r5, i32* %r6
  %r7 = load i32, i32* %r2
  %r8 = load i32, i32* %r6
  %r9 = add i32 %r7, %r8
  %r10 = alloca i32
  store i32 %r9, i32* %r10
  %r11 = load i32, i32* %r10
  ret i32 %r11
}
define i32 @main() {
  %r = call i32 @Main_main()
  ret i32 %r
}

