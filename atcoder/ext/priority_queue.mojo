from testing import assert_true

from atcoder.py.heapq import heapify, heappush, heappop
from atcoder.method_traits import HasLtCollectionElement


struct PriorityQueue[S: HasLtCollectionElement]:
    var data: List[S]

    fn __init__(out self):
        self.data = List[S]()

    fn __init__(out self, data: List[S]):
        self.data = data
        heapify(self.data)

    fn top(self) raises -> S:
        assert_true(len(self.data))
        return self.data[0]

    fn push(mut self, item: S):
        heappush(self.data, item)

    fn pop(mut self) raises -> S:
        return heappop(self.data)

    fn clear(mut self):
        self.data.clear()

    fn __bool__(self) -> Bool:
        return len(self.data)

    fn __len__(self) -> Int:
        return len(self.data)
