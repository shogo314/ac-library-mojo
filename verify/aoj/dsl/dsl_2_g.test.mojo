# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/problems/DSL_2_G

from collections import Optional

from atcoder.io import IO
from atcoder.lazysegtree import LazySegtree
from atcoder.py.operator import add


@value
struct WithSize[T: CollectionElement]:
    var value: T
    var size: Int

    fn __init__(out self, value: T):
        self.value = value
        self.size = 1


fn op(x: WithSize[Int], y: WithSize[Int]) -> WithSize[Int]:
    return WithSize(x.value + y.value, x.size + y.size)


fn mapping(f: Int, x: WithSize[Int]) -> WithSize[Int]:
    return WithSize(x.value + x.size * f, x.size)


fn main() raises:
    var io = IO()
    var n = io.nextInt()
    var q = io.nextInt()
    var seg = LazySegtree[WithSize[Int], Int](
        List[WithSize[Int]](WithSize(0)) * n,
        op,
        WithSize(0, 0),
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
            print(seg.prod(s - 1, t).value)
