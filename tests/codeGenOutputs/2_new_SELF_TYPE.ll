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

@str_2 = constant [3 x i8] c"OK\00";
@string_2 = constant %String {
  %String_vtable* @String_vtable_prototype,
  i32 2,
  i8* getelementptr ([3 x i8], [3 x i8]* @str_2, i32 0, i32 0)
}

@str_3 = constant [5 x i8] c"Main\00";
@string_3 = constant %String {
  %String_vtable* @String_vtable_prototype,
  i32 4,
  i8* getelementptr ([5 x i8], [5 x i8]* @str_3, i32 0, i32 0)
}

@str_4 = constant [2 x i8] c"\0A\00";
@string_4 = constant %String {
  %String_vtable* @String_vtable_prototype,
  i32 1,
  i8* getelementptr ([2 x i8], [2 x i8]* @str_4, i32 0, i32 0)
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
  %Parent* (%Parent*)*
}
@Parent_vtable_prototype = constant %Parent_vtable {
  i32 5,
  %String* @string_1,
  %Parent* () * @Parent_new,
  %String* (%Parent*)* bitcast (%String* (%Object*)* @Object_type_name to %String* (%Parent*)*),
  %Object* (%Parent*)* bitcast (%Object* (%Object*)* @Object_abort to %Object* (%Parent*)*),
  %Parent* (%Parent*)* @Parent_get
}
%OK = type {
  %OK_vtable*
}
%OK_vtable = type {
  i32, ;; class tag
  %String*, ;; type name
  %OK* () *,
  %String* (%OK*)*,
  %Object* (%OK*)*,
  %OK* (%OK*)*
}
@OK_vtable_prototype = constant %OK_vtable {
  i32 6,
  %String* @string_2,
  %OK* () * @OK_new,
  %String* (%OK*)* bitcast (%String* (%Object*)* @Object_type_name to %String* (%OK*)*),
  %Object* (%OK*)* bitcast (%Object* (%Object*)* @Object_abort to %Object* (%OK*)*),
  %OK* (%OK*)* bitcast (%Parent* (%Parent*)* @Parent_get to %OK* (%OK*)*)
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
  %IO* (%Main*, %String*)*,
  %IO* (%Main*, %Int*)*,
  %Int* (%Main*)*,
  %Int* (%Main*)*
}
@Main_vtable_prototype = constant %Main_vtable {
  i32 7,
  %String* @string_3,
  %Main* () * @Main_new,
  %String* (%Main*)* bitcast (%String* (%Object*)* @Object_type_name to %String* (%Main*)*),
  %Object* (%Main*)* bitcast (%Object* (%Object*)* @Object_abort to %Object* (%Main*)*),
  %IO* (%Main*, %String*)* bitcast (%IO* (%IO*, %String*)* @IO_out_string to %IO* (%Main*, %String*)*),
  %IO* (%Main*, %Int*)* bitcast (%IO* (%IO*, %Int*)* @IO_out_int to %IO* (%Main*, %Int*)*),
  %Int* (%Main*)* bitcast (%Int* (%IO*)* @IO_in_int to %Int* (%Main*)*),
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

define %Parent* @Parent_get(%Parent* %self) {
entry_0:
  %r0 = getelementptr %Parent, %Parent* %self, i32 0, i32 0
  %r1 = load %Parent_vtable*, %Parent_vtable** %r0
  %r2 = getelementptr %Parent_vtable, %Parent_vtable* %r1, i32 0, i32 2
  %r3 = load %Parent* () *, %Parent* () ** %r2
  %r4 = call %Parent* %r3()
  ret %Parent* %r4
}

define %OK* @OK_new() {
  %r0 = call i8* @malloc(i64 8)
  %r1 = bitcast i8* %r0 to %OK*
  ;; setting vtable
  %r2 = getelementptr %OK, %OK* %r1, i32 0, i32 0
  store %OK_vtable* @OK_vtable_prototype, %OK_vtable** %r2
  ret %OK* %r1
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
  %r0 = call %OK* @OK_new()
  %r1 = getelementptr %OK, %OK* %r0, i32 0, i32 0
  %r2 = load %OK_vtable*, %OK_vtable** %r1
  %r3 = getelementptr %OK_vtable, %OK_vtable* %r2, i32 0, i32 5
  %r4 = load %OK* (%OK*)*, %OK* (%OK*)** %r3
  %r5 = call %OK* %r4(%OK* %r0)
  %r6 = getelementptr %OK, %OK* %r5, i32 0, i32 0
  %r7 = load %OK_vtable*, %OK_vtable** %r6
  %r8 = getelementptr %OK_vtable, %OK_vtable* %r7, i32 0, i32 3
  %r9 = load %String* (%OK*)*, %String* (%OK*)** %r8
  %r10 = call %String* %r9(%OK* %r5)
  %r11 = getelementptr %String, %String* %r10, i32 0, i32 0
  %r12 = load %String_vtable*, %String_vtable** %r11
  %r13 = getelementptr %String_vtable, %String_vtable* %r12, i32 0, i32 6
  %r14 = load %String* (%String*, %String*)*, %String* (%String*, %String*)** %r13
  %r15 = call %String* %r14(%String* %r10, %String* @string_4)
  %r16 = getelementptr %Main, %Main* %self, i32 0, i32 0
  %r17 = load %Main_vtable*, %Main_vtable** %r16
  %r18 = getelementptr %Main_vtable, %Main_vtable* %r17, i32 0, i32 5
  %r19 = load %IO* (%Main*, %String*)*, %IO* (%Main*, %String*)** %r18
  %r20 = call %IO* %r19(%Main* %self, %String* %r15)
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

