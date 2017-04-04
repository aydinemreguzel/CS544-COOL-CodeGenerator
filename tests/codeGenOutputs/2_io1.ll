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
@int_2 = constant %Int {
  %Int_vtable* @Int_vtable_prototype,
  i32 2
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

@str_2 = constant [5 x i8] c"hell\00";
@string_2 = constant %String {
  %String_vtable* @String_vtable_prototype,
  i32 4,
  i8* getelementptr ([5 x i8], [5 x i8]* @str_2, i32 0, i32 0)
}
;;;;;;;;;;;;;;;;;;;;;
;;;  DATA LAYOUT  ;;;
;;;;;;;;;;;;;;;;;;;;;
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
  i32 5,
  %String* @string_1,
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
  %r0 = getelementptr %String, %String* @string_2, i32 0, i32 0
  %r1 = load %String_vtable*, %String_vtable** %r0
  %r2 = getelementptr %String_vtable, %String_vtable* %r1, i32 0, i32 5
  %r3 = load %Int* (%String*)*, %Int* (%String*)** %r2
  %r4 = call %Int* %r3(%String* @string_2)
  %r5 = getelementptr %Main, %Main* %self, i32 0, i32 0
  %r6 = load %Main_vtable*, %Main_vtable** %r5
  %r7 = getelementptr %Main_vtable, %Main_vtable* %r6, i32 0, i32 6
  %r8 = load %IO* (%Main*, %Int*)*, %IO* (%Main*, %Int*)** %r7
  %r9 = call %IO* %r8(%Main* %self, %Int* %r4)
  ret %Int* @int_2
}

define i32 @main() {
  %mainobj = call %Main* @Main_new()
  %r0 = call %Int* @Main_main(%Main* %mainobj)
  ;; unboxing %Int* %r0
  %r1 = getelementptr %Int, %Int* %r0, i32 0, i32 1
  %r2 = load i32, i32* %r1
  ret i32 %r2
}

