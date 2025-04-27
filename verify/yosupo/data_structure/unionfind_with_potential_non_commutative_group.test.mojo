# verification-helper: PROBLEM https://judge.yosupo.jp/problem/unionfind_with_potential_non_commutative_group

from atcoder.io import IO
from atcoder.ext.data_structure.potentialized_unionfind import PotentializedUnionFind
from atcoder.modint import modint998244353

alias mint = modint998244353


@value
struct Matrix_2x2(CollectionElement):
    var a: mint
    var b: mint
    var c: mint
    var d: mint

    fn __eq__(self, o: Self) -> Bool:
        return (
            self.a == o.a and self.b == o.b and self.c == o.c and self.d == o.d
        )

    fn write_to[W: Writer](self, mut writer: W):
        writer.write(self.a, " ", self.b, " ", self.c, " ", self.d)


fn op(x: Matrix_2x2, y: Matrix_2x2) -> Matrix_2x2:
    return Matrix_2x2(
        x.a * y.a + x.b * y.c,
        x.a * y.b + x.b * y.d,
        x.c * y.a + x.d * y.c,
        x.c * y.b + x.d * y.d,
    )


fn e() -> Matrix_2x2:
    return Matrix_2x2(
        mint(1),
        mint(0),
        mint(0),
        mint(1),
    )


fn inv(x: Matrix_2x2) -> Matrix_2x2:
    var detinv: mint
    try:
        detinv = (x.a * x.d - x.b * x.c).inv()
    except:
        detinv = mint()

    return Matrix_2x2(
        x.d * detinv,
        -x.b * detinv,
        -x.c * detinv,
        x.a * detinv,
    )


fn main() raises:
    var io = IO()
    var N = io.nextInt()
    var Q = io.nextInt()
    var uf = PotentializedUnionFind[Matrix_2x2](N, op, e(), inv)
    for _ in range(Q):
        var t = io.nextInt()
        var u = io.nextInt()
        var v = io.nextInt()
        if t == 0:
            var x00 = io.nextInt()
            var x01 = io.nextInt()
            var x10 = io.nextInt()
            var x11 = io.nextInt()
            var m = Matrix_2x2(mint(x00), mint(x01), mint(x10), mint(x11))
            if uf.same(u, v):
                if uf.diff(v, u) == m:
                    print(1)
                else:
                    print(0)
            else:
                print(1)
                _ = uf.merge(v, u, m)
        else:
            if uf.same(u, v):
                print(uf.diff(v, u))
            else:
                print(-1)
