# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/problems/ITP2_1_A

from atcoder.io import IO


fn main() raises:
    var io = IO()
    var Q = io.nextInt()
    var l = List[Int]()
    for _ in range(Q):
        var t = io.nextInt()
        if t == 0:
            var x = io.nextInt()
            l.append(x)
        elif t == 1:
            var p = io.nextInt()
            print(l[p])
        else:
            _ = l.pop()
