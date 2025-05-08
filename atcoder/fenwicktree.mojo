from atcoder.method_traits import AddGroup


@value
struct FenwickTree[T: AddGroup]:
    var _n: Int
    var _data: List[T]

    fn __init__(out self, n: Int):
        self._n = n
        self._data = List(length=n, fill=T())

    fn __init__(out self, v: List[T]):
        self._n = len(v)
        self._data = v
        for i in range(self._n):
            var j = i | (i + 1)
            if j < self._n:
                self._data[j] = self._data[j] + self._data[i]

    fn add(mut self, p: Int, x: T):
        debug_assert(0 <= p < self._n)
        var q = p + 1
        while q <= self._n:
            self._data[q - 1] = self._data[q - 1] + x
            q += q & -q

    fn sum(self, left: Int, right: Int) -> T:
        debug_assert(0 <= left <= right <= self._n)
        return self._sum(right) + -self._sum(left)

    fn _sum(self, r: Int) -> T:
        var t = r
        var s = T()
        while t > 0:
            s = s + self._data[t - 1]
            t -= t & -t
        return s
