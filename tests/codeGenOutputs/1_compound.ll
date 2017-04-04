;;;;;;;;;;;;;;;;;;;;;
;;; CONSTANT POOL ;;;
;;;;;;;;;;;;;;;;;;;;;
@bool_false = constant %Bool {
  %Bool_vtable* @Bool_vtable_prototype,
  i1 0
}
@bool_true = constant %Bool {
  %Bool_vtable* @Bool_vtable_prototype,
  i1 1
}
@int_0 = constant %Int {
  %Int_vtable* @Int_vtable_prototype,
  i32 0
}
@int_1 = constant %Int {
  %Int_vtable* @Int_vtable_prototype,
  i32 1
}
@int_2 = constant %Int {
  %Int_vtable* @Int_vtable_prototype,
  i32 2
}
@int_4 = constant %Int {
  %Int_vtable* @Int_vtable_prototype,
  i32 4
}
@int_5 = constant %Int {
  %Int_vtable* @Int_vtable_prototype,
  i32 5
}

@str_0 = constant [1 x i8] c"\00";
@string_0 = constant %String {
  %String_vtable* @String_vtable_prototype,
  i32 0,
  i8* getelementptr ([1 x i8], [1 x i8]* @str_0, i32 0, i32 0)
}

@str_1 = constant [5 x i8] c"Main\00";
@string_1 = constant %String {
  %String_vtable* @String_vtable_prototype,
  i32 4,
  i8* getelementptr ([5 x i8], [5 x i8]* @str_1, i32 0, i32 0)
}
;;;;;;;;;;;;;;;;;;;;;
;;;  DATA LAYOUT  ;;;
;;;;;;;;;;;;;;;;;;;;;
%Main = type {
  %Main_vtable*
}
%Main_vtable = type {
  i32, ;; class tag
  %String*, ;; type name
  %Main* () *,
  %String* (%Main*)*,
  %Object* (%Main*)*,
  %Int* (%Main*)*
}
@Main_vtable_prototype = constant %Main_vtable {
  i32 5,
  %String* @string_1,
  %Main* () * @Main_new,
  %String* (%Main*)* bitcast (%String* (%Object*)* @Object_type_name to %String* (%Main*)*),
  %Object* (%Main*)* bitcast (%Object* (%Object*)* @Object_abort to %Object* (%Main*)*),
  %Int* (%Main*)* @Main_main
}
;;;;;;;;;;;;;;;;;;;;;
;;;    METHODS    ;;;
;;;;;;;;;;;;;;;;;;;;;
define %Main* @Main_new() {
  %r0 = call i8* @malloc(i64 8)
  %r1 = bitcast i8* %r0 to %Main*
  ;; setting vtable
  %r2 = getelementptr %Main, %Main* %r1, i32 0, i32 0
  store %Main_vtable* @Main_vtable_prototype, %Main_vtable** %r2
  ret %Main* %r1
}

