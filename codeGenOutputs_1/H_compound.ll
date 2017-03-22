define i32 @Main_main() {
entry_1:
  %r1 = add i32 0, 0
  %r2 = alloca i32
  store i32 %r1, i32* %r2
  %r3 = add i32 0, 0
  %r4 = alloca i32
  store i32 %r3, i32* %r4
  br label %cond_2
cond_2:
  %r5 = load i32, i32* %r4
  %r6 = add i32 0, 5
  %r7 = icmp slt i32 %r5, %r6
  br i1 %r7, label %body_3, label %end_4
body_3:
  %r8 = add i32 0, 0
  %r9 = alloca i32
  store i32 %r8, i32* %r9
  br label %cond_5
cond_5:
  %r10 = load i32, i32* %r9
  %r11 = add i32 0, 4
  %r12 = icmp slt i32 %r10, %r11
  br i1 %r12, label %body_6, label %end_7
body_6:
  %r13 = load i32, i32* %r4
  %r14 = load i32, i32* %r9
  %r15 = icmp slt i32 %r13, %r14
  %r16 = alloca i32
  br i1 %r15, label %then_8, label %else_9
then_8:
  %r17 = load i32, i32* %r2
  %r18 = add i32 0, 4
  %r19 = add i32 %r17, %r18
  store i32 %r19, i32* %r2
  store i32 %r19, i32* %r16
  br label %ifend_10
else_9:
  %r20 = load i32, i32* %r4
  %r21 = load i32, i32* %r9
  %r22 = icmp eq i32 %r20, %r21
  %r23 = alloca i32
  br i1 %r22, label %then_11, label %else_12
then_11:
  %r24 = load i32, i32* %r2
  %r25 = add i32 0, 2
  %r26 = add i32 %r24, %r25
  store i32 %r26, i32* %r2
  store i32 %r26, i32* %r23
  br label %ifend_13
else_12:
  %r27 = load i32, i32* %r2
  %r28 = add i32 0, 1
  %r29 = add i32 %r27, %r28
  store i32 %r29, i32* %r2
  store i32 %r29, i32* %r23
  br label %ifend_13
ifend_13:
  %r30 = load i32, i32* %r23
  store i32 %r30, i32* %r16
  br label %ifend_10
ifend_10:
  %r31 = load i32, i32* %r16
  %r32 = load i32, i32* %r9
  %r33 = add i32 0, 1
  %r34 = add i32 %r32, %r33
  store i32 %r34, i32* %r9
  br label %cond_5
end_7:
  %r35 = add i32 0, 0
  %r36 = load i32, i32* %r4
  %r37 = add i32 0, 1
  %r38 = add i32 %r36, %r37
  store i32 %r38, i32* %r4
  br label %cond_2
end_4:
  %r39 = add i32 0, 0
  %r40 = load i32, i32* %r2
  ret i32 %r40
}
define i32 @main() {
  %r = call i32 @Main_main()
  ret i32 %r
}

