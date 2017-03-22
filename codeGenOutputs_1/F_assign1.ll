define i32 @Main_main() {
entry_1:
  %r1 = add i32 0, 10
  %r2 = alloca i32
  store i32 %r1, i32* %r2
  %r3 = add i32 0, 42
  store i32 %r3, i32* %r2
  ret i32 %r3
}
define i32 @main() {
  %r = call i32 @Main_main()
  ret i32 %r
}

