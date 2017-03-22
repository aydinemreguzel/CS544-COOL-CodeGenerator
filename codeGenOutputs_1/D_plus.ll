define i32 @Main_main() {
entry_1:
  %r1 = add i32 0, 15
  %r2 = add i32 0, 27
  %r3 = add i32 %r1, %r2
  ret i32 %r3
}
define i32 @main() {
  %r = call i32 @Main_main()
  ret i32 %r
}

