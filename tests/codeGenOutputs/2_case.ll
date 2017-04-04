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
@int_111 = constant %Int {
  %Int_vtable* @Int_vtable_prototype,
  i32 111
}
@int_42 = constant %Int {
  %Int_vtable* @Int_vtable_prototype,
  i32 42
}
@int_55 = constant %Int {
  %Int_vtable* @Int_vtable_prototype,
  i32 55
}
@int_66 = constant %Int {
  %Int_vtable* @Int_vtable_prototype,
  i32 66
}
@int_77 = constant %Int {
  %Int_vtable* @Int_vtable_prototype,
  i32 77
}
@int_88 = constant %Int {
  %Int_vtable* @Int_vtable_prototype,
  i32 88
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

@str_10 = constant [10 x i8] c"FAIL Int\0A\00";
@string_10 = constant %String {
  %String_vtable* @String_vtable_prototype,
  i32 9,
  i8* getelementptr ([10 x i8], [10 x i8]* @str_10, i32 0, i32 0)
}

@str_11 = constant [13 x i8] c"FAIL Parent\0A\00";
@string_11 = constant %String {
  %String_vtable* @String_vtable_prototype,
  i32 12,
  i8* getelementptr ([13 x i8], [13 x i8]* @str_11, i32 0, i32 0)
}

@str_12 = constant [13 x i8] c"FAIL Object\0A\00";
@string_12 = constant %String {
  %String_vtable* @String_vtable_prototype,
  i32 12,
  i8* getelementptr ([13 x i8], [13 x i8]* @str_12, i32 0, i32 0)
}

@str_13 = constant [4 x i8] c"OK\0A\00";
@string_13 = constant %String {
  %String_vtable* @String_vtable_prototype,
  i32 3,
  i8* getelementptr ([4 x i8], [4 x i8]* @str_13, i32 0, i32 0)
}

@str_14 = constant [20 x i8] c"FAIL GrandSibling2\0A\00";
@string_14 = constant %String {
  %String_vtable* @String_vtable_prototype,
  i32 19,
  i8* getelementptr ([20 x i8], [20 x i8]* @str_14, i32 0, i32 0)
}

@str_15 = constant [14 x i8] c"FAIL Brother\0A\00";
@string_15 = constant %String {
  %String_vtable* @String_vtable_prototype,
  i32 13,
  i8* getelementptr ([14 x i8], [14 x i8]* @str_15, i32 0, i32 0)
}

@str_2 = constant [7 x i8] c"Sister\00";
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

@str_4 = constant [13 x i8] c"GrandSibling\00";
@string_4 = constant %String {
  %String_vtable* @String_vtable_prototype,
  i32 12,
  i8* getelementptr ([13 x i8], [13 x i8]* @str_4, i32 0, i32 0)
}

@str_5 = constant [11 x i8] c"GrandChild\00";
@string_5 = constant %String {
  %String_vtable* @String_vtable_prototype,
  i32 10,
  i8* getelementptr ([11 x i8], [11 x i8]* @str_5, i32 0, i32 0)
}

@str_6 = constant [16 x i8] c"GrandGrandChild\00";
@string_6 = constant %String {
  %String_vtable* @String_vtable_prototype,
  i32 15,
  i8* getelementptr ([16 x i8], [16 x i8]* @str_6, i32 0, i32 0)
}

@str_7 = constant [14 x i8] c"GrandSibling2\00";
@string_7 = constant %String {
  %String_vtable* @String_vtable_prototype,
  i32 13,
  i8* getelementptr ([14 x i8], [14 x i8]* @str_7, i32 0, i32 0)
}

@str_8 = constant [8 x i8] c"Brother\00";
@string_8 = constant %String {
  %String_vtable* @String_vtable_prototype,
  i32 7,
  i8* getelementptr ([8 x i8], [8 x i8]* @str_8, i32 0, i32 0)
}

@str_9 = constant [5 x i8] c"Main\00";
@string_9 = constant %String {
  %String_vtable* @String_vtable_prototype,
  i32 4,
  i8* getelementptr ([5 x i8], [5 x i8]* @str_9, i32 0, i32 0)
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
  %Int* (%Parent*)* @Parent_get
}
%Sister = type {
  %Sister_vtable*
}
%Sister_vtable = type {
  i32, ;; class tag
  %String*, ;; type name
  %Sister* () *,
  %String* (%Sister*)*,
  %Object* (%Sister*)*,
  %Int* (%Sister*)*
}
@Sister_vtable_prototype = constant %Sister_vtable {
  i32 6,
  %String* @string_2,
  %Sister* () * @Sister_new,
  %String* (%Sister*)* bitcast (%String* (%Object*)* @Object_type_name to %String* (%Sister*)*),
  %Object* (%Sister*)* bitcast (%Object* (%Object*)* @Object_abort to %Object* (%Sister*)*),
  %Int* (%Sister*)* bitcast (%Int* (%Parent*)* @Parent_get to %Int* (%Sister*)*)
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
  i32 7,
  %String* @string_3,
  %Child* () * @Child_new,
  %String* (%Child*)* bitcast (%String* (%Object*)* @Object_type_name to %String* (%Child*)*),
  %Object* (%Child*)* bitcast (%Object* (%Object*)* @Object_abort to %Object* (%Child*)*),
  %Int* (%Child*)* @Child_get
}
%GrandSibling = type {
  %GrandSibling_vtable*
}
%GrandSibling_vtable = type {
  i32, ;; class tag
  %String*, ;; type name
  %GrandSibling* () *,
  %String* (%GrandSibling*)*,
  %Object* (%GrandSibling*)*,
  %Int* (%GrandSibling*)*
}
@GrandSibling_vtable_prototype = constant %GrandSibling_vtable {
  i32 8,
  %String* @string_4,
  %GrandSibling* () * @GrandSibling_new,
  %String* (%GrandSibling*)* bitcast (%String* (%Object*)* @Object_type_name to %String* (%GrandSibling*)*),
  %Object* (%GrandSibling*)* bitcast (%Object* (%Object*)* @Object_abort to %Object* (%GrandSibling*)*),
  %Int* (%GrandSibling*)* bitcast (%Int* (%Child*)* @Child_get to %Int* (%GrandSibling*)*)
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
  %Int* (%GrandChild*)*
}
@GrandChild_vtable_prototype = constant %GrandChild_vtable {
  i32 9,
  %String* @string_5,
  %GrandChild* () * @GrandChild_new,
  %String* (%GrandChild*)* bitcast (%String* (%Object*)* @Object_type_name to %String* (%GrandChild*)*),
  %Object* (%GrandChild*)* bitcast (%Object* (%Object*)* @Object_abort to %Object* (%GrandChild*)*),
  %Int* (%GrandChild*)* @GrandChild_get
}
%GrandGrandChild = type {
  %GrandGrandChild_vtable*
}
%GrandGrandChild_vtable = type {
  i32, ;; class tag
  %String*, ;; type name
  %GrandGrandChild* () *,
  %String* (%GrandGrandChild*)*,
  %Object* (%GrandGrandChild*)*,
  %Int* (%GrandGrandChild*)*
}
@GrandGrandChild_vtable_prototype = constant %GrandGrandChild_vtable {
  i32 10,
  %String* @string_6,
  %GrandGrandChild* () * @GrandGrandChild_new,
  %String* (%GrandGrandChild*)* bitcast (%String* (%Object*)* @Object_type_name to %String* (%GrandGrandChild*)*),
  %Object* (%GrandGrandChild*)* bitcast (%Object* (%Object*)* @Object_abort to %Object* (%GrandGrandChild*)*),
  %Int* (%GrandGrandChild*)* @GrandGrandChild_get
}
%GrandSibling2 = type {
  %GrandSibling2_vtable*
}
%GrandSibling2_vtable = type {
  i32, ;; class tag
  %String*, ;; type name
  %GrandSibling2* () *,
  %String* (%GrandSibling2*)*,
  %Object* (%GrandSibling2*)*,
  %Int* (%GrandSibling2*)*
}
@GrandSibling2_vtable_prototype = constant %GrandSibling2_vtable {
  i32 11,
  %String* @string_7,
  %GrandSibling2* () * @GrandSibling2_new,
  %String* (%GrandSibling2*)* bitcast (%String* (%Object*)* @Object_type_name to %String* (%GrandSibling2*)*),
  %Object* (%GrandSibling2*)* bitcast (%Object* (%Object*)* @Object_abort to %Object* (%GrandSibling2*)*),
  %Int* (%GrandSibling2*)* @GrandSibling2_get
}
%Brother = type {
  %Brother_vtable*
}
%Brother_vtable = type {
  i32, ;; class tag
  %String*, ;; type name
  %Brother* () *,
  %String* (%Brother*)*,
  %Object* (%Brother*)*,
  %Int* (%Brother*)*
}
@Brother_vtable_prototype = constant %Brother_vtable {
  i32 12,
  %String* @string_8,
  %Brother* () * @Brother_new,
  %String* (%Brother*)* bitcast (%String* (%Object*)* @Object_type_name to %String* (%Brother*)*),
  %Object* (%Brother*)* bitcast (%Object* (%Object*)* @Object_abort to %Object* (%Brother*)*),
  %Int* (%Brother*)* bitcast (%Int* (%Parent*)* @Parent_get to %Int* (%Brother*)*)
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
  i32 13,
  %String* @string_9,
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

define %Int* @Parent_get(%Parent* %self) {
entry_0:
  ret %Int* @int_66
}

define %Sister* @Sister_new() {
  %r0 = call i8* @malloc(i64 8)
  %r1 = bitcast i8* %r0 to %Sister*
  ;; setting vtable
  %r2 = getelementptr %Sister, %Sister* %r1, i32 0, i32 0
  store %Sister_vtable* @Sister_vtable_prototype, %Sister_vtable** %r2
  ret %Sister* %r1
}

define %Child* @Child_new() {
  %r0 = call i8* @malloc(i64 8)
  %r1 = bitcast i8* %r0 to %Child*
  ;; setting vtable
  %r2 = getelementptr %Child, %Child* %r1, i32 0, i32 0
  store %Child_vtable* @Child_vtable_prototype, %Child_vtable** %r2
  ret %Child* %r1
}

define %Int* @Child_get(%Child* %self) {
entry_0:
  ret %Int* @int_77
}

define %GrandSibling* @GrandSibling_new() {
  %r0 = call i8* @malloc(i64 8)
  %r1 = bitcast i8* %r0 to %GrandSibling*
  ;; setting vtable
  %r2 = getelementptr %GrandSibling, %GrandSibling* %r1, i32 0, i32 0
  store %GrandSibling_vtable* @GrandSibling_vtable_prototype, %GrandSibling_vtable** %r2
  ret %GrandSibling* %r1
}

define %GrandChild* @GrandChild_new() {
  %r0 = call i8* @malloc(i64 8)
  %r1 = bitcast i8* %r0 to %GrandChild*
  ;; setting vtable
  %r2 = getelementptr %GrandChild, %GrandChild* %r1, i32 0, i32 0
  store %GrandChild_vtable* @GrandChild_vtable_prototype, %GrandChild_vtable** %r2
  ret %GrandChild* %r1
}

define %Int* @GrandChild_get(%GrandChild* %self) {
entry_0:
  ret %Int* @int_88
}

define %GrandGrandChild* @GrandGrandChild_new() {
  %r0 = call i8* @malloc(i64 8)
  %r1 = bitcast i8* %r0 to %GrandGrandChild*
  ;; setting vtable
  %r2 = getelementptr %GrandGrandChild, %GrandGrandChild* %r1, i32 0, i32 0
  store %GrandGrandChild_vtable* @GrandGrandChild_vtable_prototype, %GrandGrandChild_vtable** %r2
  ret %GrandGrandChild* %r1
}

define %Int* @GrandGrandChild_get(%GrandGrandChild* %self) {
entry_0:
  ret %Int* @int_42
}

define %GrandSibling2* @GrandSibling2_new() {
  %r0 = call i8* @malloc(i64 8)
  %r1 = bitcast i8* %r0 to %GrandSibling2*
  ;; setting vtable
  %r2 = getelementptr %GrandSibling2, %GrandSibling2* %r1, i32 0, i32 0
  store %GrandSibling2_vtable* @GrandSibling2_vtable_prototype, %GrandSibling2_vtable** %r2
  ret %GrandSibling2* %r1
}

define %Int* @GrandSibling2_get(%GrandSibling2* %self) {
entry_0:
  ret %Int* @int_111
}

define %Brother* @Brother_new() {
  %r0 = call i8* @malloc(i64 8)
  %r1 = bitcast i8* %r0 to %Brother*
  ;; setting vtable
  %r2 = getelementptr %Brother, %Brother* %r1, i32 0, i32 0
  store %Brother_vtable* @Brother_vtable_prototype, %Brother_vtable** %r2
  ret %Brother* %r1
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
  ;; Emitting case expr
  %r0 = call %GrandGrandChild* @GrandGrandChild_new()
  %r1 = bitcast %GrandGrandChild* %r0 to %Object*
  %r2 = getelementptr %Object, %Object* %r1, i32 0, i32 0
  %r3 = load %Object_vtable*, %Object_vtable** %r2
  %r4 = getelementptr %Object_vtable, %Object_vtable* %r3, i32 0, i32 0
  %r5 = load i32, i32* %r4
  %r6 = alloca %Int*
  ;; checking for case Brother
  %r7 = icmp sge i32 %r5, 12
  %r8 = icmp sle i32 %r5, 12
  %r9 = and i1 %r7, %r8
  br i1 %r9, label %true_2, label %false_3
true_2:
  %r10 = bitcast %Object* %r1 to %Brother*
  %r11 = alloca %Brother*
  store %Brother* %r10, %Brother** %r11
  %r12 = getelementptr %Main, %Main* %self, i32 0, i32 0
  %r13 = load %Main_vtable*, %Main_vtable** %r12
  %r14 = getelementptr %Main_vtable, %Main_vtable* %r13, i32 0, i32 5
  %r15 = load %IO* (%Main*, %String*)*, %IO* (%Main*, %String*)** %r14
  %r16 = call %IO* %r15(%Main* %self, %String* @string_15)
  %r17 = load %Brother*, %Brother** %r11
  %r18 = getelementptr %Brother, %Brother* %r17, i32 0, i32 0
  %r19 = load %Brother_vtable*, %Brother_vtable** %r18
  %r20 = getelementptr %Brother_vtable, %Brother_vtable* %r19, i32 0, i32 5
  %r21 = load %Int* (%Brother*)*, %Int* (%Brother*)** %r20
  %r22 = call %Int* %r21(%Brother* %r17)
  store %Int* %r22, %Int** %r6
  br label %exit_1
false_3:
  ;; checking for case GrandSibling2
  %r23 = icmp sge i32 %r5, 11
  %r24 = icmp sle i32 %r5, 11
  %r25 = and i1 %r23, %r24
  br i1 %r25, label %true_4, label %false_5
true_4:
  %r26 = bitcast %Brother* %r10 to %GrandSibling2*
  %r27 = alloca %GrandSibling2*
  store %GrandSibling2* %r26, %GrandSibling2** %r27
  %r28 = getelementptr %Main, %Main* %self, i32 0, i32 0
  %r29 = load %Main_vtable*, %Main_vtable** %r28
  %r30 = getelementptr %Main_vtable, %Main_vtable* %r29, i32 0, i32 5
  %r31 = load %IO* (%Main*, %String*)*, %IO* (%Main*, %String*)** %r30
  %r32 = call %IO* %r31(%Main* %self, %String* @string_14)
  %r33 = load %GrandSibling2*, %GrandSibling2** %r27
  %r34 = getelementptr %GrandSibling2, %GrandSibling2* %r33, i32 0, i32 0
  %r35 = load %GrandSibling2_vtable*, %GrandSibling2_vtable** %r34
  %r36 = getelementptr %GrandSibling2_vtable, %GrandSibling2_vtable* %r35, i32 0, i32 5
  %r37 = load %Int* (%GrandSibling2*)*, %Int* (%GrandSibling2*)** %r36
  %r38 = call %Int* %r37(%GrandSibling2* %r33)
  store %Int* %r38, %Int** %r6
  br label %exit_1
false_5:
  ;; checking for case Child
  %r39 = icmp sge i32 %r5, 7
  %r40 = icmp sle i32 %r5, 11
  %r41 = and i1 %r39, %r40
  br i1 %r41, label %true_6, label %false_7
true_6:
  %r42 = bitcast %GrandSibling2* %r26 to %Child*
  %r43 = alloca %Child*
  store %Child* %r42, %Child** %r43
  %r44 = getelementptr %Main, %Main* %self, i32 0, i32 0
  %r45 = load %Main_vtable*, %Main_vtable** %r44
  %r46 = getelementptr %Main_vtable, %Main_vtable* %r45, i32 0, i32 5
  %r47 = load %IO* (%Main*, %String*)*, %IO* (%Main*, %String*)** %r46
  %r48 = call %IO* %r47(%Main* %self, %String* @string_13)
  %r49 = load %Child*, %Child** %r43
  %r50 = getelementptr %Child, %Child* %r49, i32 0, i32 0
  %r51 = load %Child_vtable*, %Child_vtable** %r50
  %r52 = getelementptr %Child_vtable, %Child_vtable* %r51, i32 0, i32 5
  %r53 = load %Int* (%Child*)*, %Int* (%Child*)** %r52
  %r54 = call %Int* %r53(%Child* %r49)
  store %Int* %r54, %Int** %r6
  br label %exit_1
false_7:
  ;; checking for case Parent
  %r55 = icmp sge i32 %r5, 5
  %r56 = icmp sle i32 %r5, 12
  %r57 = and i1 %r55, %r56
  br i1 %r57, label %true_8, label %false_9
true_8:
  %r58 = bitcast %Child* %r42 to %Parent*
  %r59 = alloca %Parent*
  store %Parent* %r58, %Parent** %r59
  %r60 = getelementptr %Main, %Main* %self, i32 0, i32 0
  %r61 = load %Main_vtable*, %Main_vtable** %r60
  %r62 = getelementptr %Main_vtable, %Main_vtable* %r61, i32 0, i32 5
  %r63 = load %IO* (%Main*, %String*)*, %IO* (%Main*, %String*)** %r62
  %r64 = call %IO* %r63(%Main* %self, %String* @string_11)
  %r65 = load %Parent*, %Parent** %r59
  %r66 = getelementptr %Parent, %Parent* %r65, i32 0, i32 0
  %r67 = load %Parent_vtable*, %Parent_vtable** %r66
  %r68 = getelementptr %Parent_vtable, %Parent_vtable* %r67, i32 0, i32 5
  %r69 = load %Int* (%Parent*)*, %Int* (%Parent*)** %r68
  %r70 = call %Int* %r69(%Parent* %r65)
  store %Int* %r70, %Int** %r6
  br label %exit_1
false_9:
  ;; checking for case Int
  %r71 = icmp sge i32 %r5, 1
  %r72 = icmp sle i32 %r5, 1
  %r73 = and i1 %r71, %r72
  br i1 %r73, label %true_10, label %false_11
true_10:
  %r74 = bitcast %Parent* %r58 to %Int*
  %r75 = alloca %Int*
  store %Int* %r74, %Int** %r75
  %r76 = getelementptr %Main, %Main* %self, i32 0, i32 0
  %r77 = load %Main_vtable*, %Main_vtable** %r76
  %r78 = getelementptr %Main_vtable, %Main_vtable* %r77, i32 0, i32 5
  %r79 = load %IO* (%Main*, %String*)*, %IO* (%Main*, %String*)** %r78
  %r80 = call %IO* %r79(%Main* %self, %String* @string_10)
  store %Int* @int_55, %Int** %r6
  br label %exit_1
false_11:
  ;; checking for case Object
  %r81 = icmp sge i32 %r5, 0
  %r82 = icmp sle i32 %r5, 13
  %r83 = and i1 %r81, %r82
  br i1 %r83, label %true_12, label %false_13
true_12:
  %r84 = bitcast %Int* %r74 to %Object*
  %r85 = alloca %Object*
  store %Object* %r84, %Object** %r85
  %r86 = getelementptr %Main, %Main* %self, i32 0, i32 0
  %r87 = load %Main_vtable*, %Main_vtable** %r86
  %r88 = getelementptr %Main_vtable, %Main_vtable* %r87, i32 0, i32 5
  %r89 = load %IO* (%Main*, %String*)*, %IO* (%Main*, %String*)** %r88
  %r90 = call %IO* %r89(%Main* %self, %String* @string_12)
  store %Int* @int_99, %Int** %r6
  br label %exit_1
false_13:
  ;; Match failure. 
  call void @abort()
  unreachable
exit_1:
  %r91 = load %Int*, %Int** %r6
  ret %Int* %r91
}

define i32 @main() {
  %mainobj = call %Main* @Main_new()
  %r0 = call %Int* @Main_main(%Main* %mainobj)
  ;; unboxing %Int* %r0
  %r1 = getelementptr %Int, %Int* %r0, i32 0, i32 1
  %r2 = load i32, i32* %r1
  ret i32 %r2
}

