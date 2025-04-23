# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/problems/ALDS1_9_C

from atcoder.io import IO
from atcoder.ext.priority_queue import PriorityQueue


@value
struct Wrapper:
    var value: Int

    fn __lt__(self, o: Self) -> Bool:
        return self.value > o.value


fn main() raises:
    var io = IO()
    var heap = PriorityQueue[Wrapper]()
    while True:
        var q = io.next()
        if q == "insert":
            heap.push(Wrapper(io.nextInt()))
        elif q == "extract":
            print(heap.pop().value)
        else:
            break
