class Main { main(): Int {
    let c : Int <- 0 in
    let i : Int <- 0 in
    { while i < 5 loop
      { let j : Int <- 0 in
        while j < 4 loop
        { if i < j then
            c <- c + 4
          else
            if i = j then
              c <- c + 2
            else
              c <- c + 1
            fi
          fi;
          j <- j + 1;
        }
        pool;
        i <- i + 1;
      }  
      pool;
      c;
    }
}; };
