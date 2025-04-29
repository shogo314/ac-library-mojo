from bit import log2_floor, count_trailing_zeros

from atcoder.method_traits import (
    AddMonoid,
    MulMonoid,
    HasLtCollectionElement,
)
from atcoder.py.operator import add, mul


struct SegTree[S: CollectionElement]:
    var n: Int
    var size: Int
    var log: Int
    var d: List[S]
    var op: fn (S, S) -> S
    var e: S

    fn __init__(out self, n: Int, op: fn (S, S) -> S, e: S):
        self.n = n
        self.size = 1 << (log2_floor(self.n - 1) + 1)
        self.log = count_trailing_zeros(self.size)
        self.d = List[S]()
        self.d.resize(2 * self.size, e)
        self.op = op
        self.e = e

    fn __init__(out self, v: List[S], op: fn (S, S) -> S, e: S):
        self.n = len(v)
        self.size = 1 << (log2_floor(self.n - 1) + 1)
        self.log = count_trailing_zeros(self.size)
        self.op = op
        self.e = e
        self.d = List[S]()
        self.d.resize(2 * self.size, e)
        for i in range(self.n):
            self.d[self.size + i] = v[i]
        for i in reversed(range(1, self.size)):
            self._update(i)

    fn _update(mut self, k: Int):
        self.d[k] = self.op(self.d[2 * k], self.d[2 * k + 1])

    fn set(mut self, p: Int, x: S):
        debug_assert(0 <= p < self.n)
        var q = p + self.size
        self.d[q] = x
        for i in range(1, self.log + 1):
            self._update(q >> i)

    fn get(mut self, p: Int) -> S:
        debug_assert(0 <= p < self.n)
        return self.d[p + self.size]

    fn prod(self, l: Int, r: Int) -> S:
        debug_assert(0 <= l and l <= r and r <= self.n)
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

    fn max_right[F: fn (S) -> Bool](self, l: Int) -> Int:
        debug_assert(0 <= l <= self.n)
        debug_assert(F(self.e))
        if l == self.n:
            return self.n
        var l_ = l + self.size
        var sm = self.e
        while True:
            while l_ % 2 == 0:
                l_ >>= 1
            if not F(self.op(sm, self.d[l_])):
                while l_ < self.size:
                    l_ *= 2
                    if F(self.op(sm, self.d[l_])):
                        sm = self.op(sm, self.d[l_])
                        l_ += 1
                return l_ - self.size
            sm = self.op(sm, self.d[l_])
            l_ += 1
            if (l_ & -l_) == l_:
                break
        return self.n

    fn min_left[F: fn (S) -> Bool](self, r: Int) -> Int:
        debug_assert(0 <= r <= self.n)
        debug_assert(F(self.e))
        if r == 0:
            return 0
        var r_ = r + self.size
        var sm = self.e
        while True:
            r_ -= 1
            while r_ > 1 and (r_ % 2):
                r_ >>= 1
            if not F(self.op(self.d[r_], sm)):
                while r_ < self.size:
                    r_ = 2 * r_ + 1
                    if F(self.op(self.d[r_], sm)):
                        sm = self.op(self.d[r_], sm)
                        r_ -= 1
                return r_ + 1 - self.size
            sm = self.op(self.d[r_], sm)
            if (r_ & -r_) == r_:
                break
        return 0


fn max_right(seg: SegTree[Int], l: Int, f: fn (Int) escaping -> Bool) -> Int:
    debug_assert(0 <= l <= seg.n)
    debug_assert(f(seg.e))
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


fn min_left(seg: SegTree[Int], r: Int, f: fn (Int) escaping -> Bool) -> Int:
    debug_assert(0 <= r <= seg.n)
    debug_assert(f(seg.e))
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


fn RSumQ[S: AddMonoid](n: Int) -> SegTree[S]:
    return SegTree[S](n, add[S], S())


fn RSumQ[S: AddMonoid](v: List[S]) -> SegTree[S]:
    return SegTree[S](v, add[S], S())


fn RMulQ[S: MulMonoid](n: Int) -> SegTree[S]:
    return SegTree[S](n, mul[S], S(1))


fn RMulQ[S: MulMonoid](v: List[S]) -> SegTree[S]:
    return SegTree[S](v, mul[S], S(1))


fn RMaxQ[S: HasLtCollectionElement](n: Int, MIN: S) -> SegTree[S]:
    fn op(x: S, y: S) -> S:
        if x < y:
            return y
        else:
            return x

    return SegTree[S](n, op, MIN)


fn RMaxQ[S: HasLtCollectionElement](v: List[S], MIN: S) -> SegTree[S]:
    fn op(x: S, y: S) -> S:
        if x < y:
            return y
        else:
            return x

    return SegTree[S](v, op, MIN)


fn RMinQ[S: HasLtCollectionElement](n: Int, MAX: S) -> SegTree[S]:
    fn op(x: S, y: S) -> S:
        if y < x:
            return y
        else:
            return x

    return SegTree[S](n, op, MAX)


fn RMinQ[S: HasLtCollectionElement](v: List[S], MAX: S) -> SegTree[S]:
    fn op(x: S, y: S) -> S:
        if y < x:
            return y
        else:
            return x

    return SegTree[S](v, op, MAX)
