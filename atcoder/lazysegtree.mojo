from bit import next_power_of_two, log2_floor

from atcoder.method_traits import (
    AddMonoid,
    SemiRing,
)
from atcoder.py.operator import add, min_, max_


struct LazySegTree[S: Copyable & Movable, F: Copyable & Movable]:
    var n: Int
    var size: Int
    var log: Int
    var d: List[S]
    var lz: List[F]

    var op: fn (S, S) -> S
    var e: S
    var mapping: fn (F, S, Int, Int) escaping -> S
    var composition: fn (F, F) -> F
    var id: F

    @staticmethod
    fn _mapping(mapping: fn (F, S) -> S) -> fn (F, S, Int, Int) escaping -> S:
        fn mapping_with_size(f: F, s: S, l: Int, r: Int) -> S:
            return mapping(f, s)

        return mapping_with_size

    @staticmethod
    fn _mapping(
        mapping: fn (F, S, Int) -> S
    ) -> fn (F, S, Int, Int) escaping -> S:
        fn mapping_with_size(f: F, s: S, l: Int, r: Int) -> S:
            return mapping(f, s, r - l)

        return mapping_with_size

    @staticmethod
    fn _mapping(
        mapping: fn (F, S, Int, Int) -> S
    ) -> fn (F, S, Int, Int) escaping -> S:
        fn mapping_with_size(f: F, s: S, l: Int, r: Int) -> S:
            return mapping(f, s, l, r)

        return mapping_with_size

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
        self.mapping = Self._mapping(mapping)
        self.composition = composition
        self.id = id

        self.n = n
        self.size = next_power_of_two(self.n)
        self.log = log2_floor(self.size)
        self.d = List(length=self.size << 1, fill=e)
        self.lz = List(length=self.size << 1, fill=id)

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
        self.mapping = Self._mapping(mapping)
        self.composition = composition
        self.id = id

        self.n = len(v)
        self.size = next_power_of_two(self.n)
        self.log = log2_floor(self.size)
        self.d = List(length=self.size << 1, fill=e)
        self.lz = List(length=self.size << 1, fill=id)

        for i in range(self.n):
            self.d[self.size + i] = v[i]
        for i in reversed(range(1, self.size)):
            self._update(i)

    fn __init__(
        out self,
        n: Int,
        op: fn (S, S) -> S,
        e: S,
        mapping: fn (F, S, Int) -> S,
        composition: fn (F, F) -> F,
        id: F,
    ):
        self.op = op
        self.e = e
        self.mapping = Self._mapping(mapping)
        self.composition = composition
        self.id = id

        self.n = n
        self.size = next_power_of_two(self.n)
        self.log = log2_floor(self.size)
        self.d = List(length=self.size << 1, fill=e)
        self.lz = List(length=self.size << 1, fill=id)

    fn __init__(
        out self,
        v: List[S],
        op: fn (S, S) -> S,
        e: S,
        mapping: fn (F, S, Int) -> S,
        composition: fn (F, F) -> F,
        id: F,
    ):
        self.op = op
        self.e = e
        self.mapping = Self._mapping(mapping)
        self.composition = composition
        self.id = id

        self.n = len(v)
        self.size = next_power_of_two(self.n)
        self.log = log2_floor(self.size)
        self.d = List(length=self.size << 1, fill=e)
        self.lz = List(length=self.size << 1, fill=id)

        for i in range(self.n):
            self.d[self.size + i] = v[i]
        for i in reversed(range(1, self.size)):
            self._update(i)

    fn __init__(
        out self,
        n: Int,
        op: fn (S, S) -> S,
        e: S,
        mapping: fn (F, S, Int, Int) -> S,
        composition: fn (F, F) -> F,
        id: F,
    ):
        self.op = op
        self.e = e
        self.mapping = Self._mapping(mapping)
        self.composition = composition
        self.id = id

        self.n = n
        self.size = next_power_of_two(self.n)
        self.log = log2_floor(self.size)
        self.d = List(length=self.size << 1, fill=e)
        self.lz = List(length=self.size << 1, fill=id)

    fn __init__(
        out self,
        v: List[S],
        op: fn (S, S) -> S,
        e: S,
        mapping: fn (F, S, Int, Int) -> S,
        composition: fn (F, F) -> F,
        id: F,
    ):
        self.op = op
        self.e = e
        self.mapping = Self._mapping(mapping)
        self.composition = composition
        self.id = id

        self.n = len(v)
        self.size = next_power_of_two(self.n)
        self.log = log2_floor(self.size)
        self.d = List(length=self.size << 1, fill=e)
        self.lz = List(length=self.size << 1, fill=id)

        for i in range(self.n):
            self.d[self.size + i] = v[i]
        for i in reversed(range(1, self.size)):
            self._update(i)

    fn __init__(
        out self,
        n: Int,
        op: fn (S, S) -> S,
        e: S,
        mapping: fn (F, S, Int, Int) escaping -> S,
        composition: fn (F, F) -> F,
        id: F,
    ):
        self.op = op
        self.e = e
        self.mapping = mapping
        self.composition = composition
        self.id = id

        self.n = n
        self.size = next_power_of_two(self.n)
        self.log = log2_floor(self.size)
        self.d = List(length=self.size << 1, fill=e)
        self.lz = List(length=self.size << 1, fill=id)

    fn __init__(
        out self,
        v: List[S],
        op: fn (S, S) -> S,
        e: S,
        mapping: fn (F, S, Int, Int) escaping -> S,
        composition: fn (F, F) -> F,
        id: F,
    ):
        self.op = op
        self.e = e
        self.mapping = mapping
        self.composition = composition
        self.id = id

        self.n = len(v)
        self.size = next_power_of_two(self.n)
        self.log = log2_floor(self.size)
        self.d = List(length=self.size << 1, fill=e)
        self.lz = List(length=self.size << 1, fill=id)

        for i in range(self.n):
            self.d[self.size + i] = v[i]
        for i in reversed(range(1, self.size)):
            self._update(i)

    fn set(mut self, p: Int, x: S):
        debug_assert(0 <= p < self.n)
        var q = p + self.size
        for i in reversed(range(1, self.log + 1)):
            self._push(q >> i)
        self.d[q] = x
        for i in range(1, self.log + 1):
            self._update(q >> i)

    fn __setitem__(mut self, idx: Int, x: S):
        self.set(idx, x)

    fn get(mut self, p: Int) -> S:
        debug_assert(0 <= p < self.n)
        var q = p + self.size
        for i in reversed(range(1, self.log + 1)):
            self._push(q >> i)
        return self.d[q]

    fn __getitem__(mut self, idx: Int) -> S:
        return self.get(idx)

    fn prod(mut self, l: Int, r: Int) -> S:
        debug_assert(0 <= l <= r <= self.n)
        if l == r:
            return self.e
        var a = l + self.size
        var b = r + self.size
        for i in reversed(range(1, self.log + 1)):
            if ((a >> i) << i) != a:
                self._push(a >> i)
            if ((b >> i) << i) != b:
                self._push((b - 1) >> i)
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

    fn apply(mut self, p: Int, f: F):
        debug_assert(0 <= p < self.n)
        var q = p + self.size
        for i in reversed(range(1, self.log + 1)):
            self._push(q >> i)
        self.d[q] = self.mapping(f, self.d[q], p, p + 1)
        for i in range(1, self.log + 1):
            self._update(q >> i)

    fn apply(mut self, l: Int, r: Int, f: F):
        debug_assert(0 <= l <= r <= self.n)
        if l == r:
            return
        var a = l + self.size
        var b = r + self.size
        for i in reversed(range(1, self.log + 1)):
            if ((a >> i) << i) != a:
                self._push(a >> i)
            if ((b >> i) << i) != b:
                self._push((b - 1) >> i)
        while a < b:
            if a & 1:
                self._all_apply(a, f)
                a += 1
            if b & 1:
                b -= 1
                self._all_apply(b, f)
            a >>= 1
            b >>= 1
        a = l + self.size
        b = r + self.size
        for i in range(1, self.log + 1):
            if ((a >> i) << i) != a:
                self._update(a >> i)
            if ((b >> i) << i) != b:
                self._update((b - 1) >> i)

    fn _update(mut self, k: Int):
        self.d[k] = self.op(self.d[2 * k], self.d[2 * k + 1])

    fn _all_apply(mut self, k: Int, f: F):
        var lfk = log2_floor(k)
        var l = (k - (1 << lfk)) << (self.log - lfk)
        self.d[k] = self.mapping(f, self.d[k], l, l + (self.size >> lfk))
        if k < self.size:
            self.lz[k] = self.composition(f, self.lz[k])

    fn _push(mut self, k: Int):
        var lzk = self.lz[k]
        self._all_apply(2 * k, lzk)
        self._all_apply(2 * k + 1, lzk)
        self.lz[k] = self.id

    fn max_right[F: fn (S) -> Bool](mut self, l: Int) -> Int:
        debug_assert(0 <= l <= self.n)
        debug_assert(F(self.e))
        if l == self.n:
            return self.n
        var l_ = l + self.size
        for i in reversed(range(1, self.log + 1)):
            self._push(l_ >> i)
        var sm = self.e
        while True:
            while l_ % 2 == 0:
                l_ >>= 1
            if not F(self.op(sm, self.d[l_])):
                while l_ < self.size:
                    self._push(l_)
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

    fn min_left[F: fn (S) -> Bool](mut self, r: Int) -> Int:
        debug_assert(0 <= r <= self.n)
        debug_assert(F(self.e))
        if r == 0:
            return 0
        var r_ = r + self.size
        for i in reversed(range(1, self.log + 1)):
            self._push((r - 1) >> i)
        var sm = self.e
        while True:
            r_ -= 1
            while r_ > 1 and (r_ % 2):
                r_ >>= 1
            if not F(self.op(self.d[r_], sm)):
                while r_ < self.size:
                    self._push(r_)
                    r_ = 2 * r_ + 1
                    if F(self.op(self.d[r_], sm)):
                        sm = self.op(self.d[r_], sm)
                        r_ -= 1
                return r_ + 1 - self.size
            sm = self.op(self.d[r_], sm)
            if (r_ & -r_) == r_:
                break
        return 0


