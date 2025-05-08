# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/problems/DSL_2_H

from collections import Optional

from atcoder.io import IO
from atcoder.lazysegtree import RAddMinQ


fn main() raises:
    var io = IO()
    var n = io.nextInt()
    var q = io.nextInt()
    var seg = RAddMinQ[Int](List(length=n, fill=0), Int.MAX)
    for _ in range(q):
        var op = io.nextInt()
        if op == 0:
            var s = io.nextInt()
            var t = io.nextInt()
            var x = io.nextInt()
            seg.apply(s, t + 1, x)
        else:
            var s = io.nextInt()
            var t = io.nextInt()
            print(seg.prod(s, t + 1))
