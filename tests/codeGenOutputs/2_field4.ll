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

@str_1 = constant [5 x i8] c"Main\00";
@string_1 = constant %String {
  %String_vtable* @String_vtable_prototype,
  i32 4,
  i8* getelementptr ([5 x i8], [5 x i8]* @str_1, i32 0, i32 0)
}

@str_2 = constant [6 x i8] c"hello\00";
@string_2 = constant %String {
  %String_vtable* @String_vtable_prototype,
  i32 5,
  i8* getelementptr ([6 x i8], [6 x i8]* @str_2, i32 0, i32 0)
}
;;;;;;;;;;;;;;;;;;;;;
;;;  DATA LAYOUT  ;;;
;;;;;;;;;;;;;;;;;;;;;
%Main = type {
  %Main_vtable*,
  %Int*,
  %Bool*,
  %String*,
  %Main*
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
  %r0 = call i8* @malloc(i64 40)
  %r1 = bitcast i8* %r0 to %Main*
  ;; setting vtable
  %r2 = getelementptr %Main, %Main* %r1, i32 0, i32 0
  store %Main_vtable* @Main_vtable_prototype, %Main_vtable** %r2
  ;; default-initializing field 'n'
  %r3 = getelementptr %Main, %Main* %r1, i32 0, i32 1
  %r4 = call %Int* @Int_new()
  store %Int* %r4, %Int** %r3
  ;; default-initializing field 'b'
  %r5 = getelementptr %Main, %Main* %r1, i32 0, i32 2
  %r6 = call %Bool* @Bool_new()
  store %Bool* %r6, %Bool** %r5
  ;; default-initializing field 's'
  %r7 = getelementptr %Main, %Main* %r1, i32 0, i32 3
  %r8 = call %String* @String_new()
  store %String* %r8, %String** %r7
  ;; default-initializing field 'd'
  %r9 = getelementptr %Main, %Main* %r1, i32 0, i32 4
  store %Main* null, %Main** %r9
  ;; initializing field 'n'
  %r10 = getelementptr %Main, %Main* %r1, i32 0, i32 1
  store %Int* @int_42, %Int** %r10
  ;; initializing field 'b'
  %r11 = getelementptr %Main, %Main* %r1, i32 0, i32 2
  store %Bool* @bool_true, %Bool** %r11
  ;; initializing field 's'
  %r12 = getelementptr %Main, %Main* %r1, i32 0, i32 3
  store %String* @string_2, %String** %r12
  ret %Main* %r1
}

define %Int* @Main_main(%Main* %self) {
entry_0:
  %r0 = getelementptr %Main, %Main* %self, i32 0, i32 1
  %r1 = load %Int*, %Int** %r0
  ret %Int* %r1
}

define i32 @main() {
  %mainobj = call %Main* @Main_new()
  %r0 = call %Int* @Main_main(%Main* %mainobj)
  ;; unboxing %Int* %r0
  %r1 = getelementptr %Int, %Int* %r0, i32 0, i32 1
  %r2 = load i32, i32* %r1
  ret i32 %r2
}

