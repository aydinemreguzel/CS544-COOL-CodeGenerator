define i32 @Main_main() {
entry_1:
  %r1 = add i32 0, 35
  %r2 = add i32 0, 35
  %r3 = icmp sle i32 %r1, %r2
  %r4 = alloca i32
  br i1 %r3, label %then_2, label %else_3
then_2:
  %r5 = add i32 0, 42
  store i32 %r5, i32* %r4
  br label %ifend_4
else_3:
  %r6 = add i32 0, 13
  store i32 %r6, i32* %r4
  br label %ifend_4
ifend_4:
  %r7 = load i32, i32* %r4
  ret i32 %r7
}
define i32 @main() {
  %r = call i32 @Main_main()
  ret i32 %r
}

