-- Simple assignment

class Dummy {
  x : Int <- 42;
  getX() : Int { x };
  getY() : Int { 42 };
};

class Child inherits Dummy {
  getY() : Int { 333 };
  getZ() : Int { 999 };
};

class Main inherits IO
{
   d : Dummy;
   main() : Int {{
     new Child;
     42;
   }};
};
