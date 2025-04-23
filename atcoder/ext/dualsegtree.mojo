from testing import assert_true
from collections import Optional

from atcoder._bit import bit_ceil, countr_zero
from atcoder.method_traits import AddMonoid
from atcoder.py.operator import add


struct DualSegtree[S: CollectionElement, F: CollectionElement]:
    var n: Int
    var size: Int
    var log: Int
    var d: List[S]
    var lz: List[F]

    var mapping: fn (F, S) -> S
    var composition: fn (F, F) -> F
    var id: F

    fn __init__(
        out self,
        n: Int,
        e: S,
        mapping: fn (F, S) -> S,
        composition: fn (F, F) -> F,
        id: F,
    ):
        self.mapping = mapping
        self.composition = composition
        self.id = id

        self.n = n
        self.size = Int(bit_ceil(n))
        self.log = countr_zero(self.size)
        self.d = List[S](e) * n
        self.lz = List[F](id) * (2 * self.size)

    fn __init__(
        out self,
        v: List[S],
        mapping: fn (F, S) -> S,
        composition: fn (F, F) -> F,
        id: F,
    ):
        self.mapping = mapping
        self.composition = composition
        self.id = id

        self.n = len(v)
        self.size = Int(bit_ceil(self.n))
        self.log = countr_zero(self.size)
        self.d = v
        self.lz = List[F](id) * (2 * self.size)

    fn set(mut self, p: Int, x: S) raises:
        assert_true(0 <= p < self.n)
        var q = p + self.size
        for i in reversed(range(1, self.log + 1)):
            self.push(q >> i)
        self.d[p] = x

    fn get(mut self, p: Int) raises -> S:
        assert_true(0 <= p < self.n)
        var q = p + self.size
        for i in reversed(range(1, self.log + 1)):
            self.push(q >> i)
        return self.d[p]

    fn apply(mut self, p: Int, f: F) raises:
        assert_true(0 <= p < self.n)
        var q = p + self.size
        for i in reversed(range(1, self.log + 1)):
            self.push(q >> i)
        self.d[p] = self.mapping(f, self.d[p])

    fn apply(mut self, l: Int, r: Int, f: F) raises:
        assert_true(0 <= l <= r <= self.n)
        if l == r:
            return
        var a = l + self.size
        var b = r + self.size
        for i in reversed(range(1, self.log + 1)):
            if ((a >> i) << i) != a:
                self.push(a >> i)
            if ((b >> i) << i) != b:
                self.push((b - 1) >> i)
        while a < b:
            if a & 1:
                self.all_apply(a, f)
                a += 1
            if b & 1:
                b -= 1
                self.all_apply(b, f)
            a >>= 1
            b >>= 1

    fn all_apply(mut self, k: Int, f: F):
        if k < self.size:
            self.lz[k] = self.composition(f, self.lz[k])
        else:
            if k - self.size < self.n:
                self.d[k - self.size] = self.mapping(f, self.d[k - self.size])

    fn push(mut self, k: Int):
        var lzk = self.lz[k]
        self.all_apply(2 * k, lzk)
        self.all_apply(2 * k + 1, lzk)
        self.lz[k] = self.id


fn RAddQ[S: AddMonoid](n: Int) -> DualSegtree[S, S]:
    return DualSegtree[S](n, S(), add[S], add[S], S())


fn RUpdateQ[S: CollectionElement](n: Int, e: S) -> DualSegtree[S, Optional[S]]:
    fn mapping(f: Optional[S], s: S) -> S:
        if f:
            return f.value()
        else:
            return s

    fn composition(f: Optional[S], g: Optional[S]) -> Optional[S]:
        if f:
            return f
        else:
            return g

    return DualSegtree[S, Optional[S]](
        n, e, mapping, composition, Optional[S]()
    )
