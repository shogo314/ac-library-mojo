from testing import assert_true

from atcoder._bit import bit_ceil, countr_zero
from atcoder.method_traits import HasLtCollectionElement
from atcoder.py.operator import add


struct LazySegtree[S: CollectionElement, F: CollectionElement]:
    var n: Int
    var size: Int
    var log: Int
    var d: List[S]
    var lz: List[F]

    var op: fn (S, S) -> S
    var e: S
    var mapping: fn (F, S) -> S
    var composition: fn (F, F) -> F
    var id: F

    fn __init__(
        out self,
        n: Int,
        op: fn (S, S) -> S,
        e: S,
        mapping: fn (F, S) -> S,
        composition: fn (F, F) -> F,
        id: F,
    ):
        self.op = op
        self.e = e
        self.mapping = mapping
        self.composition = composition
        self.id = id

        self.n = n
        self.size = Int(bit_ceil(n))
        self.log = countr_zero(self.size)
        self.d = List[S](e) * (2 * self.size)
        self.lz = List[F](id) * (2 * self.size)

    fn __init__(
        out self,
        v: List[S],
        op: fn (S, S) -> S,
        e: S,
        mapping: fn (F, S) -> S,
        composition: fn (F, F) -> F,
        id: F,
    ):
        self.op = op
        self.e = e
        self.mapping = mapping
        self.composition = composition
        self.id = id

        self.n = len(v)
        self.size = Int(bit_ceil(self.n))
        self.log = countr_zero(self.size)
        self.d = List[S](e) * (2 * self.size)
        self.lz = List[F](id) * (2 * self.size)

        for i in range(self.n):
            self.d[self.size + i] = v[i]
        for i in reversed(range(1, self.size)):
            self.update(i)

    fn set(mut self, p: Int, x: S) raises:
        assert_true(0 <= p < self.n)
        var q = p + self.size
        for i in reversed(range(1, self.log + 1)):
            self.push(q >> i)
        self.d[q] = x
        for i in range(1, self.log + 1):
            self.update(q >> i)

    fn get(mut self, p: Int) raises -> S:
        assert_true(0 <= p < self.n)
        var q = p + self.size
        for i in reversed(range(1, self.log + 1)):
            self.push(q >> i)
        return self.d[q]

    fn prod(mut self, l: Int, r: Int) raises -> S:
        assert_true(0 <= l <= r <= self.n)
        if l == r:
            return self.e
        var a = l + self.size
        var b = r + self.size
        for i in reversed(range(1, self.log + 1)):
            if ((a >> i) << i) != a:
                self.push(a >> i)
            if ((b >> i) << i) != b:
                self.push((b - 1) >> i)
        var sml = self.e
        var smr = self.e
        while a < b:
            if a & 1:
                sml = self.op(sml, self.d[a])
                a += 1
            if b & 1:
                b -= 1
                smr = self.op(self.d[b], smr)
            a >>= 1
            b >>= 1
        return self.op(sml, smr)

    fn all_prod(self) -> S:
        return self.d[1]

    fn apply(mut self, p: Int, f: F) raises:
        assert_true(0 <= p < self.n)
        var q = p + self.size
        for i in reversed(range(1, self.log + 1)):
            self.push(q >> i)
        self.d[q] = self.mapping(f, self.d[q])
        for i in range(1, self.log + 1):
            self.update(q >> i)

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
        a = l + self.size
        b = r + self.size
        for i in range(1, self.log + 1):
            if ((a >> i) << i) != a:
                self.update(a >> i)
            if ((b >> i) << i) != b:
                self.update((b - 1) >> i)

    fn update(mut self, k: Int):
        self.d[k] = self.op(self.d[2 * k], self.d[2 * k + 1])

    fn all_apply(mut self, k: Int, f: F):
        self.d[k] = self.mapping(f, self.d[k])
        if k < self.size:
            self.lz[k] = self.composition(f, self.lz[k])

    fn push(mut self, k: Int):
        var lzk = self.lz[k]
        self.all_apply(2 * k, lzk)
        self.all_apply(2 * k + 1, lzk)
        self.lz[k] = self.id


fn RUpdateMinQ[
    S: HasLtCollectionElement
](n: Int, e: S) -> LazySegtree[S, Optional[S]]:
    fn op(x: S, y: S) -> S:
        if y < x:
            return y
        else:
            return x

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

    return LazySegtree[S, Optional[S]](
        n, op, e, mapping, composition, Optional[S]()
    )
