class Parent {
  getX() : Int { 99 };
};

class Child inherits Parent {
  getX() : Int { 42 };
};

class GrandChild inherits Child {

};

class Main {
   main() : Int {
     let p: Parent <- new GrandChild in
     p.getX()
   };
};
