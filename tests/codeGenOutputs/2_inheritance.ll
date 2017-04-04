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

@str_4 = constant [8 x i8] c"Sibling\00";
@string_4 = constant %String {
  %String_vtable* @String_vtable_prototype,
  i32 7,
  i8* getelementptr ([8 x i8], [8 x i8]* @str_4, i32 0, i32 0)
}

@str_5 = constant [7 x i8] c"Cousin\00";
@string_5 = constant %String {
  %String_vtable* @String_vtable_prototype,
  i32 6,
  i8* getelementptr ([7 x i8], [7 x i8]* @str_5, i32 0, i32 0)
}

@str_6 = constant [8 x i8] c"Cousin2\00";
@string_6 = constant %String {
  %String_vtable* @String_vtable_prototype,
  i32 7,
  i8* getelementptr ([8 x i8], [8 x i8]* @str_6, i32 0, i32 0)
}

@str_7 = constant [5 x i8] c"Main\00";
@string_7 = constant %String {
  %String_vtable* @String_vtable_prototype,
  i32 4,
  i8* getelementptr ([5 x i8], [5 x i8]* @str_7, i32 0, i32 0)
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
%Child = type {
  %Child_vtable*
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
  %GrandChild_vtable*
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
%Sibling = type {
  %Sibling_vtable*
}
%Sibling_vtable = type {
  i32, ;; class tag
  %String*, ;; type name
  %Sibling* () *,
  %String* (%Sibling*)*,
  %Object* (%Sibling*)*
}
@Sibling_vtable_prototype = constant %Sibling_vtable {
  i32 8,
  %String* @string_4,
  %Sibling* () * @Sibling_new,
  %String* (%Sibling*)* bitcast (%String* (%Object*)* @Object_type_name to %String* (%Sibling*)*),
  %Object* (%Sibling*)* bitcast (%Object* (%Object*)* @Object_abort to %Object* (%Sibling*)*)
}
%Cousin = type {
  %Cousin_vtable*
}
%Cousin_vtable = type {
  i32, ;; class tag
  %String*, ;; type name
  %Cousin* () *,
  %String* (%Cousin*)*,
  %Object* (%Cousin*)*
}
@Cousin_vtable_prototype = constant %Cousin_vtable {
  i32 9,
  %String* @string_5,
  %Cousin* () * @Cousin_new,
  %String* (%Cousin*)* bitcast (%String* (%Object*)* @Object_type_name to %String* (%Cousin*)*),
  %Object* (%Cousin*)* bitcast (%Object* (%Object*)* @Object_abort to %Object* (%Cousin*)*)
}
%Cousin2 = type {
  %Cousin2_vtable*
}
%Cousin2_vtable = type {
  i32, ;; class tag
  %String*, ;; type name
  %Cousin2* () *,
  %String* (%Cousin2*)*,
  %Object* (%Cousin2*)*
}
@Cousin2_vtable_prototype = constant %Cousin2_vtable {
  i32 10,
  %String* @string_6,
  %Cousin2* () * @Cousin2_new,
  %String* (%Cousin2*)* bitcast (%String* (%Object*)* @Object_type_name to %String* (%Cousin2*)*),
  %Object* (%Cousin2*)* bitcast (%Object* (%Object*)* @Object_abort to %Object* (%Cousin2*)*)
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
  i32 11,
  %String* @string_7,
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
define %Dummy* @Dummy_new() {
  %r0 = call i8* @malloc(i64 8)
  %r1 = bitcast i8* %r0 to %Dummy*
  ;; setting vtable
  %r2 = getelementptr %Dummy, %Dummy* %r1, i32 0, i32 0
  store %Dummy_vtable* @Dummy_vtable_prototype, %Dummy_vtable** %r2
  ret %Dummy* %r1
}

define %Child* @Child_new() {
  %r0 = call i8* @malloc(i64 8)
  %r1 = bitcast i8* %r0 to %Child*
  ;; setting vtable
  %r2 = getelementptr %Child, %Child* %r1, i32 0, i32 0
  store %Child_vtable* @Child_vtable_prototype, %Child_vtable** %r2
  ret %Child* %r1
}

define %GrandChild* @GrandChild_new() {
  %r0 = call i8* @malloc(i64 8)
  %r1 = bitcast i8* %r0 to %GrandChild*
  ;; setting vtable
  %r2 = getelementptr %GrandChild, %GrandChild* %r1, i32 0, i32 0
  store %GrandChild_vtable* @GrandChild_vtable_prototype, %GrandChild_vtable** %r2
  ret %GrandChild* %r1
}

define %Sibling* @Sibling_new() {
  %r0 = call i8* @malloc(i64 8)
  %r1 = bitcast i8* %r0 to %Sibling*
  ;; setting vtable
  %r2 = getelementptr %Sibling, %Sibling* %r1, i32 0, i32 0
  store %Sibling_vtable* @Sibling_vtable_prototype, %Sibling_vtable** %r2
  ret %Sibling* %r1
}

define %Cousin* @Cousin_new() {
  %r0 = call i8* @malloc(i64 8)
  %r1 = bitcast i8* %r0 to %Cousin*
  ;; setting vtable
  %r2 = getelementptr %Cousin, %Cousin* %r1, i32 0, i32 0
  store %Cousin_vtable* @Cousin_vtable_prototype, %Cousin_vtable** %r2
  ret %Cousin* %r1
}

define %Cousin2* @Cousin2_new() {
  %r0 = call i8* @malloc(i64 8)
  %r1 = bitcast i8* %r0 to %Cousin2*
  ;; setting vtable
  %r2 = getelementptr %Cousin2, %Cousin2* %r1, i32 0, i32 0
  store %Cousin2_vtable* @Cousin2_vtable_prototype, %Cousin2_vtable** %r2
  ret %Cousin2* %r1
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

