class Dummy {
  getX(a: Int, b: Int, c: Int) : Int { a + b + c };
};

class Main {
   main() : Int {
     (new Dummy).getX(10, 20, 12)
   };
};
