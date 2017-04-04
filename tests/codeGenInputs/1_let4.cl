class Main { main(): Int {
    let c : Int <- 5 in
    let d : Int <- c + 22 in
    let e : Int <- c + d in (* 5 + 27 = 32 *)
    let d : Int <- d - 17 in (* 27 - 17 = 10 *)
    d + e
}; };
