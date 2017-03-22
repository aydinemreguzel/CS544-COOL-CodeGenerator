define i32 @Main_main() {
entry_1:
  %r1 = add i32 0, 6
  %r2 = add i32 0, 3
  %r3 = add i32 0, 5
  %r4 = add i32 0, 9
  %r5 = add i32 %r3, %r4
  %r6 = mul i32 %r2, %r5
  %r7 = add i32 %r1, %r6
  %r8 = add i32 0, 18
  %r9 = add i32 0, 3
  %r10 = sdiv i32 %r8, %r9
  %r11 = sub i32 %r7, %r10
  ret i32 %r11
}
define i32 @main() {
  %r = call i32 @Main_main()
  ret i32 %r
}

