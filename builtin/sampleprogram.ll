;; Some constant String and Int objects
@str.0 = constant [7 x i8] c"Hello \00"
@stringHello = constant %String {
  %String_vtable* @String_vtable_prototype,
  i32 6,
  i8* getelementptr ([7 x i8], [7 x i8]* @str.0, i32 0, i32 0)
}

@str.1 = constant [9 x i8] c"world!!!\00"
@stringWorld = constant %String {
  %String_vtable* @String_vtable_prototype,
  i32 8,
  i8* getelementptr ([9 x i8], [9 x i8]* @str.1, i32 0, i32 0)
}

@str.2 = constant [2 x i8] c"\0A\00"
@newline = constant %String {
  %String_vtable* @String_vtable_prototype,
  i32 1,
  i8* getelementptr ([2 x i8], [2 x i8]* @str.2, i32 0, i32 0)
}

@int3 = constant %Int {
  %Int_vtable* @Int_vtable_prototype,
  i32 3
}

@int6 = constant %Int {
  %Int_vtable* @Int_vtable_prototype,
  i32 6
}


define i32 @main() {
entry:
  %ignore1 = call %IO* @IO_out_int(%IO* null, %Int* @int3)
  %ignore2 = call %IO* @IO_out_string(%IO* null, %String* @newline)

  %concat = call %String* @String_concat(%String* @stringHello, %String* @stringWorld)
  %ignore3 = call %IO* @IO_out_string(%IO* null, %String* %concat)
  %ignore4 = call %IO* @IO_out_string(%IO* null, %String* @newline)

  %sub = call %String* @String_substr(%String* %concat, %Int* @int3, %Int* @int6)
  %ignore5 = call %IO* @IO_out_string(%IO* null, %String* %sub)
  %ignore6 = call %IO* @IO_out_string(%IO* null, %String* @newline)

  %subLen = call %Int* @String_length(%String* %sub)
  %ignore7 = call %IO* @IO_out_int(%IO* null, %Int* %subLen)
  %ignore8 = call %IO* @IO_out_string(%IO* null, %String* @newline)

  ;; Perform 3 + 6, then print the result.
  ;; This illustrates unboxing and boxing. 
  %threePtr = getelementptr %Int, %Int* @int3, i32 0, i32 1
  %three = load i32, i32* %threePtr
  %sixPtr = getelementptr %Int, %Int* @int6, i32 0, i32 1
  %six = load i32, i32* %sixPtr
  %sum = add i32 %three, %six
  %intsum = call %Int* @Int_new()
  %intsumValuePtr = getelementptr %Int, %Int* %intsum, i32 0, i32 1
  store i32 %sum, i32* %intsumValuePtr
  %ignore9 = call %IO* @IO_out_int(%IO* null, %Int* %intsum)
  %ignore10 = call %IO* @IO_out_string(%IO* null, %String* @newline)

  ;; Perform 3.type_name().
  ;; E.g. let x: Object <- 3 in x.type_name()
  %x = bitcast %Int* @int3 to %Object*
  %vtablePtrPtr = getelementptr %Object, %Object* %x, i32 0, i32 0
  %vtablePtr = load %Object_vtable*, %Object_vtable** %vtablePtrPtr
  %funPtr = getelementptr %Object_vtable, %Object_vtable* %vtablePtr, i32 0, i32 3
  %fun = load %String* (%Object*) *, %String* (%Object*) ** %funPtr
  %typeName = call %String* %fun(%Object* %x)
  %ignore11 = call %IO* @IO_out_string(%IO* null, %String* %typeName)
  %ignore12 = call %IO* @IO_out_string(%IO* null, %String* @newline)

  ret i32 0
}

