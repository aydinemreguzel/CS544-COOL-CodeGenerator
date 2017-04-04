class Parent {
  getX() : Int { 99 };
};

class Child inherits Parent {
  getX() : Int { 42 };
};

class Main {
   main() : Int {
     (new Child).getX()
   };
};
