define i32 @Main_main() {
entry_1:
  %r2 = or i1 0, 0
  %r1 = sub i1 1, %r2
  %r3 = alloca i32
  br i1 %r1, label %then_2, label %else_3
then_2:
  %r4 = add i32 0, 42
  store i32 %r4, i32* %r3
  br label %ifend_4
else_3:
  %r5 = add i32 0, 13
  store i32 %r5, i32* %r3
  br label %ifend_4
ifend_4:
  %r6 = load i32, i32* %r3
  ret i32 %r6
}
define i32 @main() {
  %r = call i32 @Main_main()
  ret i32 %r
}

