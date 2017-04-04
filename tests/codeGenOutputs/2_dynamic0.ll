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
  %Object* (%Dummy*)*,
  %Int* (%Dummy*)*
}
@Dummy_vtable_prototype = constant %Dummy_vtable {
  i32 5,
  %String* @string_1,
  %Dummy* () * @Dummy_new,
  %String* (%Dummy*)* bitcast (%String* (%Object*)* @Object_type_name to %String* (%Dummy*)*),
  %Object* (%Dummy*)* bitcast (%Object* (%Object*)* @Object_abort to %Object* (%Dummy*)*),
  %Int* (%Dummy*)* @Dummy_getX
}
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

define %Int* @Dummy_getX(%Dummy* %self) {
entry_0:
  ret %Int* @int_42
}

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
  %r0 = call %Dummy* @Dummy_new()
  %r1 = getelementptr %Dummy, %Dummy* %r0, i32 0, i32 0
  %r2 = load %Dummy_vtable*, %Dummy_vtable** %r1
  %r3 = getelementptr %Dummy_vtable, %Dummy_vtable* %r2, i32 0, i32 5
  %r4 = load %Int* (%Dummy*)*, %Int* (%Dummy*)** %r3
  %r5 = call %Int* %r4(%Dummy* %r0)
  ret %Int* %r5
}

define i32 @main() {
  %mainobj = call %Main* @Main_new()
  %r0 = call %Int* @Main_main(%Main* %mainobj)
  ;; unboxing %Int* %r0
  %r1 = getelementptr %Int, %Int* %r0, i32 0, i32 1
  %r2 = load i32, i32* %r1
  ret i32 %r2
}

