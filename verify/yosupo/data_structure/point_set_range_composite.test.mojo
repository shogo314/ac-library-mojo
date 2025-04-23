# verification-helper: PROBLEM https://judge.yosupo.jp/problem/point_set_range_composite

from atcoder.io import IO
from atcoder.segtree import Segtree
from atcoder.modint import modint998244353
from atcoder.ext.affine import Affine

alias mint = modint998244353


fn composite(x: Affine[mint], y: Affine[mint]) -> Affine[mint]:
    return y.assign(x)


fn main() raises:
    var io = IO()
    var N = io.nextInt()
    var Q = io.nextInt()
    var init = List[Affine[mint]](capacity=N)
    for _ in range(N):
        var a = io.nextInt()
        var b = io.nextInt()
        init.append(Affine(mint(a), mint(b)))
    var seg = Segtree[Affine[mint]](init, composite, Affine(mint(1), mint(0)))
    for _ in range(Q):
        var q = io.nextInt()
        if q == 0:
            var p = io.nextInt()
            var c = io.nextInt()
            var d = io.nextInt()
            seg.set(p, Affine(mint(c), mint(d)))
        else:
            var l = io.nextInt()
            var r = io.nextInt()
            var x = io.nextInt()
            print(seg.prod(l, r).assign(mint(x)))
