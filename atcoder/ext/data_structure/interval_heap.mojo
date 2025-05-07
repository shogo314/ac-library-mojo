from atcoder.method_traits import HasLt


struct IntervalHeap[S: HasLt & CollectionElement]:
    var data: List[S]

    fn __init__(out self):
        self.data = List[S]()

    fn __init__(out self, data: List[S]):
        self.data = data
        for i in reversed(range(len(self.data))):
            if i & 1 and self.data[i - 1] < self.data[i]:
                self.data.swap_elements(i - 1, i)
            _ = self._up(self._down(i), i)

    fn min(self) -> S:
        debug_assert(len(self.data))
        if len(self.data) == 1:
            return self.data[0]
        else:
            return self.data[1]

    fn max(self) -> S:
        debug_assert(len(self.data))
        return self.data[0]

    fn pop_min(mut self) -> S:
        debug_assert(len(self.data))
        if len(self.data) < 3:
            return self.data.pop()
        else:
            self.data.swap_elements(1, len(self.data) - 1)
            var res = self.data.pop()
            _ = self._up(self._down(1))
            return res

    fn pop_max(mut self) -> S:
        debug_assert(len(self.data))
        if len(self.data) < 2:
            return self.data.pop()
        else:
            self.data.swap_elements(0, len(self.data) - 1)
            var res = self.data.pop()
            _ = self._up(self._down(0))
            return res

    fn push(mut self, item: S):
        var k = len(self.data)
        self.data.append(item)
        _ = self._up(k)

    fn __bool__(self) -> Bool:
        return len(self.data)

    fn __len__(self) -> Int:
        return len(self.data)

    @staticmethod
    fn parent(k: Int) -> Int:
        return ((k >> 1) - 1) & ~1

    fn _down(mut self, k_: Int) -> Int:
        var k = k_
        var n = len(self.data)
        if k & 1:
            while 2 * k + 1 < n:
                var c = 2 * k + 3
                if n <= c or self.data[c - 2] < self.data[c]:
                    c -= 2
                if c < n and self.data[c] < self.data[k]:
                    self.data.swap_elements(k, c)
                    k = c
                else:
                    break
        else:
            while 2 * k + 2 < n:
                var c = 2 * k + 4
                if n <= c or self.data[c] < self.data[c - 2]:
                    c -= 2
                if c < n and self.data[k] < self.data[c]:
                    self.data.swap_elements(k, c)
                    k = c
                else:
                    break
        return k

    fn _up(mut self, k_: Int, root: Int = 1) -> Int:
        var k = k_
        if (k | 1) < len(self.data) and self.data[k & ~1] < self.data[k | 1]:
            self.data.swap_elements(k & ~1, k | 1)
            k ^= 1
        var p = 0
        while root < k and self.data[Self.parent(k)] < self.data[k]:
            p = Self.parent(k)
            self.data.swap_elements(p, k)
            k = p
        while root < k and self.data[k] < self.data[Self.parent(k) | 1]:
            p = Self.parent(k) | 1
            self.data.swap_elements(p, k)
            k = p
        return k
