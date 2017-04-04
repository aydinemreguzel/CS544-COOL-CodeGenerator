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

@str_1 = constant [7 x i8] c"Parent\00";
@string_1 = constant %String {
  %String_vtable* @String_vtable_prototype,
  i32 6,
  i8* getelementptr ([7 x i8], [7 x i8]* @str_1, i32 0, i32 0)
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
%Parent = type {
  %Parent_vtable*,
  %Int*,
  %Int*,
  %Int*
}
%Parent_vtable = type {
  i32, ;; class tag
  %String*, ;; type name
  %Parent* () *,
  %String* (%Parent*)*,
  %Object* (%Parent*)*
}
@Parent_vtable_prototype = constant %Parent_vtable {
  i32 5,
  %String* @string_1,
  %Parent* () * @Parent_new,
  %String* (%Parent*)* bitcast (%String* (%Object*)* @Object_type_name to %String* (%Parent*)*),
  %Object* (%Parent*)* bitcast (%Object* (%Object*)* @Object_abort to %Object* (%Parent*)*)
}
%Main = type {
  %Main_vtable*,
  %Int*,
  %Int*,
  %Int*,
  %Int*,
  %Int*
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
define %Parent* @Parent_new() {
  %r0 = call i8* @malloc(i64 32)
  %r1 = bitcast i8* %r0 to %Parent*
  ;; setting vtable
  %r2 = getelementptr %Parent, %Parent* %r1, i32 0, i32 0
  store %Parent_vtable* @Parent_vtable_prototype, %Parent_vtable** %r2
  ;; default-initializing field 'x'
  %r3 = getelementptr %Parent, %Parent* %r1, i32 0, i32 1
  %r4 = call %Int* @Int_new()
  store %Int* %r4, %Int** %r3
  ;; default-initializing field 'y'
  %r5 = getelementptr %Parent, %Parent* %r1, i32 0, i32 2
  %r6 = call %Int* @Int_new()
  store %Int* %r6, %Int** %r5
  ;; default-initializing field 'z'
  %r7 = getelementptr %Parent, %Parent* %r1, i32 0, i32 3
  %r8 = call %Int* @Int_new()
  store %Int* %r8, %Int** %r7
  ret %Parent* %r1
}

define %Main* @Main_new() {
  %r0 = call i8* @malloc(i64 48)
  %r1 = bitcast i8* %r0 to %Main*
  ;; setting vtable
  %r2 = getelementptr %Main, %Main* %r1, i32 0, i32 0
  store %Main_vtable* @Main_vtable_prototype, %Main_vtable** %r2
  ;; default-initializing field 'x'
  %r3 = getelementptr %Main, %Main* %r1, i32 0, i32 1
  %r4 = call %Int* @Int_new()
  store %Int* %r4, %Int** %r3
  ;; default-initializing field 'y'
  %r5 = getelementptr %Main, %Main* %r1, i32 0, i32 2
  %r6 = call %Int* @Int_new()
  store %Int* %r6, %Int** %r5
  ;; default-initializing field 'z'
  %r7 = getelementptr %Main, %Main* %r1, i32 0, i32 3
  %r8 = call %Int* @Int_new()
  store %Int* %r8, %Int** %r7
  ;; default-initializing field 'k'
  %r9 = getelementptr %Main, %Main* %r1, i32 0, i32 4
  %r10 = call %Int* @Int_new()
  store %Int* %r10, %Int** %r9
  ;; default-initializing field 'm'
  %r11 = getelementptr %Main, %Main* %r1, i32 0, i32 5
  %r12 = call %Int* @Int_new()
  store %Int* %r12, %Int** %r11
  ret %Main* %r1
}

define %Int* @Main_main(%Main* %self) {
entry_0:
  %r0 = getelementptr %Main, %Main* %self, i32 0, i32 3
  %r1 = load %Int*, %Int** %r0
  ret %Int* @int_42
}

define i32 @main() {
  %mainobj = call %Main* @Main_new()
  %r0 = call %Int* @Main_main(%Main* %mainobj)
  ;; unboxing %Int* %r0
  %r1 = getelementptr %Int, %Int* %r0, i32 0, i32 1
  %r2 = load i32, i32* %r1
  ret i32 %r2
}

