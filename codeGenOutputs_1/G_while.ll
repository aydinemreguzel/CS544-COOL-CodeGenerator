define i32 @Main_main() {
entry_1:
  %r1 = add i32 0, 0
  %r2 = alloca i32
  store i32 %r1, i32* %r2
  br label %cond_2
cond_2:
  %r3 = load i32, i32* %r2
  %r4 = add i32 0, 40
  %r5 = icmp slt i32 %r3, %r4
  br i1 %r5, label %body_3, label %end_4
body_3:
  %r6 = load i32, i32* %r2
  %r7 = add i32 0, 10
  %r8 = add i32 %r6, %r7
  store i32 %r8, i32* %r2
  br label %cond_2
end_4:
  %r9 = add i32 0, 0
  %r10 = load i32, i32* %r2
  %r11 = add i32 0, 2
  %r12 = add i32 %r10, %r11
  ret i32 %r12
}
define i32 @main() {
  %r = call i32 @Main_main()
  ret i32 %r
}