fn _update_mapping[S: Copyable & Movable](f: Optional[S], s: S) -> S:
    if f:
        return f.value()
    else:
        return s


fn _update_composition[
    S: Copyable & Movable
](f: Optional[S], g: Optional[S]) -> Optional[S]:
    if f:
        return f
    else:
        return g


fn RUpdateMinQ[
    S: LessThanComparable & Copyable & Movable
](n: Int, MAX: S) -> LazySegTree[S, Optional[S]]:
    return LazySegTree[S, Optional[S]](
        n,
        min_[S],
        MAX,
        _update_mapping[S],
        _update_composition[S],
        Optional[S](),
    )


fn RUpdateMinQ[
    S: LessThanComparable & Copyable & Movable
](v: List[S], MAX: S) -> LazySegTree[S, Optional[S]]:
    return LazySegTree[S, Optional[S]](
        v,
        min_[S],
        MAX,
        _update_mapping[S],
        _update_composition[S],
        Optional[S](),
    )


fn RUpdateMaxQ[
    S: LessThanComparable & Copyable & Movable
](n: Int, MIN: S) -> LazySegTree[S, Optional[S]]:
    return LazySegTree[S, Optional[S]](
        n,
        max_[S],
        MIN,
        _update_mapping[S],
        _update_composition[S],
        Optional[S](),
    )


