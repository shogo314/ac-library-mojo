# verification-helper: PROBLEM https://judge.yosupo.jp/problem/predecessor_problem

from atcoder.segtree import RSumQ, min_left, max_right
from atcoder.io import IO


fn main() raises:
    fn f(x: Int) -> Bool:
        return x == 0

    var io = IO()
    var N = io.nextInt()
    var Q = io.nextInt()
    var T = io.next()
    var init = List[Int](capacity=N)
    for i in range(N):
        init.append(T[i] == "1")
    var seg = RSumQ[Int](init)
    for _ in range(Q):
        var c = io.nextInt()
        var k = io.nextInt()
        if c == 0:
            seg.set(k, 1)
        elif c == 1:
            seg.set(k, 0)
        elif c == 2:
            print(seg.get(k))
        elif c == 3:
            var tmp = max_right(seg, k, f)
            if tmp == N:
                print(-1)
            else:
                print(tmp)
        elif c == 4:
            var tmp = min_left(seg, k + 1, f)
            print(tmp - 1)
