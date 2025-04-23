from testing import assert_true

from atcoder._bit import bit_ceil, countr_zero
from atcoder.method_traits import (
    AddMonoid,
    MulMonoid,
    HasLtCollectionElement,
)
from atcoder.py.operator import add, mul


struct Segtree[S: CollectionElement]:
    var n: Int
    var size: Int
    var log: Int
    var d: List[S]
    var op: fn (S, S) -> S
    var e: S

    fn __init__(out self, n: Int, op: fn (S, S) -> S, e: S):
        self.n = n
        self.size = Int(bit_ceil(self.n))
        self.log = countr_zero(self.size)
        self.d = List[S](e) * (2 * self.size)
        self.op = op
        self.e = e

    fn __init__(out self, v: List[S], op: fn (S, S) -> S, e: S):
        self.n = len(v)
        self.size = Int(bit_ceil(self.n))
        self.log = countr_zero(self.size)
        self.op = op
        self.e = e
        self.d = List[S](e) * (2 * self.size)
        for i in range(self.n):
            self.d[self.size + i] = v[i]
        for i in reversed(range(1, self.size)):
            self.update(i)

    fn update(mut self, k: Int) -> None:
        self.d[k] = self.op(self.d[2 * k], self.d[2 * k + 1])

    fn set(mut self, p: Int, x: S) raises -> None:
        assert_true(0 <= p < self.n)
        var q = p + self.size
        self.d[q] = x
        for i in range(1, self.log + 1):
            self.update(q >> i)

    fn get(mut self, p: Int) raises -> S:
        assert_true(0 <= p < self.n)
        return self.d[p + self.size]

    fn prod(self, l: Int, r: Int) raises -> S:
        assert_true(0 <= l and l <= r and r <= self.n)
        var sml = self.e
        var smr = self.e
        var a = l + self.size
        var b = r + self.size
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


fn max_right(
    seg: Segtree[Int], l: Int, f: fn (Int) escaping -> Bool
) raises -> Int:
    assert_true(0 <= l <= seg.n)
    assert_true(f(seg.e))
    if l == seg.n:
        return seg.n
    var l_ = l + seg.size
    var sm = seg.e
    while True:
        while l_ % 2 == 0:
            l_ >>= 1
        if not f(seg.op(sm, seg.d[l_])):
            while l_ < seg.size:
                l_ *= 2
                if f(seg.op(sm, seg.d[l_])):
                    sm = seg.op(sm, seg.d[l_])
                    l_ += 1
            return l_ - seg.size
        sm = seg.op(sm, seg.d[l_])
        l_ += 1
        if (l_ & -l_) == l_:
            break
    return seg.n


fn min_left(
    seg: Segtree[Int], r: Int, f: fn (Int) escaping -> Bool
) raises -> Int:
    assert_true(0 <= r <= seg.n)
    assert_true(f(seg.e))
    if r == 0:
        return 0
    var r_ = r + seg.size
    var sm = seg.e
    while True:
        r_ -= 1
        while r_ > 1 and (r_ % 2):
            r_ >>= 1
        if not f(seg.op(seg.d[r_], sm)):
            while r_ < seg.size:
                r_ = 2 * r_ + 1
                if f(seg.op(seg.d[r_], sm)):
                    sm = seg.op(seg.d[r_], sm)
                    r_ -= 1
            return r_ + 1 - seg.size
        sm = seg.op(seg.d[r_], sm)
        if (r_ & -r_) == r_:
            break
    return 0


fn RSumQ[S: AddMonoid](n: Int) -> Segtree[S]:
    return Segtree[S](n, add[S], S())


fn RSumQ[S: AddMonoid](v: List[S]) -> Segtree[S]:
    return Segtree[S](v, add[S], S())


fn RMulQ[S: MulMonoid](n: Int) -> Segtree[S]:
    return Segtree[S](n, mul[S], S(1))


fn RMulQ[S: MulMonoid](v: List[S]) -> Segtree[S]:
    return Segtree[S](v, mul[S], S(1))


fn RMaxQ[S: HasLtCollectionElement](n: Int, MIN: S) -> Segtree[S]:
    fn op(x: S, y: S) -> S:
        if x < y:
            return y
        else:
            return x

    return Segtree[S](n, op, MIN)


fn RMaxQ[S: HasLtCollectionElement](v: List[S], MIN: S) -> Segtree[S]:
    fn op(x: S, y: S) -> S:
        if x < y:
            return y
        else:
            return x

    return Segtree[S](v, op, MIN)


fn RMinQ[S: HasLtCollectionElement](n: Int, MAX: S) -> Segtree[S]:
    fn op(x: S, y: S) -> S:
        if y < x:
            return y
        else:
            return x

    return Segtree[S](n, op, MAX)


fn RMinQ[S: HasLtCollectionElement](v: List[S], MAX: S) -> Segtree[S]:
    fn op(x: S, y: S) -> S:
        if y < x:
            return y
        else:
            return x

    return Segtree[S](v, op, MAX)
