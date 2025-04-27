# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/problems/ALDS1_9_C

from atcoder.io import IO
from atcoder.ext.data_structure.priority_queue import heap_max


fn main() raises:
    var io = IO()
    var heap = heap_max[Int]()
    while True:
        var q = io.next()
        if q == "insert":
            heap.push(io.nextInt())
        elif q == "extract":
            print(heap.pop())
        else:
            break
