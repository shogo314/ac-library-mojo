# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/problems/DSL_2_E

from atcoder.io import IO
from atcoder.ext.dualsegtree import RAddQ


fn main() raises:
    var io = IO()
    var n = io.nextInt()
    var q = io.nextInt()
    var seg = RAddQ[Int](n)
    for _ in range(q):
        var op = io.nextInt()
        if op == 0:
            var s = io.nextInt()
            var t = io.nextInt()
            var x = io.nextInt()
            seg.apply(s - 1, t, x)
        else:
            var i = io.nextInt()
            print(seg.get(i - 1))
