class Dummy {
};

class Child inherits Dummy {
};

class GrandChild inherits Child { };

class Sibling inherits Dummy { };

class Cousin inherits Sibling { };

class Cousin2 inherits Sibling { };

class Main inherits IO {
  main(): Int { 42 };
};