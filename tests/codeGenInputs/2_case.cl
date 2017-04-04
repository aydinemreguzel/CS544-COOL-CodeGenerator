class Parent {                         -- 5
  get(): Int { 66 };
};

class Sister inherits Parent {         -- 6
};

class Child inherits Parent {          -- 7
  get(): Int { 77 };
};

class GrandSibling inherits Child {    -- 8
};

class GrandChild inherits Child {      -- 9
  get(): Int { 88 };
};

class GrandGrandChild inherits GrandChild { -- 10
  get(): Int { 42 };
};

class GrandSibling2 inherits Child {   -- 11
  get(): Int { 111 };
};

class Brother inherits Parent {        -- 12
};

class Main inherits IO {
   main(): Int {
     case (new GrandGrandChild) of
       i : Int =>      { out_string("FAIL Int\n"); 55; };
       p : Parent =>   { out_string("FAIL Parent\n"); p.get(); };
       obj : Object => { out_string("FAIL Object\n"); 99; };
       c : Child =>    { out_string("OK\n"); c.get(); };
       g : GrandSibling2 => { out_string("FAIL GrandSibling2\n"); g.get(); };
       b : Brother => { out_string("FAIL Brother\n"); b.get(); };
     esac
   };
};
