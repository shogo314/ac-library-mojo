# verification-helper: PROBLEM https://judge.yosupo.jp/problem/point_add_range_sum

from atcoder.io import IO
from atcoder.segtree import RSumQ


fn main() raises:
    var io = IO()
    var N = io.nextInt()
    var Q = io.nextInt()
    var a = io.nextListInt(N)
    var seg = RSumQ[Int](a)
    for _ in range(Q):
        var t = io.nextInt()
        if t == 0:
            var p = io.nextInt()
            var x = io.nextInt()
            seg.set(p, seg.get(p) + x)
        else:
            var l = io.nextInt()
            var r = io.nextInt()
            print(seg.prod(l, r))
