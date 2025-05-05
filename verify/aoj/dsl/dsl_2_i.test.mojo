# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/problems/DSL_2_I

from collections import Optional

from atcoder.io import IO
from atcoder.lazysegtree import RUpdateSumQ


fn main() raises:
    var io = IO()
    var n = io.nextInt()
    var q = io.nextInt()
    var seg = RUpdateSumQ[Int](n)
    for _ in range(q):
        var op = io.nextInt()
        if op == 0:
            var s = io.nextInt()
            var t = io.nextInt()
            var x = io.nextInt()
            seg.apply(s, t + 1, Optional(x))
        else:
            var s = io.nextInt()
            var t = io.nextInt()
            print(seg.prod(s, t + 1))
