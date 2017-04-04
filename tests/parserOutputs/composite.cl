#name "parserInputs/composite.cl"
Program:
  Class: Letty inherits Object
    Method: m1 (): Int
      Let: x: A
        Let: y: B
          Binary: ADD
            Id: x
            Int: 5
          Binary: ADD
            Id: f
            Binary: SUBTRACT
              Binary: MULTIPLY
                Id: g
                Binary: MULTIPLY
                  Id: h
                  Id: j
              DynDispatch: foo
                Id: x
