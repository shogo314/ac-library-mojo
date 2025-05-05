# verification-helper: PROBLEM https://judge.yosupo.jp/problem/point_add_range_sum

from atcoder.io import IO
from atcoder.lazysegtree import RAddSumQ


fn main() raises:
    var io = IO()
    var N = io.nextInt()
    var Q = io.nextInt()
    var a = io.nextListInt(N)
    var seg = RAddSumQ[Int](a)
    for _ in range(Q):
        var t = io.nextInt()
        if t == 0:
            var p = io.nextInt()
            var x = io.nextInt()
            seg.apply(p, x)
        else:
            var l = io.nextInt()
            var r = io.nextInt()
            print(seg.prod(l, r))
