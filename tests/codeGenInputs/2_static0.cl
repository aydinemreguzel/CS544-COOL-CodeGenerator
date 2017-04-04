class Parent {
  getX() : Int { 42 };
};

class Child inherits Parent {
  getX() : Int { 99 };
};

class Main {
   main() : Int {
     (new Child)@Parent.getX()
   };
};
