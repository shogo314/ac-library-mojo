# verification-helper: PROBLEM https://judge.yosupo.jp/problem/range_affine_range_sum

from atcoder.io import IO
from atcoder.lazysegtree import LazySegtree
from atcoder.modint import modint998244353

alias mint = modint998244353


@value
struct ValueWithSize:
    var value: mint
    var size: Int

    fn write_to[W: Writer](self, mut writer: W):
        writer.write("{", self.value, ",", self.size, "}")


@value
struct Affine:
    var a: mint
    var b: mint

    fn write_to[W: Writer](self, mut writer: W):
        writer.write("Affine(", self.a, ",", self.b, ")")


fn mapping(f: Affine, x: ValueWithSize) -> ValueWithSize:
    return ValueWithSize(f.a * x.value + f.b * x.size, x.size)


fn composite(x: Affine, y: Affine) -> Affine:
    return Affine(x.a * y.a, x.a * y.b + x.b)


fn id() -> Affine:
    return Affine(mint(1), mint(0))


fn op(x: ValueWithSize, y: ValueWithSize) -> ValueWithSize:
    return ValueWithSize(x.value + y.value, x.size + y.size)


fn e() -> ValueWithSize:
    return ValueWithSize(mint(), 0)


fn main() raises:
    var io = IO()
    var N = io.nextInt()
    var Q = io.nextInt()
    var init = List[ValueWithSize](capacity=N)
    for _ in range(N):
        var a = io.nextInt()
        init.append(ValueWithSize(mint(a), 1))
    var seg = LazySegtree[ValueWithSize, Affine](
        init, op, e(), mapping, composite, id()
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
            print(seg.prod(l, r).value)
