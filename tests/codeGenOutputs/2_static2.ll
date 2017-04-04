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
@int_12 = constant %Int {
  %Int_vtable* @Int_vtable_prototype,
  i32 12
}
@int_20 = constant %Int {
  %Int_vtable* @Int_vtable_prototype,
  i32 20
}

@str_0 = constant [1 x i8] c"\00";
@string_0 = constant %String {
  %String_vtable* @String_vtable_prototype,
  i32 0,
  i8* getelementptr ([1 x i8], [1 x i8]* @str_0, i32 0, i32 0)
}

@str_1 = constant [12 x i8] c"GrandParent\00";
@string_1 = constant %String {
  %String_vtable* @String_vtable_prototype,
  i32 11,
  i8* getelementptr ([12 x i8], [12 x i8]* @str_1, i32 0, i32 0)
}

@str_2 = constant [7 x i8] c"Parent\00";
@string_2 = constant %String {
  %String_vtable* @String_vtable_prototype,
  i32 6,
  i8* getelementptr ([7 x i8], [7 x i8]* @str_2, i32 0, i32 0)
}

@str_3 = constant [6 x i8] c"Child\00";
@string_3 = constant %String {
  %String_vtable* @String_vtable_prototype,
  i32 5,
  i8* getelementptr ([6 x i8], [6 x i8]* @str_3, i32 0, i32 0)
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
%GrandParent = type {
  %GrandParent_vtable*
}
%GrandParent_vtable = type {
  i32, ;; class tag
  %String*, ;; type name
  %GrandParent* () *,
  %String* (%GrandParent*)*,
  %Object* (%GrandParent*)*,
  %Int* (%GrandParent*, %Int*, %Int*, %Int*)*
}
@GrandParent_vtable_prototype = constant %GrandParent_vtable {
  i32 5,
  %String* @string_1,
  %GrandParent* () * @GrandParent_new,
  %String* (%GrandParent*)* bitcast (%String* (%Object*)* @Object_type_name to %String* (%GrandParent*)*),
  %Object* (%GrandParent*)* bitcast (%Object* (%Object*)* @Object_abort to %Object* (%GrandParent*)*),
  %Int* (%GrandParent*, %Int*, %Int*, %Int*)* @GrandParent_getX
}
%Parent = type {
  %Parent_vtable*
}
%Parent_vtable = type {
  i32, ;; class tag
  %String*, ;; type name
  %Parent* () *,
  %String* (%Parent*)*,
  %Object* (%Parent*)*,
  %Int* (%Parent*, %Int*, %Int*, %Int*)*
}
@Parent_vtable_prototype = constant %Parent_vtable {
  i32 6,
  %String* @string_2,
  %Parent* () * @Parent_new,
  %String* (%Parent*)* bitcast (%String* (%Object*)* @Object_type_name to %String* (%Parent*)*),
  %Object* (%Parent*)* bitcast (%Object* (%Object*)* @Object_abort to %Object* (%Parent*)*),
  %Int* (%Parent*, %Int*, %Int*, %Int*)* bitcast (%Int* (%GrandParent*, %Int*, %Int*, %Int*)* @GrandParent_getX to %Int* (%Parent*, %Int*, %Int*, %Int*)*)
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
  %Int* (%Child*, %Int*, %Int*, %Int*)*
}
@Child_vtable_prototype = constant %Child_vtable {
  i32 7,
  %String* @string_3,
  %Child* () * @Child_new,
  %String* (%Child*)* bitcast (%String* (%Object*)* @Object_type_name to %String* (%Child*)*),
  %Object* (%Child*)* bitcast (%Object* (%Object*)* @Object_abort to %Object* (%Child*)*),
  %Int* (%Child*, %Int*, %Int*, %Int*)* @Child_getX
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
define %GrandParent* @GrandParent_new() {
  %r0 = call i8* @malloc(i64 8)
  %r1 = bitcast i8* %r0 to %GrandParent*
  ;; setting vtable
  %r2 = getelementptr %GrandParent, %GrandParent* %r1, i32 0, i32 0
  store %GrandParent_vtable* @GrandParent_vtable_prototype, %GrandParent_vtable** %r2
  ret %GrandParent* %r1
}

define %Int* @GrandParent_getX(%GrandParent* %self, %Int* %a, %Int* %b, %Int* %c) {
entry_0:
  %r0 = alloca %Int*
  store %Int* %a, %Int** %r0
  %r1 = alloca %Int*
  store %Int* %b, %Int** %r1
  %r2 = alloca %Int*
  store %Int* %c, %Int** %r2
  %r3 = load %Int*, %Int** %r0
  %r4 = load %Int*, %Int** %r1
  ;; unboxing %Int* %r3
  %r5 = getelementptr %Int, %Int* %r3, i32 0, i32 1
  %r6 = load i32, i32* %r5
  ;; unboxing %Int* %r4
  %r7 = getelementptr %Int, %Int* %r4, i32 0, i32 1
  %r8 = load i32, i32* %r7
  %r9 = add i32 %r6, %r8
  ;; boxing i32 %r9
  %r10 = call %Int* @Int_new()
  %r11 = getelementptr %Int, %Int* %r10, i32 0, i32 1
  store i32 %r9, i32* %r11
  %r12 = load %Int*, %Int** %r2
  ;; unboxing %Int* %r10
  %r13 = getelementptr %Int, %Int* %r10, i32 0, i32 1
  %r14 = load i32, i32* %r13
  ;; unboxing %Int* %r12
  %r15 = getelementptr %Int, %Int* %r12, i32 0, i32 1
  %r16 = load i32, i32* %r15
  %r17 = add i32 %r14, %r16
  ;; boxing i32 %r17
  %r18 = call %Int* @Int_new()
  %r19 = getelementptr %Int, %Int* %r18, i32 0, i32 1
  store i32 %r17, i32* %r19
  ret %Int* %r18
}

define %Parent* @Parent_new() {
  %r0 = call i8* @malloc(i64 8)
  %r1 = bitcast i8* %r0 to %Parent*
  ;; setting vtable
  %r2 = getelementptr %Parent, %Parent* %r1, i32 0, i32 0
  store %Parent_vtable* @Parent_vtable_prototype, %Parent_vtable** %r2
  ret %Parent* %r1
}

define %Child* @Child_new() {
  %r0 = call i8* @malloc(i64 8)
  %r1 = bitcast i8* %r0 to %Child*
  ;; setting vtable
  %r2 = getelementptr %Child, %Child* %r1, i32 0, i32 0
  store %Child_vtable* @Child_vtable_prototype, %Child_vtable** %r2
  ret %Child* %r1
}

define %Int* @Child_getX(%Child* %self, %Int* %a, %Int* %b, %Int* %c) {
entry_0:
  %r0 = alloca %Int*
  store %Int* %a, %Int** %r0
  %r1 = alloca %Int*
  store %Int* %b, %Int** %r1
  %r2 = alloca %Int*
  store %Int* %c, %Int** %r2
  %r3 = load %Int*, %Int** %r0
  %r4 = load %Int*, %Int** %r1
  ;; unboxing %Int* %r3
  %r5 = getelementptr %Int, %Int* %r3, i32 0, i32 1
  %r6 = load i32, i32* %r5
  ;; unboxing %Int* %r4
  %r7 = getelementptr %Int, %Int* %r4, i32 0, i32 1
  %r8 = load i32, i32* %r7
  %r9 = mul i32 %r6, %r8
  ;; boxing i32 %r9
  %r10 = call %Int* @Int_new()
  %r11 = getelementptr %Int, %Int* %r10, i32 0, i32 1
  store i32 %r9, i32* %r11
  %r12 = load %Int*, %Int** %r2
  ;; unboxing %Int* %r10
  %r13 = getelementptr %Int, %Int* %r10, i32 0, i32 1
  %r14 = load i32, i32* %r13
  ;; unboxing %Int* %r12
  %r15 = getelementptr %Int, %Int* %r12, i32 0, i32 1
  %r16 = load i32, i32* %r15
  %r17 = mul i32 %r14, %r16
  ;; boxing i32 %r17
  %r18 = call %Int* @Int_new()
  %r19 = getelementptr %Int, %Int* %r18, i32 0, i32 1
  store i32 %r17, i32* %r19
  ret %Int* %r18
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
  %r1 = bitcast %Child* %r0 to %GrandParent*
  %r2 = call %Int* @GrandParent_getX(%GrandParent* %r1, %Int* @int_10, %Int* @int_20, %Int* @int_12)
  ret %Int* %r2
}

define i32 @main() {
  %mainobj = call %Main* @Main_new()
  %r0 = call %Int* @Main_main(%Main* %mainobj)
  ;; unboxing %Int* %r0
  %r1 = getelementptr %Int, %Int* %r0, i32 0, i32 1
  %r2 = load i32, i32* %r1
  ret i32 %r2
}

