# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/problems/ITP2_2_A

from atcoder.io import IO


fn main() raises:
    var io = IO()
    var N = io.nextInt()
    var Q = io.nextInt()
    var stk = List[List[Int]](length=N, fill=List[Int]())
    for _ in range(Q):
        var t = io.nextInt()
        if t == 0:
            var t = io.nextInt()
            var x = io.nextInt()
            stk[t].append(x)
        elif t == 1:
            var t = io.nextInt()
            if stk[t]:
                print(stk[t][-1])
        else:
            var t = io.nextInt()
            if stk[t]:
                _ = stk[t].pop()
