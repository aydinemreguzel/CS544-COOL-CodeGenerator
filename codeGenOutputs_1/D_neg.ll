define i32 @Main_main() {
entry_1:
  %r3 = add i32 0, 42
  %r2 = sub i32 0, %r3
  %r1 = sub i32 0, %r2
  ret i32 %r1
}
define i32 @main() {
  %r = call i32 @Main_main()
  ret i32 %r
}

