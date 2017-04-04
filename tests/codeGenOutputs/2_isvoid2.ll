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
@int_42 = constant %Int {
  %Int_vtable* @Int_vtable_prototype,
  i32 42
}
@int_99 = constant %Int {
  %Int_vtable* @Int_vtable_prototype,
  i32 99
}

@str_0 = constant [1 x i8] c"\00";
@string_0 = constant %String {
  %String_vtable* @String_vtable_prototype,
  i32 0,
  i8* getelementptr ([1 x i8], [1 x i8]* @str_0, i32 0, i32 0)
}

@str_1 = constant [6 x i8] c"Dummy\00";
@string_1 = constant %String {
  %String_vtable* @String_vtable_prototype,
  i32 5,
  i8* getelementptr ([6 x i8], [6 x i8]* @str_1, i32 0, i32 0)
}

@str_2 = constant [5 x i8] c"Main\00";
@string_2 = constant %String {
  %String_vtable* @String_vtable_prototype,
  i32 4,
  i8* getelementptr ([5 x i8], [5 x i8]* @str_2, i32 0, i32 0)
}
;;;;;;;;;;;;;;;;;;;;;
;;;  DATA LAYOUT  ;;;
;;;;;;;;;;;;;;;;;;;;;
%Dummy = type {
  %Dummy_vtable*
}
%Dummy_vtable = type {
  i32, ;; class tag
  %String*, ;; type name
  %Dummy* () *,
  %String* (%Dummy*)*,
  %Object* (%Dummy*)*
}
@Dummy_vtable_prototype = constant %Dummy_vtable {
  i32 5,
  %String* @string_1,
  %Dummy* () * @Dummy_new,
  %String* (%Dummy*)* bitcast (%String* (%Object*)* @Object_type_name to %String* (%Dummy*)*),
  %Object* (%Dummy*)* bitcast (%Object* (%Object*)* @Object_abort to %Object* (%Dummy*)*)
}
%Main = type {
  %Main_vtable*,
  %Dummy*
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
  i32 6,
  %String* @string_2,
  %Main* () * @Main_new,
  %String* (%Main*)* bitcast (%String* (%Object*)* @Object_type_name to %String* (%Main*)*),
  %Object* (%Main*)* bitcast (%Object* (%Object*)* @Object_abort to %Object* (%Main*)*),
  %Int* (%Main*)* @Main_main
}
;;;;;;;;;;;;;;;;;;;;;
;;;    METHODS    ;;;
;;;;;;;;;;;;;;;;;;;;;
define %Dummy* @Dummy_new() {
  %r0 = call i8* @malloc(i64 8)
  %r1 = bitcast i8* %r0 to %Dummy*
  ;; setting vtable
  %r2 = getelementptr %Dummy, %Dummy* %r1, i32 0, i32 0
  store %Dummy_vtable* @Dummy_vtable_prototype, %Dummy_vtable** %r2
  ret %Dummy* %r1
}

define %Main* @Main_new() {
  %r0 = call i8* @malloc(i64 16)
  %r1 = bitcast i8* %r0 to %Main*
  ;; setting vtable
  %r2 = getelementptr %Main, %Main* %r1, i32 0, i32 0
  store %Main_vtable* @Main_vtable_prototype, %Main_vtable** %r2
  ;; default-initializing field 'x'
  %r3 = getelementptr %Main, %Main* %r1, i32 0, i32 1
  store %Dummy* null, %Dummy** %r3
  ret %Main* %r1
}

define %Int* @Main_main(%Main* %self) {
entry_0:
  %r0 = getelementptr %Main, %Main* %self, i32 0, i32 1
  %r1 = load %Dummy*, %Dummy** %r0
  %r2 = icmp eq %Dummy* %r1, null
  ;; boxing i1 %r2
  %r3 = call %Bool* @Bool_new()
  %r4 = getelementptr %Bool, %Bool* %r3, i32 0, i32 1
  store i1 %r2, i1* %r4
  ;; emitting an 'if'
  %r5 = alloca %Int*
  ;; unboxing %Bool* %r3
  %r6 = getelementptr %Bool, %Bool* %r3, i32 0, i32 1
  %r7 = load i1, i1* %r6
  br i1 %r7, label %then_1, label %else_2
then_1:
  store %Int* @int_42, %Int** %r5
  br label %ifend_3
else_2:
  store %Int* @int_99, %Int** %r5
  br label %ifend_3
ifend_3:
  %r8 = load %Int*, %Int** %r5
  ret %Int* %r8
}

define i32 @main() {
  %mainobj = call %Main* @Main_new()
  %r0 = call %Int* @Main_main(%Main* %mainobj)
  ;; unboxing %Int* %r0
  %r1 = getelementptr %Int, %Int* %r0, i32 0, i32 1
  %r2 = load i32, i32* %r1
  ret i32 %r2
}

