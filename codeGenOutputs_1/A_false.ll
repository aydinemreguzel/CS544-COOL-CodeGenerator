define i32 @Main_main() {
entry_1:
  %r1 = or i1 0, 0
  %r2 = alloca i32
  br i1 %r1, label %then_2, label %else_3
then_2:
  %r3 = add i32 0, 13
  store i32 %r3, i32* %r2
  br label %ifend_4
else_3:
  %r4 = add i32 0, 42
  store i32 %r4, i32* %r2
  br label %ifend_4
ifend_4:
  %r5 = load i32, i32* %r2
  ret i32 %r5
}
define i32 @main() {
  %r = call i32 @Main_main()
  ret i32 %r
}

