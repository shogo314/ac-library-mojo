# verification-helper: PROBLEM https://judge.yosupo.jp/problem/range_set_range_composite

from collections import Optional

from atcoder.io import IO
from atcoder.lazysegtree import LazySegTree
from atcoder.modint import modint998244353
from atcoder.ext.affine import Affine

alias mint = modint998244353


@value
struct WithSize[T: CollectionElement](CollectionElement):
    var value: T
    var size: Int

    fn __init__(out self, value: T):
        self.value = value
        self.size = 1

alias S = WithSize[Affine[mint]]
alias F = Optional[Affine[mint]]

fn mapping(f: F, x: S) -> S:
    if f:
        try:
            var fv = f.value()
            var pw = fv.a.pow(x.size)
            return S(
                Affine(pw, (pw - 1) / (fv.a - 1) * fv.b), x.size
            )
        except:
            return S(Affine(mint(1), mint(0)), 0)
    else:
        return x


fn composite(x: F, y: F) -> F:
    if x:
        return x
    else:
        return y


fn id() -> F:
    return F()


fn op(x: S, y: S) -> S:
    return S(y.value.assign(x.value), x.size + y.size)


fn e() -> S:
    return S(Affine(mint(1), mint(0)), 0)


fn main() raises:
    var io = IO()
    var N = io.nextInt()
    var Q = io.nextInt()
    var init = List[S](capacity=N)
    for _ in range(N):
        var a = io.nextInt()
        var b = io.nextInt()
        init.append(S(Affine(mint(a), mint(b))))
    var seg = LazySegTree[S, F](
        init, op, e(), mapping, composite, id()
    )
    for _ in range(Q):
        var q = io.nextInt()
        if q == 0:
            var l = io.nextInt()
            var r = io.nextInt()
            var c = io.nextInt()
            var d = io.nextInt()
            seg.apply(l, r, F(Affine(mint(c), mint(d))))
        else:
            var l = io.nextInt()
            var r = io.nextInt()
            var x = io.nextInt()
            print(seg.prod(l, r).value.assign(mint(x)))
