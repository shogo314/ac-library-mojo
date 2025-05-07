from atcoder.py.operator import lt, gt


struct PriorityQueue[S: CollectionElement]:
    var comp: fn (S, S) -> Bool
    var data: List[S]

    fn _heapify(mut self, k: Int):
        if len(self.data) <= 2 * k + 1:
            pass
        else:
            var nk = 2 * k + 1
            if 2 * k + 2 < len(self.data) and self.comp(
                self.data[2 * k + 2], self.data[2 * k + 1]
            ):
                nk = 2 * k + 2
            if self.comp(self.data[nk], self.data[k]):
                self.data.swap_elements(k, nk)
                self._heapify(nk)

    fn __init__(out self, comp: fn (S, S) -> Bool):
        self.comp = comp
        self.data = List[S]()

    fn __init__(out self, data: List[S], comp: fn (S, S) -> Bool):
        self.comp = comp
        self.data = data
        for i in reversed(range(len(self.data))):
            self._heapify(i)

    fn top(self) -> S:
        debug_assert(len(self.data))
        return self.data[0]

    fn push(mut self, item: S):
        var k = len(self.data)
        self.data.append(item)
        while k:
            var nk = (k - 1) >> 1
            if self.comp(self.data[k], self.data[nk]):
                self.data.swap_elements(k, nk)
                k = nk
            else:
                break

    fn pop(mut self) -> S:
        debug_assert(len(self.data))
        if len(self.data) == 1:
            return self.data.pop()
        var res = self.data[0]
        self.data.swap_elements(0, len(self.data) - 1)
        _ = self.data.pop()
        self._heapify(0)
        return res

    fn clear(mut self):
        self.data.clear()

    fn __bool__(self) -> Bool:
        return len(self.data)

    fn __len__(self) -> Int:
        return len(self.data)


fn heap_min[S: LessThanComparable & CollectionElement]() -> PriorityQueue[S]:
    return PriorityQueue[S](lt[S])


fn heap_min[
    S: LessThanComparable & CollectionElement
](v: List[S]) -> PriorityQueue[S]:
    return PriorityQueue[S](v, lt[S])


fn heap_max[S: LessThanComparable & CollectionElement]() -> PriorityQueue[S]:
    return PriorityQueue[S](gt[S])


fn heap_max[
    S: LessThanComparable & CollectionElement
](v: List[S]) -> PriorityQueue[S]:
    return PriorityQueue[S](v, gt[S])
