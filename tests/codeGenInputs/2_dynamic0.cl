class Dummy {
  getX() : Int { 42 };
};

class Main {
   main() : Int {
     (new Dummy).getX()
   };
};
