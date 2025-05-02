# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/problems/DSL_2_G

from collections import Optional

from atcoder.io import IO
from atcoder.lazysegtree import LazySegTree
from atcoder.py.operator import add


fn mapping(f: Int, x: Int, w: Int) -> Int:
    return x + f * w


fn main() raises:
    var io = IO()
    var n = io.nextInt()
    var q = io.nextInt()
    var seg = LazySegTree[Int, Int](
        List[Int](0) * n,
        add[Int],
        0,
        mapping,
        add[Int],
        0,
    )
    for _ in range(q):
        var op = io.nextInt()
        if op == 0:
            var s = io.nextInt()
            var t = io.nextInt()
            var x = io.nextInt()
            seg.apply(s - 1, t, x)
        else:
            var s = io.nextInt()
            var t = io.nextInt()
            print(seg.prod(s - 1, t))
