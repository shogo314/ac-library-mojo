# verification-helper: PROBLEM https://judge.yosupo.jp/problem/point_set_range_composite


from bit import next_power_of_two, count_trailing_zeros


struct StaticSegTree[S: CollectionElement, Op: fn (S, S) -> S, E: S]:
    var n: Int
    var size: Int
    var log: Int
    var d: List[S]

    fn __init__(out self, n: Int):
        self.n = n
        self.size = next_power_of_two(self.n)
        self.log = count_trailing_zeros(self.size)
        self.d = List[S]()
        self.d.resize(2 * self.size, E)

    fn __init__(out self, v: List[S]):
        self.n = len(v)
        self.size = next_power_of_two(self.n)
        self.log = count_trailing_zeros(self.size)
        self.d = List[S]()
        self.d.resize(2 * self.size, E)
        for i in range(self.n):
            self.d[self.size + i] = v[i]
        for i in reversed(range(1, self.size)):
            self._update(i)

    fn _update(mut self, k: Int):
        self.d[k] = Op(self.d[2 * k], self.d[2 * k + 1])

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
        var sml = E
        var smr = E
        var a = l + self.size
        var b = r + self.size
        while a < b:
            if a & 1:
                sml = Op(sml, self.d[a])
                a += 1
            if b & 1:
                b -= 1
                smr = Op(self.d[b], smr)
            a >>= 1
            b >>= 1
        return Op(sml, smr)

    fn all_prod(self) -> S:
        return self.d[1]


fn max_right[
    Op: fn (Int, Int) -> Int, E: Int
](seg: StaticSegTree[Int, Op, E], l: Int, f: fn (Int) -> Bool) -> Int:
    debug_assert(0 <= l <= seg.n)
    debug_assert(f(E))
    if l == seg.n:
        return seg.n
    var l_ = l + seg.size
    var sm = E
    while True:
        while l_ % 2 == 0:
            l_ >>= 1
        if not f(Op(sm, seg.d[l_])):
            while l_ < seg.size:
                l_ *= 2
                if f(Op(sm, seg.d[l_])):
                    sm = Op(sm, seg.d[l_])
                    l_ += 1
            return l_ - seg.size
        sm = Op(sm, seg.d[l_])
        l_ += 1
        if (l_ & -l_) == l_:
            break
    return seg.n


fn max_right[
    Op: fn (Int, Int) -> Int, E: Int
](seg: StaticSegTree[Int, Op, E], l: Int, f: fn (Int) escaping -> Bool) -> Int:
    debug_assert(0 <= l <= seg.n)
    debug_assert(f(E))
    if l == seg.n:
        return seg.n
    var l_ = l + seg.size
    var sm = E
    while True:
        while l_ % 2 == 0:
            l_ >>= 1
        if not f(Op(sm, seg.d[l_])):
            while l_ < seg.size:
                l_ *= 2
                if f(Op(sm, seg.d[l_])):
                    sm = Op(sm, seg.d[l_])
                    l_ += 1
            return l_ - seg.size
        sm = Op(sm, seg.d[l_])
        l_ += 1
        if (l_ & -l_) == l_:
            break
    return seg.n


fn min_left[
    Op: fn (Int, Int) -> Int, E: Int
](seg: StaticSegTree[Int, Op, E], r: Int, f: fn (Int) -> Bool) -> Int:
    debug_assert(0 <= r <= seg.n)
    debug_assert(f(E))
    if r == 0:
        return 0
    var r_ = r + seg.size
    var sm = E
    while True:
        r_ -= 1
        while r_ > 1 and (r_ % 2):
            r_ >>= 1
        if not f(Op(seg.d[r_], sm)):
            while r_ < seg.size:
                r_ = 2 * r_ + 1
                if f(Op(seg.d[r_], sm)):
                    sm = Op(seg.d[r_], sm)
                    r_ -= 1
            return r_ + 1 - seg.size
        sm = Op(seg.d[r_], sm)
        if (r_ & -r_) == r_:
            break
    return 0


fn min_left[
    Op: fn (Int, Int) -> Int, E: Int
](seg: StaticSegTree[Int, Op, E], r: Int, f: fn (Int) escaping -> Bool) -> Int:
    debug_assert(0 <= r <= seg.n)
    debug_assert(f(E))
    if r == 0:
        return 0
    var r_ = r + seg.size
    var sm = E
    while True:
        r_ -= 1
        while r_ > 1 and (r_ % 2):
            r_ >>= 1
        if not f(Op(seg.d[r_], sm)):
            while r_ < seg.size:
                r_ = 2 * r_ + 1
                if f(Op(seg.d[r_], sm)):
                    sm = Op(seg.d[r_], sm)
                    r_ -= 1
            return r_ + 1 - seg.size
        sm = Op(seg.d[r_], sm)
        if (r_ & -r_) == r_:
            break
    return 0


from atcoder.io import IO
from atcoder.modint import modint998244353
from atcoder.ext.math.affine import Affine

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
    var seg = StaticSegTree[Affine[mint], composite, Affine(mint(1), mint(0))](
        init
    )
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
