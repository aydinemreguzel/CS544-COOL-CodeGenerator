; Useful C functions
declare i32 @strcpy(i8*, i8*)
declare i32 @strncpy(i8*, i8*, i32)
declare i32 @strcat(i8*, i8*)
declare i32 @strlen(i8*)
declare i32 @printf(i8*, ...)
declare i32 @scanf(i8*, ...)
declare i8* @malloc(i64)
declare void @abort()

;;;
;;; Object class
;;;
%Object = type {
  %Object_vtable*
}

%Object_vtable = type {
  i32,  ;; class tag 
  %String*,  ;; type name
  %Object* ()*,         ;; pointer to the constructor function
  %String* (%Object*)*, ;; pointer to the 'type_name' method
  %Object* (%Object*)*  ;; pointer to the 'abort'function
}

@Object_vtable_prototype = constant %Object_vtable {
  i32 0,
  %String* @string_Object,
  %Object* ()* @Object_new,
  %String* (%Object*)* @Object_type_name,
  %Object* (%Object*)* @Object_abort
}

;;;
;;; Int class
;;;
%Int = type {
  %Int_vtable*,
  i32 ;; the actual int value
}

%Int_vtable = type {
  i32, ;; class tag
  %String*,  ;; type name
  %Int* ()*, ;; constructor
  ;; methods inherited from the parent (Object class)
  %String* (%Int*)*,  ;; type_name
  %Object* (%Int*)*  ;; abort
}

@Int_vtable_prototype = constant %Int_vtable {
  i32 1,
  %String* @string_Int,
  %Int* ()* @Int_new,
  %String* (%Int*)* bitcast (%String* (%Object*)* @Object_type_name to %String* (%Int*)*),
  %Object* (%Int*)* bitcast (%Object* (%Object*)* @Object_abort  to %Object* (%Int*)*)
}

;;;
;;; Bool class
;;;

%Bool = type {
  %Bool_vtable*,
  i1 ;; the actual bool value
}

%Bool_vtable = type {
  i32, ;; class tag
  %String*,  ;; type name
  %Bool* ()*, ;; constructor
  ;; methods inherited from the parent (Object class)
  %String* (%Bool*)*, ;; type_name
  %Object* (%Bool*)*  ;; abort
}

@Bool_vtable_prototype = constant %Bool_vtable {
  i32 2,
  %String* @string_Bool,
  %Bool* () * @Bool_new,
  %String* (%Bool*)* bitcast (%String* (%Object*)* @Object_type_name to %String* (%Bool*)*),
  %Object* (%Bool*)* bitcast (%Object* (%Object*)* @Object_abort  to %Object* (%Bool*)*)
}

;;;
;;; String class
;;;
%String = type {
  %String_vtable*,
  i32,  ;; number of characters
  i8*   ;; characters of this string
}

%String_vtable = type {
  i32, ;; class tag
  %String*,     ;; type name
  %String* ()*, ;; constructor
  ;; methods inherited from the parent (Object class)
  %String* (%String*)*, ;; type_name
  %Object* (%String*)*, ;; abort
  ;; methods defined in the String class
  %Int* (%String*)*,                   ;; length
  %String* (%String*,%String*)*,       ;; concat
  %String* (%String*, %Int*, %Int*)*   ;; substr
}

@String_vtable_prototype = constant %String_vtable {
  i32 3,
  %String* @string_String,
  %String* ()* @String_new,
  %String* (%String*)* bitcast (%String* (%Object*)* @Object_type_name to %String* (%String*)*),
  %Object* (%String*)* bitcast (%Object* (%Object*)* @Object_abort  to %Object* (%String*)*),
  %Int* (%String*)* @String_length,
  %String* (%String*,%String*)* @String_concat,
  %String* (%String*, %Int*, %Int*)* @String_substr
}

;;;
;;; IO class
;;;
%IO = type {
  %IO_vtable*
}

%IO_vtable = type {
  i32, ;; class tag
  %String*,  ;; type name
  %IO* ()*,  ;; constructor
  ;; methods inherited from the parent (Object class)
  %String* (%IO*)*,
  %Object* (%IO*)*,
  ;; methods defined in the IO class
  %IO* (%IO*,%String*)*,  ;; out_string
  %IO* (%IO*, %Int*)*,    ;; out_int
  %Int* (%IO*)*           ;; in_int
}

@IO_vtable_prototype = constant %IO_vtable {
  i32 4,
  %String* @string_IO,
  %IO* ()* @IO_new,
  %String* (%IO*)* bitcast (%String* (%Object*)* @Object_type_name to %String* (%IO*)*),
  %Object* (%IO*)* bitcast (%Object* (%Object*)* @Object_abort  to %Object* (%IO*)*),
  %IO* (%IO*, %String*)* @IO_out_string,
  %IO* (%IO*, %Int*)* @IO_out_int,
  %Int* (%IO*)* @IO_in_int
}

