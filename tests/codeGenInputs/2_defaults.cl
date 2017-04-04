class Dummy { };

class Main {
  flag: Bool;
  name: String;
  number: Int;
  val: Dummy;
  
  main(): Int { if flag then number else 42 fi };
};
