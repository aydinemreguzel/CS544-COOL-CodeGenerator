class Parent {
  getX(a: Int, b: Int, c:Int) : Int { a + b + c };
};

class Child inherits Parent {
  getX(a: Int, b: Int, c: Int) : Int { a * b * c };
};

class Main {
   main() : Int {
     (new Child)@Parent.getX(10, 20, 12)
   };
};