;;;
;;; Class names and the default string value as constants
;;;
@str_default = constant [1 x i8] c"\00";
@string_default = constant %String {
  %String_vtable* @String_vtable_prototype,
  i32 0,
  i8* getelementptr ([1 x i8], [1 x i8]* @str_default, i32 0, i32 0)
}

@str_Object = constant [7 x i8] c"Object\00";
@string_Object = constant %String {
  %String_vtable* @String_vtable_prototype,
  i32 6,
  i8* getelementptr ([7 x i8], [7 x i8]* @str_Object, i32 0, i32 0)
}

@str_Int = constant [4 x i8] c"Int\00";
@string_Int = constant %String {
  %String_vtable* @String_vtable_prototype,
  i32 3,
  i8* getelementptr ([4 x i8], [4 x i8]* @str_Int, i32 0, i32 0)
}

@str_Bool = constant [5 x i8] c"Bool\00";
@string_Bool = constant %String {
  %String_vtable* @String_vtable_prototype,
  i32 4,
  i8* getelementptr ([5 x i8], [5 x i8]* @str_Bool, i32 0, i32 0)
}

@str_String = constant [7 x i8] c"String\00";
@string_String = constant %String {
  %String_vtable* @String_vtable_prototype,
  i32 6,
  i8* getelementptr ([7 x i8], [7 x i8]* @str_String, i32 0, i32 0)
}

@str_IO = constant [3 x i8] c"IO\00";
@string_IO = constant %String {
  %String_vtable* @String_vtable_prototype,
  i32 2,
  i8* getelementptr ([3 x i8], [3 x i8]* @str_IO, i32 0, i32 0)
}

@strOutFormatStr = constant [3 x i8] c"%s\00"
@intOutFormatStr = constant [3 x i8] c"%d\00"
@intInFormatStr = constant [4 x i8] c"%d\0A\00"

;;;
;;; Methods
;;;

define %Object* @Object_new() {
  %m = call i8* @malloc(i64 8)    ;; sizeof Object is 8
  %p = bitcast i8* %m to %Object*
  %v = getelementptr %Object, %Object* %p, i32 0, i32 0
  store %Object_vtable* @Object_vtable_prototype, %Object_vtable** %v
  ret %Object* %p
}

define %String* @Object_type_name(%Object* %self) {
  %vtablePtrPtr = getelementptr %Object, %Object* %self, i32 0, i32 0
  %vtablePtr = load %Object_vtable*, %Object_vtable** %vtablePtrPtr
  %namePtr = getelementptr %Object_vtable, %Object_vtable* %vtablePtr, i32 0, i32 1
  %name = load %String*, %String** %namePtr

  ret %String* %name
}

define %Object* @Object_abort(%Object* %self) {
  call void @abort()
  ret %Object* null
}

define %Int* @Int_new() {
  %m = call i8* @malloc(i64 12)    ;; sizeof Int is 12
  %p = bitcast i8* %m to %Int*
  %v = getelementptr %Int, %Int* %p, i32 0, i32 0
  store %Int_vtable* @Int_vtable_prototype, %Int_vtable** %v
  %i = getelementptr %Int, %Int* %p, i32 0, i32 1
  store i32 0, i32* %i ;; Integers are initialized to 0 by default
  ret %Int* %p
}

define %Bool* @Bool_new() {
  %m = call i8* @malloc(i64 9)    ;; sizeof Bool is 9
  %p = bitcast i8* %m to %Bool*
  %v = getelementptr %Bool, %Bool* %p, i32 0, i32 0
  store %Bool_vtable* @Bool_vtable_prototype, %Bool_vtable** %v
  %i = getelementptr %Bool, %Bool* %p, i32 0, i32 1
  store i1 0, i1* %i ;; Bools are initialized to false by default
  ret %Bool* %p
}

define %String* @String_new() {
  %m = call i8* @malloc(i64 13)
  %p = bitcast i8* %m to %String*
  %v = getelementptr %String, %String* %p, i32 0, i32 0
  store %String_vtable* @String_vtable_prototype, %String_vtable** %v

  %numCharsPtr = getelementptr %String, %String* %p, i32 0, i32 1
  store i32 0, i32* %numCharsPtr

  %charsPtr = getelementptr %String, %String* %p, i32 0, i32 2
  %default = getelementptr [1 x i8], [1 x i8]* @str_default, i32 0, i32 0
  store i8* %default, i8** %charsPtr

  ret %String* %p
}

define %Int* @String_length(%String* %self) {
  %numCharsPtr = getelementptr %String, %String* %self, i32 0, i32 1
  %numChars = load i32, i32* %numCharsPtr
  
  %result = call %Int* @Int_new()
  %valuePtr = getelementptr %Int, %Int* %result, i32 0, i32 1
  store i32 %numChars, i32* %valuePtr 

  ret %Int* %result
}


