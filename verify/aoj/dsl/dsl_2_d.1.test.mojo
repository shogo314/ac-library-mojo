# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/problems/DSL_2_D

from collections import Optional

from atcoder.io import IO
from atcoder.ext.dualsegtree import RUpdateQ


fn main() raises:
    var io = IO()
    var n = io.nextInt()
    var q = io.nextInt()
    var seg = RUpdateQ[Int32](n, Int32.MAX)
    for _ in range(q):
        var op = io.nextInt()
        if op == 0:
            var s = io.nextInt()
            var t = io.nextInt()
            var x = Int32(io.nextInt())
            seg.apply(s, t + 1, Optional(x))
        else:
            var i = io.nextInt()
            print(seg.get(i))
