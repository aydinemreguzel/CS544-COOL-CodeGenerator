class Dummy {
  dummy(): Int { 10 };
};

class Child inherits Dummy {
  child(x:Int, y:Bool, z:String): Int { 20 };
};

class GrandChild inherits Child {
  shushu(): Int { 35 };
  dummy(): Int { 30 };
};
class Main inherits IO {
  main(): Int { 42 };
};