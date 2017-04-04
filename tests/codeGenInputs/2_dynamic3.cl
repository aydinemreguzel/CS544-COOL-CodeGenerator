class Parent {
  getX() : Int { 99 };
};

class Child inherits Parent {
  getX() : Int { 42 };
};

class Main {
   main() : Int {
     let p: Parent <- new Child in
     p.getX()
   };
};
