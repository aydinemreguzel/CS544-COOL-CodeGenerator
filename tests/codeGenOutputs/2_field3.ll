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

@str_2 = constant [6 x i8] c"Child\00";
@string_2 = constant %String {
  %String_vtable* @String_vtable_prototype,
  i32 5,
  i8* getelementptr ([6 x i8], [6 x i8]* @str_2, i32 0, i32 0)
}

@str_3 = constant [11 x i8] c"GrandChild\00";
@string_3 = constant %String {
  %String_vtable* @String_vtable_prototype,
  i32 10,
  i8* getelementptr ([11 x i8], [11 x i8]* @str_3, i32 0, i32 0)
}

@str_4 = constant [5 x i8] c"Main\00";
@string_4 = constant %String {
  %String_vtable* @String_vtable_prototype,
  i32 4,
  i8* getelementptr ([5 x i8], [5 x i8]* @str_4, i32 0, i32 0)
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
%Child = type {
  %Child_vtable*,
  %Int*,
  %Int*,
  %Int*,
  %Int*
}
%Child_vtable = type {
  i32, ;; class tag
  %String*, ;; type name
  %Child* () *,
  %String* (%Child*)*,
  %Object* (%Child*)*
}
@Child_vtable_prototype = constant %Child_vtable {
  i32 6,
  %String* @string_2,
  %Child* () * @Child_new,
  %String* (%Child*)* bitcast (%String* (%Object*)* @Object_type_name to %String* (%Child*)*),
  %Object* (%Child*)* bitcast (%Object* (%Object*)* @Object_abort to %Object* (%Child*)*)
}
%GrandChild = type {
  %GrandChild_vtable*,
  %Int*,
  %Int*,
  %Int*,
  %Int*,
  %Int*,
  %Int*,
  %Int*
}
%GrandChild_vtable = type {
  i32, ;; class tag
  %String*, ;; type name
  %GrandChild* () *,
  %String* (%GrandChild*)*,
  %Object* (%GrandChild*)*
}
@GrandChild_vtable_prototype = constant %GrandChild_vtable {
  i32 7,
  %String* @string_3,
  %GrandChild* () * @GrandChild_new,
  %String* (%GrandChild*)* bitcast (%String* (%Object*)* @Object_type_name to %String* (%GrandChild*)*),
  %Object* (%GrandChild*)* bitcast (%Object* (%Object*)* @Object_abort to %Object* (%GrandChild*)*)
}
%Main = type {
  %Main_vtable*,
  %Int*,
  %Int*,
  %Int*,
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
  i32 8,
  %String* @string_4,
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
  ;; default-initializing field 'a'
  %r3 = getelementptr %Parent, %Parent* %r1, i32 0, i32 1
  %r4 = call %Int* @Int_new()
  store %Int* %r4, %Int** %r3
  ;; default-initializing field 'b'
  %r5 = getelementptr %Parent, %Parent* %r1, i32 0, i32 2
  %r6 = call %Int* @Int_new()
  store %Int* %r6, %Int** %r5
  ;; default-initializing field 'c'
  %r7 = getelementptr %Parent, %Parent* %r1, i32 0, i32 3
  %r8 = call %Int* @Int_new()
  store %Int* %r8, %Int** %r7
  ret %Parent* %r1
}

define %Child* @Child_new() {
  %r0 = call i8* @malloc(i64 40)
  %r1 = bitcast i8* %r0 to %Child*
  ;; setting vtable
  %r2 = getelementptr %Child, %Child* %r1, i32 0, i32 0
  store %Child_vtable* @Child_vtable_prototype, %Child_vtable** %r2
  ;; default-initializing field 'a'
  %r3 = getelementptr %Child, %Child* %r1, i32 0, i32 1
  %r4 = call %Int* @Int_new()
  store %Int* %r4, %Int** %r3
  ;; default-initializing field 'b'
  %r5 = getelementptr %Child, %Child* %r1, i32 0, i32 2
  %r6 = call %Int* @Int_new()
  store %Int* %r6, %Int** %r5
  ;; default-initializing field 'c'
  %r7 = getelementptr %Child, %Child* %r1, i32 0, i32 3
  %r8 = call %Int* @Int_new()
  store %Int* %r8, %Int** %r7
  ;; default-initializing field 'd'
  %r9 = getelementptr %Child, %Child* %r1, i32 0, i32 4
  %r10 = call %Int* @Int_new()
  store %Int* %r10, %Int** %r9
  ret %Child* %r1
}

define %GrandChild* @GrandChild_new() {
  %r0 = call i8* @malloc(i64 64)
  %r1 = bitcast i8* %r0 to %GrandChild*
  ;; setting vtable
  %r2 = getelementptr %GrandChild, %GrandChild* %r1, i32 0, i32 0
  store %GrandChild_vtable* @GrandChild_vtable_prototype, %GrandChild_vtable** %r2
  ;; default-initializing field 'a'
  %r3 = getelementptr %GrandChild, %GrandChild* %r1, i32 0, i32 1
  %r4 = call %Int* @Int_new()
  store %Int* %r4, %Int** %r3
  ;; default-initializing field 'b'
  %r5 = getelementptr %GrandChild, %GrandChild* %r1, i32 0, i32 2
  %r6 = call %Int* @Int_new()
  store %Int* %r6, %Int** %r5
  ;; default-initializing field 'c'
  %r7 = getelementptr %GrandChild, %GrandChild* %r1, i32 0, i32 3
  %r8 = call %Int* @Int_new()
  store %Int* %r8, %Int** %r7
  ;; default-initializing field 'd'
  %r9 = getelementptr %GrandChild, %GrandChild* %r1, i32 0, i32 4
  %r10 = call %Int* @Int_new()
  store %Int* %r10, %Int** %r9
  ;; default-initializing field 'e'
  %r11 = getelementptr %GrandChild, %GrandChild* %r1, i32 0, i32 5
  %r12 = call %Int* @Int_new()
  store %Int* %r12, %Int** %r11
  ;; default-initializing field 'c'
  %r13 = getelementptr %GrandChild, %GrandChild* %r1, i32 0, i32 6
  %r14 = call %Int* @Int_new()
  store %Int* %r14, %Int** %r13
  ;; default-initializing field 'g'
  %r15 = getelementptr %GrandChild, %GrandChild* %r1, i32 0, i32 7
  %r16 = call %Int* @Int_new()
  store %Int* %r16, %Int** %r15
  ret %GrandChild* %r1
}

define %Main* @Main_new() {
  %r0 = call i8* @malloc(i64 72)
  %r1 = bitcast i8* %r0 to %Main*
  ;; setting vtable
  %r2 = getelementptr %Main, %Main* %r1, i32 0, i32 0
  store %Main_vtable* @Main_vtable_prototype, %Main_vtable** %r2
  ;; default-initializing field 'a'
  %r3 = getelementptr %Main, %Main* %r1, i32 0, i32 1
  %r4 = call %Int* @Int_new()
  store %Int* %r4, %Int** %r3
  ;; default-initializing field 'b'
  %r5 = getelementptr %Main, %Main* %r1, i32 0, i32 2
  %r6 = call %Int* @Int_new()
  store %Int* %r6, %Int** %r5
  ;; default-initializing field 'c'
  %r7 = getelementptr %Main, %Main* %r1, i32 0, i32 3
  %r8 = call %Int* @Int_new()
  store %Int* %r8, %Int** %r7
  ;; default-initializing field 'd'
  %r9 = getelementptr %Main, %Main* %r1, i32 0, i32 4
  %r10 = call %Int* @Int_new()
  store %Int* %r10, %Int** %r9
  ;; default-initializing field 'e'
  %r11 = getelementptr %Main, %Main* %r1, i32 0, i32 5
  %r12 = call %Int* @Int_new()
  store %Int* %r12, %Int** %r11
  ;; default-initializing field 'c'
  %r13 = getelementptr %Main, %Main* %r1, i32 0, i32 6
  %r14 = call %Int* @Int_new()
  store %Int* %r14, %Int** %r13
  ;; default-initializing field 'g'
  %r15 = getelementptr %Main, %Main* %r1, i32 0, i32 7
  %r16 = call %Int* @Int_new()
  store %Int* %r16, %Int** %r15
  ;; default-initializing field 'h'
  %r17 = getelementptr %Main, %Main* %r1, i32 0, i32 8
  %r18 = call %Int* @Int_new()
  store %Int* %r18, %Int** %r17
  ret %Main* %r1
}

define %Int* @Main_main(%Main* %self) {
entry_0:
  %r0 = getelementptr %Main, %Main* %self, i32 0, i32 6
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

