# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/problems/ITP2_1_D

from atcoder.io import IO


fn main() raises:
    var io = IO()
    var N = io.nextInt()
    var Q = io.nextInt()
    var vec = List[List[Int]](length=N, fill=List[Int]())
    for _ in range(Q):
        var t = io.nextInt()
        if t == 0:
            var t = io.nextInt()
            var x = io.nextInt()
            vec[t].append(x)
        elif t == 1:
            var t = io.nextInt()
            IO.print(vec[t])
        else:
            var t = io.nextInt()
            vec[t].clear()
