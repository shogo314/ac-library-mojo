# verification-helper: PROBLEM https://judge.yosupo.jp/problem/two_sat

from atcoder.io import IO
from atcoder.twosat import TwoSat


fn main() raises:
    var io = IO()
    _ = io.next()
    _ = io.next()
    var N = io.nextInt()
    var M = io.nextInt()
    var sat = TwoSat(N)
    for _ in range(M):
        var a = io.nextInt()
        var b = io.nextInt()
        _ = io.next()
        sat.add_clause(abs(a) - 1, a >= 0, abs(b) - 1, b >= 0)
    if sat.satisfiable():
        print("s", "SATISFIABLE")
        var ans = sat.answer()
        print("v", end=" ")
        for i in range(N):
            if ans[i]:
                print(i + 1, end=" ")
            else:
                print(-(i + 1), end=" ")
        print(0)
    else:
        print("s", "UNSATISFIABLE")
