define i32 @Main_main() {
entry_1:
  %r1 = add i32 0, 42
  ret i32 %r1
}
define i32 @main() {
  %r = call i32 @Main_main()
  ret i32 %r
}

