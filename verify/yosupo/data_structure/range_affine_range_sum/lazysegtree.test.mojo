# verification-helper: PROBLEM https://judge.yosupo.jp/problem/range_affine_range_sum

from atcoder.io import IO
from atcoder.lazysegtree import LazySegTree
from atcoder.modint import modint998244353
from atcoder.py.operator import add
from atcoder.ext.math.affine import Affine

alias mint = modint998244353


fn mapping(f: Affine[mint], x: mint, w: Int) -> mint:
    return f.a * x + f.b * mint(w)


fn composite(x: Affine[mint], y: Affine[mint]) -> Affine[mint]:
    return x.assign(y)


fn id() -> Affine[mint]:
    return Affine(mint(1), mint(0))


fn main() raises:
    var io = IO()
    var N = io.nextInt()
    var Q = io.nextInt()
    var a = io.nextList[mint](N)
    var seg = LazySegTree[mint, Affine[mint]](
        a, add[mint], mint(), mapping, composite, id()
    )
    for _ in range(Q):
        var q = io.nextInt()
        if q == 0:
            var l = io.nextInt()
            var r = io.nextInt()
            var b = io.nextInt()
            var c = io.nextInt()
            seg.apply(l, r, Affine(mint(b), mint(c)))
        else:
            var l = io.nextInt()
            var r = io.nextInt()
            print(seg.prod(l, r))
