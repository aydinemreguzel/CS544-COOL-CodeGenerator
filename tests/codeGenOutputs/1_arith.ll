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
@int_18 = constant %Int {
  %Int_vtable* @Int_vtable_prototype,
  i32 18
}
@int_3 = constant %Int {
  %Int_vtable* @Int_vtable_prototype,
  i32 3
}
@int_5 = constant %Int {
  %Int_vtable* @Int_vtable_prototype,
  i32 5
}
@int_6 = constant %Int {
  %Int_vtable* @Int_vtable_prototype,
  i32 6
}
@int_9 = constant %Int {
  %Int_vtable* @Int_vtable_prototype,
  i32 9
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
  ;; unboxing %Int* @int_5
  %r0 = getelementptr %Int, %Int* @int_5, i32 0, i32 1
  %r1 = load i32, i32* %r0
  ;; unboxing %Int* @int_9
  %r2 = getelementptr %Int, %Int* @int_9, i32 0, i32 1
  %r3 = load i32, i32* %r2
  %r4 = add i32 %r1, %r3
  ;; boxing i32 %r4
  %r5 = call %Int* @Int_new()
  %r6 = getelementptr %Int, %Int* %r5, i32 0, i32 1
  store i32 %r4, i32* %r6
  ;; unboxing %Int* @int_3
  %r7 = getelementptr %Int, %Int* @int_3, i32 0, i32 1
  %r8 = load i32, i32* %r7
  ;; unboxing %Int* %r5
  %r9 = getelementptr %Int, %Int* %r5, i32 0, i32 1
  %r10 = load i32, i32* %r9
  %r11 = mul i32 %r8, %r10
  ;; boxing i32 %r11
  %r12 = call %Int* @Int_new()
  %r13 = getelementptr %Int, %Int* %r12, i32 0, i32 1
  store i32 %r11, i32* %r13
  ;; unboxing %Int* @int_6
  %r14 = getelementptr %Int, %Int* @int_6, i32 0, i32 1
  %r15 = load i32, i32* %r14
  ;; unboxing %Int* %r12
  %r16 = getelementptr %Int, %Int* %r12, i32 0, i32 1
  %r17 = load i32, i32* %r16
  %r18 = add i32 %r15, %r17
  ;; boxing i32 %r18
  %r19 = call %Int* @Int_new()
  %r20 = getelementptr %Int, %Int* %r19, i32 0, i32 1
  store i32 %r18, i32* %r20
  ;; unboxing %Int* @int_18
  %r21 = getelementptr %Int, %Int* @int_18, i32 0, i32 1
  %r22 = load i32, i32* %r21
  ;; unboxing %Int* @int_3
  %r23 = getelementptr %Int, %Int* @int_3, i32 0, i32 1
  %r24 = load i32, i32* %r23
  %r25 = sdiv i32 %r22, %r24
  ;; boxing i32 %r25
  %r26 = call %Int* @Int_new()
  %r27 = getelementptr %Int, %Int* %r26, i32 0, i32 1
  store i32 %r25, i32* %r27
  ;; unboxing %Int* %r19
  %r28 = getelementptr %Int, %Int* %r19, i32 0, i32 1
  %r29 = load i32, i32* %r28
  ;; unboxing %Int* %r26
  %r30 = getelementptr %Int, %Int* %r26, i32 0, i32 1
  %r31 = load i32, i32* %r30
  %r32 = sub i32 %r29, %r31
  ;; boxing i32 %r32
  %r33 = call %Int* @Int_new()
  %r34 = getelementptr %Int, %Int* %r33, i32 0, i32 1
  store i32 %r32, i32* %r34
  ret %Int* %r33
}

define i32 @main() {
  %mainobj = call %Main* @Main_new()
  %r0 = call %Int* @Main_main(%Main* %mainobj)
  ;; unboxing %Int* %r0
  %r1 = getelementptr %Int, %Int* %r0, i32 0, i32 1
  %r2 = load i32, i32* %r1
  ret i32 %r2
}

