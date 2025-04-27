# verification-helper: PROBLEM https://judge.yosupo.jp/problem/double_ended_priority_queue

from atcoder.io import IO
from atcoder.ext.data_structure.interval_heap import IntervalHeap


fn main() raises:
    var io = IO()
    var N = io.nextInt()
    var Q = io.nextInt()
    var S = io.nextListInt(N)
    var heap = IntervalHeap[Int](S)
    for _ in range(Q):
        var op = io.nextInt()
        if op == 0:
            var x = io.nextInt()
            heap.push(x)
        elif op == 1:
            print(heap.pop_min())
        else:
            print(heap.pop_max())
