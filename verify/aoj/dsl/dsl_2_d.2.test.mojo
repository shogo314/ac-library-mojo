# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/problems/DSL_2_D

from atcoder.io import IO
from atcoder.ext.data_structure.dualsegtree import DualSegTree


fn e() -> Int:
    return 2**31 - 1


fn mapping(f: Int, s: Int) -> Int:
    if f == -1:
        return s
    else:
        return f


fn composition(f: Int, g: Int) -> Int:
    if f == -1:
        return g
    else:
        return f


fn id() -> Int:
    return -1


fn main() raises:
    var io = IO()
    var n = io.nextInt()
    var q = io.nextInt()
    var seg = DualSegTree[Int, Int](n, e(), mapping, composition, id())
    for _ in range(q):
        var op = io.nextInt()
        if op == 0:
            var s = io.nextInt()
            var t = io.nextInt()
            var x = io.nextInt()
            seg.apply(s, t + 1, x)
        else:
            var i = io.nextInt()
            print(seg.get(i))
