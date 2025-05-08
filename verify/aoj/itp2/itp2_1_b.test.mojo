# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/problems/ITP2_1_B

from atcoder.io import IO
from collections import Deque


fn main() raises:
    var io = IO()
    var Q = io.nextInt()
    var que = Deque[Int]()
    for _ in range(Q):
        var t = io.nextInt()
        if t == 0:
            var d = io.nextInt()
            var x = io.nextInt()
            if d == 0:
                que.appendleft(x)
            else:
                que.append(x)
        elif t == 1:
            var p = io.nextInt()
            print(que[p])
        else:
            var d = io.nextInt()
            if d == 0:
                _ = que.popleft()
            else:
                _ = que.pop()
