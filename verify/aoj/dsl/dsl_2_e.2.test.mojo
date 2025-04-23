# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/problems/DSL_2_E

from atcoder.io import IO
from atcoder.ext.dualsegtree import DualSegtree
from atcoder.py.operator import add


fn main() raises:
    var io = IO()
    var n = io.nextInt()
    var q = io.nextInt()
    var seg = DualSegtree[Int, Int](n, 0, add[Int], add[Int], 0)
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
