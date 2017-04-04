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
@int_10 = constant %Int {
  %Int_vtable* @Int_vtable_prototype,
  i32 10
}
@int_2 = constant %Int {
  %Int_vtable* @Int_vtable_prototype,
  i32 2
}
@int_40 = constant %Int {
  %Int_vtable* @Int_vtable_prototype,
  i32 40
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
  br label %cond_1
cond_1:
  %r1 = load %Int*, %Int** %r0
  ;; unboxing %Int* %r1
  %r2 = getelementptr %Int, %Int* %r1, i32 0, i32 1
  %r3 = load i32, i32* %r2
  ;; unboxing %Int* @int_40
  %r4 = getelementptr %Int, %Int* @int_40, i32 0, i32 1
  %r5 = load i32, i32* %r4
  %r6 = icmp slt i32 %r3, %r5
  ;; boxing i1 %r6
  %r7 = call %Bool* @Bool_new()
  %r8 = getelementptr %Bool, %Bool* %r7, i32 0, i32 1
  store i1 %r6, i1* %r8
  ;; unboxing %Bool* %r7
  %r9 = getelementptr %Bool, %Bool* %r7, i32 0, i32 1
  %r10 = load i1, i1* %r9
  br i1 %r10, label %body_2, label %end_3
body_2:
  %r11 = load %Int*, %Int** %r0
  ;; unboxing %Int* %r11
  %r12 = getelementptr %Int, %Int* %r11, i32 0, i32 1
  %r13 = load i32, i32* %r12
  ;; unboxing %Int* @int_10
  %r14 = getelementptr %Int, %Int* @int_10, i32 0, i32 1
  %r15 = load i32, i32* %r14
  %r16 = add i32 %r13, %r15
  ;; boxing i32 %r16
  %r17 = call %Int* @Int_new()
  %r18 = getelementptr %Int, %Int* %r17, i32 0, i32 1
  store i32 %r16, i32* %r18
  store %Int* %r17, %Int** %r0
  br label %cond_1
end_3:
  %r19 = load %Int*, %Int** %r0
  ;; unboxing %Int* %r19
  %r20 = getelementptr %Int, %Int* %r19, i32 0, i32 1
  %r21 = load i32, i32* %r20
  ;; unboxing %Int* @int_2
  %r22 = getelementptr %Int, %Int* @int_2, i32 0, i32 1
  %r23 = load i32, i32* %r22
  %r24 = add i32 %r21, %r23
  ;; boxing i32 %r24
  %r25 = call %Int* @Int_new()
  %r26 = getelementptr %Int, %Int* %r25, i32 0, i32 1
  store i32 %r24, i32* %r26
  ret %Int* %r25
}

define i32 @main() {
  %mainobj = call %Main* @Main_new()
  %r0 = call %Int* @Main_main(%Main* %mainobj)
  ;; unboxing %Int* %r0
  %r1 = getelementptr %Int, %Int* %r0, i32 0, i32 1
  %r2 = load i32, i32* %r1
  ret i32 %r2
}

