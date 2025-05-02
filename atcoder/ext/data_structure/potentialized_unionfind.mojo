from atcoder.method_traits import (
    MulGroup,
    AddGroup,
)
from atcoder.py.operator import add, neg, mul, inv


struct PotentializedUnionFind[S: CollectionElement]:
    var n: Int
    var parent_or_size: List[Int]
    var diff_weight: List[S]
    var op: fn (S, S) -> S
    var e: S
    var inv: fn (S) -> S

    fn __init__(out self, n: Int, op: fn (S, S) -> S, e: S, inv: fn (S) -> S):
        self.n = n
        self.parent_or_size = List[Int](capacity=n)
        self.parent_or_size.resize(n, -1)
        self.diff_weight = List[S](capacity=n)
        self.diff_weight.resize(n, e)
        self.op = op
        self.e = e
        self.inv = inv

    fn leader(mut self, a: Int) -> Int:
        debug_assert(0 <= a < self.n)
        if self.parent_or_size[a] < 0:
            return a
        var root = self.leader(self.parent_or_size[a])
        self.diff_weight[a] = self.op(
            self.diff_weight[self.parent_or_size[a]], self.diff_weight[a]
        )
        self.parent_or_size[a] = root
        return root

    fn merge(mut self, a: Int, b: Int, w: S) -> Int:
        debug_assert(0 <= a and a < self.n)
        debug_assert(0 <= b and b < self.n)
        var v = self.op(self.op(self.weight(a), w), self.inv(self.weight(b)))
        var x = self.leader(a)
        var y = self.leader(b)
        if x == y:
            return x
        if -self.parent_or_size[x] < -self.parent_or_size[y]:
            x, y = y, x
            v = self.inv(v)
        self.parent_or_size[x] += self.parent_or_size[y]
        self.parent_or_size[y] = x
        self.diff_weight[y] = v
        return x

    fn same(mut self, a: Int, b: Int) -> Bool:
        debug_assert(0 <= a and a < self.n)
        debug_assert(0 <= b and b < self.n)
        return self.leader(a) == self.leader(b)

    fn diff(mut self, a: Int, b: Int) -> S:
        debug_assert(0 <= a and a < self.n)
        debug_assert(0 <= b and b < self.n)
        return self.op(self.inv(self.weight(a)), self.weight(b))

    fn size(mut self, a: Int) -> Int:
        debug_assert(0 <= a and a < self.n)
        return -self.parent_or_size[self.leader(a)]

    fn weight(mut self, a: Int) -> S:
        debug_assert(0 <= a and a < self.n)
        _ = self.leader(a)
        return self.diff_weight[a]


fn UnionFindPlus[S: AddGroup](n: Int) -> PotentializedUnionFind[S]:
    return PotentializedUnionFind[S](n, add[S], S(), neg[S])


fn UnionFindMul[S: MulGroup](n: Int) -> PotentializedUnionFind[S]:
    return PotentializedUnionFind[S](n, mul[S], S(1), inv[S])
