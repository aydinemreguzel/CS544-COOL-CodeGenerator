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

@str_1 = constant [7 x i8] c"Parent\00";
@string_1 = constant %String {
  %String_vtable* @String_vtable_prototype,
  i32 6,
  i8* getelementptr ([7 x i8], [7 x i8]* @str_1, i32 0, i32 0)
}

@str_2 = constant [6 x i8] c"Child\00";
@string_2 = constant %String {
  %String_vtable* @String_vtable_prototype,
  i32 5,
  i8* getelementptr ([6 x i8], [6 x i8]* @str_2, i32 0, i32 0)
}

@str_3 = constant [5 x i8] c"Main\00";
@string_3 = constant %String {
  %String_vtable* @String_vtable_prototype,
  i32 4,
  i8* getelementptr ([5 x i8], [5 x i8]* @str_3, i32 0, i32 0)
}
;;;;;;;;;;;;;;;;;;;;;
;;;  DATA LAYOUT  ;;;
;;;;;;;;;;;;;;;;;;;;;
%Parent = type {
  %Parent_vtable*
}
%Parent_vtable = type {
  i32, ;; class tag
  %String*, ;; type name
  %Parent* () *,
  %String* (%Parent*)*,
  %Object* (%Parent*)*,
  %Int* (%Parent*)*
}
@Parent_vtable_prototype = constant %Parent_vtable {
  i32 5,
  %String* @string_1,
  %Parent* () * @Parent_new,
  %String* (%Parent*)* bitcast (%String* (%Object*)* @Object_type_name to %String* (%Parent*)*),
  %Object* (%Parent*)* bitcast (%Object* (%Object*)* @Object_abort to %Object* (%Parent*)*),
  %Int* (%Parent*)* @Parent_getX
}
%Child = type {
  %Child_vtable*
}
%Child_vtable = type {
  i32, ;; class tag
  %String*, ;; type name
  %Child* () *,
  %String* (%Child*)*,
  %Object* (%Child*)*,
  %Int* (%Child*)*
}
@Child_vtable_prototype = constant %Child_vtable {
  i32 6,
  %String* @string_2,
  %Child* () * @Child_new,
  %String* (%Child*)* bitcast (%String* (%Object*)* @Object_type_name to %String* (%Child*)*),
  %Object* (%Child*)* bitcast (%Object* (%Object*)* @Object_abort to %Object* (%Child*)*),
  %Int* (%Child*)* @Child_getX
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
  i32 7,
  %String* @string_3,
  %Main* () * @Main_new,
  %String* (%Main*)* bitcast (%String* (%Object*)* @Object_type_name to %String* (%Main*)*),
  %Object* (%Main*)* bitcast (%Object* (%Object*)* @Object_abort to %Object* (%Main*)*),
  %Int* (%Main*)* @Main_main
}
;;;;;;;;;;;;;;;;;;;;;
;;;    METHODS    ;;;
;;;;;;;;;;;;;;;;;;;;;
define %Parent* @Parent_new() {
  %r0 = call i8* @malloc(i64 8)
  %r1 = bitcast i8* %r0 to %Parent*
  ;; setting vtable
  %r2 = getelementptr %Parent, %Parent* %r1, i32 0, i32 0
  store %Parent_vtable* @Parent_vtable_prototype, %Parent_vtable** %r2
  ret %Parent* %r1
}

define %Int* @Parent_getX(%Parent* %self) {
entry_0:
  ret %Int* @int_99
}

define %Child* @Child_new() {
  %r0 = call i8* @malloc(i64 8)
  %r1 = bitcast i8* %r0 to %Child*
  ;; setting vtable
  %r2 = getelementptr %Child, %Child* %r1, i32 0, i32 0
  store %Child_vtable* @Child_vtable_prototype, %Child_vtable** %r2
  ret %Child* %r1
}

define %Int* @Child_getX(%Child* %self) {
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
  %r0 = call %Child* @Child_new()
  %r1 = getelementptr %Child, %Child* %r0, i32 0, i32 0
  %r2 = load %Child_vtable*, %Child_vtable** %r1
  %r3 = getelementptr %Child_vtable, %Child_vtable* %r2, i32 0, i32 5
  %r4 = load %Int* (%Child*)*, %Int* (%Child*)** %r3
  %r5 = call %Int* %r4(%Child* %r0)
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

