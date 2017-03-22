class Main { main(): Int {
    let c : Int <- 10 in
    let d : Int <- 5 in
    { d <- c <- c + 11; c + d; }
}; };
