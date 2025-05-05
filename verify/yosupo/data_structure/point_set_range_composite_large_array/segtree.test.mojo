# verification-helper: PROBLEM https://judge.yosupo.jp/problem/point_set_range_composite_large_array

from atcoder.io import IO
from atcoder.segtree import SegTree
from atcoder.modint import modint998244353
from atcoder.ext.math.affine import Affine
from atcoder.py.bisect import bisect_left

alias mint = modint998244353


fn composite(x: Affine[mint], y: Affine[mint]) -> Affine[mint]:
    return y.assign(x)


fn main() raises:
    var io = IO()
    _ = io.nextInt()
    var Q = io.nextInt()
    var query = List[(Int, Int, Int, Int)](capacity=Q)
    var tmp = List[Int]()
    for _ in range(Q):
        var t0 = io.nextInt()
        var t1 = io.nextInt()
        var t2 = io.nextInt()
        var t3 = io.nextInt()
        query.append((t0, t1, t2, t3))
        if t0 == 0:
            tmp.append(t1)
    sort(tmp)
    var v = List[Int](0)
    for a in tmp:
        if v[-1] < a[]:
            v.append(a[])
    var seg = SegTree[Affine[mint]](len(v), composite, Affine[mint]())
    for i in range(Q):
        var q = query[i][0]
        if q == 0:
            var p = bisect_left(v, query[i][1])
            var c = mint(query[i][2])
            var d = mint(query[i][3])
            seg.set(p, Affine(c, d))
        else:
            var l = bisect_left(v, query[i][1])
            var r = bisect_left(v, query[i][2])
            var x = mint(query[i][3])
            print(seg.prod(l, r).assign(x))
