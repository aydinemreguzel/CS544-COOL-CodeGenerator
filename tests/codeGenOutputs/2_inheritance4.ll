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
@int_20 = constant %Int {
  %Int_vtable* @Int_vtable_prototype,
  i32 20
}
@int_30 = constant %Int {
  %Int_vtable* @Int_vtable_prototype,
  i32 30
}
@int_35 = constant %Int {
  %Int_vtable* @Int_vtable_prototype,
  i32 35
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

@str_4 = constant [5 x i8] c"Main\00";
@string_4 = constant %String {
  %String_vtable* @String_vtable_prototype,
  i32 4,
  i8* getelementptr ([5 x i8], [5 x i8]* @str_4, i32 0, i32 0)
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
  %Int* (%Dummy*)* @Dummy_dummy
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
  %Int* (%Child*)*,
  %Int* (%Child*, %Int*, %Bool*, %String*)*
}
@Child_vtable_prototype = constant %Child_vtable {
  i32 6,
  %String* @string_2,
  %Child* () * @Child_new,
  %String* (%Child*)* bitcast (%String* (%Object*)* @Object_type_name to %String* (%Child*)*),
  %Object* (%Child*)* bitcast (%Object* (%Object*)* @Object_abort to %Object* (%Child*)*),
  %Int* (%Child*)* bitcast (%Int* (%Dummy*)* @Dummy_dummy to %Int* (%Child*)*),
  %Int* (%Child*, %Int*, %Bool*, %String*)* @Child_child
}
%GrandChild = type {
  %GrandChild_vtable*
}
%GrandChild_vtable = type {
  i32, ;; class tag
  %String*, ;; type name
  %GrandChild* () *,
  %String* (%GrandChild*)*,
  %Object* (%GrandChild*)*,
  %Int* (%GrandChild*)*,
  %Int* (%GrandChild*, %Int*, %Bool*, %String*)*,
  %Int* (%GrandChild*)*
}
@GrandChild_vtable_prototype = constant %GrandChild_vtable {
  i32 7,
  %String* @string_3,
  %GrandChild* () * @GrandChild_new,
  %String* (%GrandChild*)* bitcast (%String* (%Object*)* @Object_type_name to %String* (%GrandChild*)*),
  %Object* (%GrandChild*)* bitcast (%Object* (%Object*)* @Object_abort to %Object* (%GrandChild*)*),
  %Int* (%GrandChild*)* @GrandChild_dummy,
  %Int* (%GrandChild*, %Int*, %Bool*, %String*)* bitcast (%Int* (%Child*, %Int*, %Bool*, %String*)* @Child_child to %Int* (%GrandChild*, %Int*, %Bool*, %String*)*),
  %Int* (%GrandChild*)* @GrandChild_shushu
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
  i32 8,
  %String* @string_4,
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

define %Int* @Dummy_dummy(%Dummy* %self) {
entry_0:
  ret %Int* @int_10
}

define %Child* @Child_new() {
  %r0 = call i8* @malloc(i64 8)
  %r1 = bitcast i8* %r0 to %Child*
  ;; setting vtable
  %r2 = getelementptr %Child, %Child* %r1, i32 0, i32 0
  store %Child_vtable* @Child_vtable_prototype, %Child_vtable** %r2
  ret %Child* %r1
}

define %Int* @Child_child(%Child* %self, %Int* %x, %Bool* %y, %String* %z) {
entry_0:
  %r0 = alloca %Int*
  store %Int* %x, %Int** %r0
  %r1 = alloca %Bool*
  store %Bool* %y, %Bool** %r1
  %r2 = alloca %String*
  store %String* %z, %String** %r2
  ret %Int* @int_20
}

define %GrandChild* @GrandChild_new() {
  %r0 = call i8* @malloc(i64 8)
  %r1 = bitcast i8* %r0 to %GrandChild*
  ;; setting vtable
  %r2 = getelementptr %GrandChild, %GrandChild* %r1, i32 0, i32 0
  store %GrandChild_vtable* @GrandChild_vtable_prototype, %GrandChild_vtable** %r2
  ret %GrandChild* %r1
}

define %Int* @GrandChild_shushu(%GrandChild* %self) {
entry_0:
  ret %Int* @int_35
}

define %Int* @GrandChild_dummy(%GrandChild* %self) {
entry_0:
  ret %Int* @int_30
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