define %Int* @Main_main(%Main* %self) {
entry_0:
  %r0 = alloca %Int*
  store %Int* @int_0, %Int** %r0
  %r1 = alloca %Int*
  store %Int* @int_0, %Int** %r1
  br label %cond_1
cond_1:
  %r2 = load %Int*, %Int** %r1
  ;; unboxing %Int* %r2
  %r3 = getelementptr %Int, %Int* %r2, i32 0, i32 1
  %r4 = load i32, i32* %r3
  ;; unboxing %Int* @int_5
  %r5 = getelementptr %Int, %Int* @int_5, i32 0, i32 1
  %r6 = load i32, i32* %r5
  %r7 = icmp slt i32 %r4, %r6
  ;; boxing i1 %r7
  %r8 = call %Bool* @Bool_new()
  %r9 = getelementptr %Bool, %Bool* %r8, i32 0, i32 1
  store i1 %r7, i1* %r9
  ;; unboxing %Bool* %r8
  %r10 = getelementptr %Bool, %Bool* %r8, i32 0, i32 1
  %r11 = load i1, i1* %r10
  br i1 %r11, label %body_2, label %end_3
body_2:
  %r12 = alloca %Int*
  store %Int* @int_0, %Int** %r12
  br label %cond_4
cond_4:
  %r13 = load %Int*, %Int** %r12
  ;; unboxing %Int* %r13
  %r14 = getelementptr %Int, %Int* %r13, i32 0, i32 1
  %r15 = load i32, i32* %r14
  ;; unboxing %Int* @int_4
  %r16 = getelementptr %Int, %Int* @int_4, i32 0, i32 1
  %r17 = load i32, i32* %r16
  %r18 = icmp slt i32 %r15, %r17
  ;; boxing i1 %r18
  %r19 = call %Bool* @Bool_new()
  %r20 = getelementptr %Bool, %Bool* %r19, i32 0, i32 1
  store i1 %r18, i1* %r20
  ;; unboxing %Bool* %r19
  %r21 = getelementptr %Bool, %Bool* %r19, i32 0, i32 1
  %r22 = load i1, i1* %r21
  br i1 %r22, label %body_5, label %end_6
body_5:
  %r23 = load %Int*, %Int** %r1
  %r24 = load %Int*, %Int** %r12
  ;; unboxing %Int* %r23
  %r25 = getelementptr %Int, %Int* %r23, i32 0, i32 1
  %r26 = load i32, i32* %r25
  ;; unboxing %Int* %r24
  %r27 = getelementptr %Int, %Int* %r24, i32 0, i32 1
  %r28 = load i32, i32* %r27
  %r29 = icmp slt i32 %r26, %r28
  ;; boxing i1 %r29
  %r30 = call %Bool* @Bool_new()
  %r31 = getelementptr %Bool, %Bool* %r30, i32 0, i32 1
  store i1 %r29, i1* %r31
  ;; emitting an 'if'
  %r32 = alloca %Int*
  ;; unboxing %Bool* %r30
  %r33 = getelementptr %Bool, %Bool* %r30, i32 0, i32 1
  %r34 = load i1, i1* %r33
  br i1 %r34, label %then_7, label %else_8
then_7:
  %r35 = load %Int*, %Int** %r0
  ;; unboxing %Int* %r35
  %r36 = getelementptr %Int, %Int* %r35, i32 0, i32 1
  %r37 = load i32, i32* %r36
  ;; unboxing %Int* @int_4
  %r38 = getelementptr %Int, %Int* @int_4, i32 0, i32 1
  %r39 = load i32, i32* %r38
  %r40 = add i32 %r37, %r39
  ;; boxing i32 %r40
  %r41 = call %Int* @Int_new()
  %r42 = getelementptr %Int, %Int* %r41, i32 0, i32 1
  store i32 %r40, i32* %r42
  store %Int* %r41, %Int** %r0
  store %Int* %r41, %Int** %r32
  br label %ifend_9
else_8:
  %r43 = load %Int*, %Int** %r1
  %r44 = load %Int*, %Int** %r12
  ;; unboxing %Int* %r43
  %r45 = getelementptr %Int, %Int* %r43, i32 0, i32 1
  %r46 = load i32, i32* %r45
  ;; unboxing %Int* %r44
  %r47 = getelementptr %Int, %Int* %r44, i32 0, i32 1
  %r48 = load i32, i32* %r47
  %r49 = icmp eq i32 %r46, %r48
  ;; boxing i1 %r49
  %r50 = call %Bool* @Bool_new()
  %r51 = getelementptr %Bool, %Bool* %r50, i32 0, i32 1
  store i1 %r49, i1* %r51
  ;; emitting an 'if'
  %r52 = alloca %Int*
  ;; unboxing %Bool* %r50
  %r53 = getelementptr %Bool, %Bool* %r50, i32 0, i32 1
  %r54 = load i1, i1* %r53
  br i1 %r54, label %then_10, label %else_11
then_10:
  %r55 = load %Int*, %Int** %r0
  ;; unboxing %Int* %r55
  %r56 = getelementptr %Int, %Int* %r55, i32 0, i32 1
  %r57 = load i32, i32* %r56
  ;; unboxing %Int* @int_2
  %r58 = getelementptr %Int, %Int* @int_2, i32 0, i32 1
  %r59 = load i32, i32* %r58
  %r60 = add i32 %r57, %r59
  ;; boxing i32 %r60
  %r61 = call %Int* @Int_new()
  %r62 = getelementptr %Int, %Int* %r61, i32 0, i32 1
  store i32 %r60, i32* %r62
  store %Int* %r61, %Int** %r0
  store %Int* %r61, %Int** %r52
  br label %ifend_12
else_11:
  %r63 = load %Int*, %Int** %r0
  ;; unboxing %Int* %r63
  %r64 = getelementptr %Int, %Int* %r63, i32 0, i32 1
  %r65 = load i32, i32* %r64
  ;; unboxing %Int* @int_1
  %r66 = getelementptr %Int, %Int* @int_1, i32 0, i32 1
  %r67 = load i32, i32* %r66
  %r68 = add i32 %r65, %r67
  ;; boxing i32 %r68
  %r69 = call %Int* @Int_new()
  %r70 = getelementptr %Int, %Int* %r69, i32 0, i32 1
  store i32 %r68, i32* %r70
  store %Int* %r69, %Int** %r0
  store %Int* %r69, %Int** %r52
  br label %ifend_12
ifend_12:
  %r71 = load %Int*, %Int** %r52
  store %Int* %r71, %Int** %r32
  br label %ifend_9
ifend_9:
  %r72 = load %Int*, %Int** %r32
  %r73 = load %Int*, %Int** %r12
  ;; unboxing %Int* %r73
  %r74 = getelementptr %Int, %Int* %r73, i32 0, i32 1
  %r75 = load i32, i32* %r74
  ;; unboxing %Int* @int_1
  %r76 = getelementptr %Int, %Int* @int_1, i32 0, i32 1
  %r77 = load i32, i32* %r76
  %r78 = add i32 %r75, %r77
  ;; boxing i32 %r78
  %r79 = call %Int* @Int_new()
  %r80 = getelementptr %Int, %Int* %r79, i32 0, i32 1
  store i32 %r78, i32* %r80
  store %Int* %r79, %Int** %r12
  br label %cond_4
end_6:
  %r81 = load %Int*, %Int** %r1
  ;; unboxing %Int* %r81
  %r82 = getelementptr %Int, %Int* %r81, i32 0, i32 1
  %r83 = load i32, i32* %r82
  ;; unboxing %Int* @int_1
  %r84 = getelementptr %Int, %Int* @int_1, i32 0, i32 1
  %r85 = load i32, i32* %r84
  %r86 = add i32 %r83, %r85
  ;; boxing i32 %r86
  %r87 = call %Int* @Int_new()
  %r88 = getelementptr %Int, %Int* %r87, i32 0, i32 1
  store i32 %r86, i32* %r88
  store %Int* %r87, %Int** %r1
  br label %cond_1
end_3:
  %r89 = load %Int*, %Int** %r0
  ret %Int* %r89
}

define i32 @main() {
  %mainobj = call %Main* @Main_new()
  %r0 = call %Int* @Main_main(%Main* %mainobj)
  ;; unboxing %Int* %r0
  %r1 = getelementptr %Int, %Int* %r0, i32 0, i32 1
  %r2 = load i32, i32* %r1
  ret i32 %r2
}

