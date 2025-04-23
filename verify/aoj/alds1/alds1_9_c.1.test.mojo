# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/problems/ALDS1_9_C

from atcoder.io import IO
from atcoder.py.heapq import heappush, heappop


fn main() raises:
    var io = IO()
    var heap = List[Int]()
    while True:
        var q = io.next()
        if q == "insert":
            heappush(heap, -io.nextInt())
        elif q == "extract":
            print(-heappop(heap))
        else:
            break
