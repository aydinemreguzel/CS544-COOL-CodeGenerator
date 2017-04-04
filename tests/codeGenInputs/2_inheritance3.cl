class Dummy {
  dummyX: Int;
};

class Child inherits Dummy {
  childX: Int;
  childY: Child;
  childZ: Dummy;
};

class GrandChild inherits Child {
  grandChildX: Int;
  grandChildY: String;
  grandChildZ: Sibling;
};

class Sibling inherits Dummy {
  siblingX: Int;
  siblingY: Child;
};

class Cousin inherits Sibling {
  cousinX: Cousin;
};

class Cousin2 inherits Sibling { };

class Main inherits IO {
  io: IO <- new IO;
  main(): Int { 42 };
};