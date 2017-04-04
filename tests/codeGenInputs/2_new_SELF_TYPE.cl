class Parent {
  get(): SELF_TYPE { new SELF_TYPE };
};

class OK inherits Parent { };

class Main inherits IO {
  main(): Int {{
    out_string((new OK).get().type_name().concat("\n"));
    42;
  }};
};