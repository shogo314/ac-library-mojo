# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/problems/ALDS1_9_C

from atcoder.io import IO
from atcoder.ext.priority_queue import PriorityQueue


fn main() raises:
    var io = IO()
    var heap = PriorityQueue[Int]()
    while True:
        var q = io.next()
        if q == "insert":
            heap.push(-io.nextInt())
        elif q == "extract":
            print(-heap.pop())
        else:
            break
