struct DSU:
    var _n: Int
    var _parent_or_size: List[Int]

    fn __init__(out self, n: Int):
        self._n = n
        self._parent_or_size = List(length=n, fill=-1)

    fn merge(mut self, a: Int, b: Int) -> Int:
        debug_assert(0 <= a < self._n)
        debug_assert(0 <= b < self._n)
        var x: Int = self.leader(a)
        var y: Int = self.leader(b)
        if x == y:
            return x
        if -self._parent_or_size[x] < -self._parent_or_size[y]:
            x, y = y, x
        self._parent_or_size[x] += self._parent_or_size[y]
        self._parent_or_size[y] = x
        return x

    fn same(mut self, a: Int, b: Int) -> Bool:
        debug_assert(0 <= a < self._n)
        debug_assert(0 <= b < self._n)
        return self.leader(a) == self.leader(b)

    fn leader(mut self, a: Int) -> Int:
        debug_assert(0 <= a < self._n)
        return self._leader(a)

    fn _leader(mut self, a: Int) -> Int:
        if self._parent_or_size[a] < 0:
            return a
        self._parent_or_size[a] = self._leader(self._parent_or_size[a])
        return self._parent_or_size[a]

    fn size(mut self, a: Int) -> Int:
        debug_assert(0 <= a < self._n)
        return -self._parent_or_size[self.leader(a)]

    fn groups(mut self) -> List[List[Int]]:
        var leader_buf = List[Int](length=self._n, fill=0)
        var group_size = List[Int](length=self._n, fill=0)
        for i in range(self._n):
            leader_buf[i] = self.leader(i)
            group_size[leader_buf[i]] += 1
        var result = List[List[Int]](length=self._n, fill=List[Int]())
        for i in range(self._n):
            result[leader_buf[i]].append(i)
        var res = List[List[Int]]()
        for i in range(self._n):
            if len(result[i]):
                res.append(result[i])
        return res


alias UnionFind = DSU
