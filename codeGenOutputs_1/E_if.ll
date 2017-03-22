define i32 @Main_main() {
entry_1:
  %r1 = add i32 0, 35
  %r2 = add i32 0, 42
  %r3 = icmp slt i32 %r1, %r2
  %r4 = alloca i32
  br i1 %r3, label %then_2, label %else_3
then_2:
  %r5 = add i32 0, 42
  %r6 = add i32 0, 35
  %r7 = icmp slt i32 %r5, %r6
  %r8 = alloca i32
  br i1 %r7, label %then_5, label %else_6
then_5:
  %r9 = add i32 0, 13
  store i32 %r9, i32* %r8
  br label %ifend_7
else_6:
  %r10 = add i32 0, 42
  store i32 %r10, i32* %r8
  br label %ifend_7
ifend_7:
  %r11 = load i32, i32* %r8
  store i32 %r11, i32* %r4
  br label %ifend_4
else_3:
  %r12 = add i32 0, 14
  store i32 %r12, i32* %r4
  br label %ifend_4
ifend_4:
  %r13 = load i32, i32* %r4
  ret i32 %r13
}
define i32 @main() {
  %r = call i32 @Main_main()
  ret i32 %r
}

