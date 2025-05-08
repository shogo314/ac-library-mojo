# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/problems/ITP2_2_C

from atcoder.io import IO
from atcoder.ext.data_structure.priority_queue import heap_max


fn main() raises:
    var io = IO()
    var N = io.nextInt()
    var Q = io.nextInt()
    var que = List(length=N, fill=heap_max[Int]())
    for _ in range(Q):
        var t = io.nextInt()
        if t == 0:
            var t = io.nextInt()
            var x = io.nextInt()
            que[t].push(x)
        elif t == 1:
            var t = io.nextInt()
            if que[t]:
                print(que[t].top())
        else:
            var t = io.nextInt()
            if que[t]:
                _ = que[t].pop()
