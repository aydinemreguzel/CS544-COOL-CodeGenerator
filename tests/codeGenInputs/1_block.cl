class Main { main(): Int {
    let c : Int <- 10 in
    { c <- 10; {c <- c + 7; c; } + { c <- c + 8; c; }; }
}; };
