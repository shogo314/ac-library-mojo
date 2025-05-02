# verification-helper: PROBLEM https://judge.yosupo.jp/problem/range_affine_range_sum_large_array

from bit import next_power_of_two

from atcoder.io import IO
from atcoder.lazysegtree import LazySegTree
from atcoder.modint import modint998244353
from atcoder.py.operator import add
from atcoder.ext.math.affine import Affine
from atcoder.py.bisect import bisect_left

alias mint = modint998244353


fn main() raises:
    var io = IO()
    _ = io.nextInt()
    var Q = io.nextInt()
    var query = List[(Int, Int, Int, Int, Int)](capacity=Q)
    var tmp = List[Int]()
    for _ in range(Q):
        var t0 = io.nextInt()
        var t1 = io.nextInt()
        var t2 = io.nextInt()
        tmp.append(t1)
        tmp.append(t2)
        if t0 == 0:
            var t3 = io.nextInt()
            var t4 = io.nextInt()
            query.append((t0, t1, t2, t3, t4))
        else:
            query.append((t0, t1, t2, 0, 0))

    sort(tmp)
    var v = List[Int]()
    for a in tmp:
        if len(v) == 0 or v[-1] < a[]:
            v.append(a[])
    var size = next_power_of_two(len(v))
    for _ in range(len(v), size + 1):
        v.append(v[-1])

    fn mapping(f: Affine[mint], x: mint, l: Int, r: Int) -> mint:
        return f.a * x + f.b * mint(v[r] - v[l])

    fn composite(x: Affine[mint], y: Affine[mint]) -> Affine[mint]:
        return x.assign(y)

    fn id() -> Affine[mint]:
        return Affine(mint(1), mint(0))

    var seg = LazySegTree[mint, Affine[mint]](
        size, add[mint], mint(), mapping, composite, id()
    )

    for i in range(Q):
        var q = query[i][0]
        if q == 0:
            var l = bisect_left(v, query[i][1])
            var r = bisect_left(v, query[i][2])
            var b = query[i][3]
            var c = query[i][4]
            seg.apply(l, r, Affine(mint(b), mint(c)))
        else:
            var l = bisect_left(v, query[i][1])
            var r = bisect_left(v, query[i][2])
            print(seg.prod(l, r))