define %String* @String_concat(%String* %self, %String* %other) {
  %numCharsPtr1 = getelementptr %String, %String* %self, i32 0, i32 1
  %numChars1 = load i32, i32* %numCharsPtr1
  %numCharsPtr2 = getelementptr %String, %String* %other, i32 0, i32 1
  %numChars2 = load i32, i32* %numCharsPtr2
  %numChars = add i32 %numChars1, %numChars2

  %charsPtr1 = getelementptr %String, %String* %self, i32 0, i32 2
  %chars1 = load i8*, i8** %charsPtr1
  %charsPtr2 = getelementptr %String, %String* %other, i32 0, i32 2
  %chars2 = load i8*, i8** %charsPtr2

  %mallocSize = add i32 %numChars, 1
  %mallocSize64 = sext i32 %mallocSize to i64
  %chars = call i8* @malloc(i64 %mallocSize64)

  %result = call %String* @String_new()
  %numCharsPtr = getelementptr %String, %String* %result, i32 0, i32 1
  store i32 %numChars, i32* %numCharsPtr
  %charsPtr = getelementptr %String, %String* %result, i32 0, i32 2
  store i8* %chars, i8** %charsPtr

  ;; Fill the contents
  %r1 = call i32 @strcpy(i8* %chars, i8* %chars1)
  %r2 = call i32 @strcat(i8* %chars, i8* %chars2)
  ;; Null terminator
  %lastCharPtr = getelementptr i8, i8* %chars, i32 %numChars
  store i8 0, i8* %lastCharPtr
  
  ret %String* %result
}

define %String* @String_substr(%String* %self, %Int* %fromInt, %Int* %lenInt) {
  %lenPtr = getelementptr %Int, %Int* %lenInt, i32 0, i32 1
  %len = load i32, i32* %lenPtr

  %fromPtr = getelementptr %Int, %Int* %fromInt, i32 0, i32 1
  %from = load i32, i32* %fromPtr

  %selfCharsPtr = getelementptr %String, %String* %self, i32 0, i32 2
  %selfChars = load i8*, i8** %selfCharsPtr
  %startCharsPtr = getelementptr i8, i8* %selfChars, i32 %from

  %mallocSize = add i32 %len, 1
  %mallocSize64 = sext i32 %mallocSize to i64
  %chars = call i8* @malloc(i64 %mallocSize64)

  %result = call %String* @String_new()
  %resultNumCharsPtr = getelementptr %String, %String* %result, i32 0, i32 1
  store i32 %len, i32* %resultNumCharsPtr
  %resultCharsPtr = getelementptr %String, %String* %result, i32 0, i32 2
  store i8* %chars, i8** %resultCharsPtr

  ;; Fill the contents
  %r1 = call i32 @strncpy(i8* %chars, i8* %startCharsPtr, i32 %len)
  ;; Null terminator
  %lastCharPtr = getelementptr i8, i8* %chars, i32 %len
  store i8 0, i8* %lastCharPtr

  ret %String* %result
}

define %IO* @IO_new() {
  %m = call i8* @malloc(i64 8)
  %p = bitcast i8* %m to %IO*
  %v = getelementptr %IO, %IO* %p, i32 0, i32 0
  store %IO_vtable* @IO_vtable_prototype, %IO_vtable** %v
  ret %IO* %p
}

define %IO* @IO_out_string(%IO* %self, %String* %s) {
  %charsPtr = getelementptr %String, %String* %s, i32 0, i32 2
  %chars = load i8*, i8** %charsPtr

  %formatStr = getelementptr [3 x i8], [3 x i8]* @strOutFormatStr, i32 0, i32 0
  %r1 = call i32 (i8*, ...) @printf(i8* %formatStr, i8* %chars)

  ret %IO* %self
}

define %IO* @IO_out_int(%IO* %self, %Int* %n) {
  %valPtr = getelementptr %Int, %Int* %n, i32 0, i32 1
  %val = load i32, i32* %valPtr

  %formatStr = getelementptr [3 x i8], [3 x i8]* @intOutFormatStr, i32 0, i32 0
  %r1 = call i32 (i8*, ...) @printf(i8* %formatStr, i32 %val)

  ret %IO* %self
}

define %Int* @IO_in_int(%IO* %self) {
  %n = call %Int* @Int_new()
  %intValPtr = getelementptr %Int, %Int* %n, i32 0, i32 1

  %formatStr = getelementptr [4 x i8], [4 x i8]* @intInFormatStr, i32 0, i32 0
  %r1 = call i32 (i8*, ...) @scanf(i8* %formatStr, i32* %intValPtr)

  ret %Int* %n
}