fn RUpdateMaxQ[
    S: LessThanComparable & Copyable & Movable
](v: List[S], MIN: S) -> LazySegTree[S, Optional[S]]:
    return LazySegTree[S, Optional[S]](
        v,
        max_[S],
        MIN,
        _update_mapping[S],
        _update_composition[S],
        Optional[S](),
    )


fn RAddMinQ[
    S: AddMonoid & LessThanComparable & Copyable & Movable
](n: Int, MAX: S) -> LazySegTree[S, S]:
    return LazySegTree[S, S](n, min_[S], MAX, add[S], add[S], S())


fn RAddMinQ[
    S: AddMonoid & LessThanComparable & Copyable & Movable
](v: List[S], MAX: S) -> LazySegTree[S, S]:
    return LazySegTree[S, S](v, min_[S], MAX, add[S], add[S], S())


fn RAddMaxQ[
    S: AddMonoid & LessThanComparable & Copyable & Movable
](n: Int, MIN: S) -> LazySegTree[S, S]:
    return LazySegTree[S, S](n, max_[S], MIN, add[S], add[S], S())


fn RAddMaxQ[
    S: AddMonoid & LessThanComparable & Copyable & Movable
](v: List[S], MIN: S) -> LazySegTree[S, S]:
    return LazySegTree[S, S](v, max_[S], MIN, add[S], add[S], S())


fn RAddSumQ[S: SemiRing](n: Int) -> LazySegTree[S, S]:
    fn mapping(f: S, x: S, w: Int) -> S:
        return x + f * S(w)

    return LazySegTree[S, S](
        n,
        add[S],
        S(),
        mapping,
        add[S],
        S(),
    )


fn RAddSumQ[S: SemiRing](v: List[S]) -> LazySegTree[S, S]:
    fn mapping(f: S, x: S, w: Int) -> S:
        return x + f * S(w)

    return LazySegTree[S, S](
        v,
        add[S],
        S(),
        mapping,
        add[S],
        S(),
    )


fn RUpdateSumQ[S: SemiRing](n: Int) -> LazySegTree[S, Optional[S]]:
    fn mapping(f: Optional[S], x: S, w: Int) -> S:
        if f:
            return f.value() * S(w)
        else:
            return x

    return LazySegTree[S, Optional[S]](
        n,
        add[S],
        S(),
        mapping,
        _update_composition[S],
        Optional[S](),
    )


fn RUpdateSumQ[S: SemiRing](v: List[S]) -> LazySegTree[S, Optional[S]]:
    fn mapping(f: Optional[S], x: S, w: Int) -> S:
        if f:
            return f.value() * S(w)
        else:
            return x

    return LazySegTree[S, Optional[S]](
        v,
        add[S],
        S(),
        mapping,
        _update_composition[S],
        Optional[S](),
    )
