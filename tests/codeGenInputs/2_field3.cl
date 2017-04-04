class Parent {
  a: Int;
  b: Int;
  c: Int;
};

class Child inherits Parent {
  d: Int;
};

class GrandChild inherits Child {
  e: Int;
  c: Int;
  g: Int;
};

class Main inherits GrandChild {
  h: Int;
  main(): Int {{ c; 42; }};
};