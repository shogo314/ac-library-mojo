# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/problems/ITP2_1_C

from atcoder.io import IO
from collections import LinkedList


fn main() raises:
    var io = IO()
    var Q = io.nextInt()
    var pre = LinkedList[Int]()
    var post = LinkedList[Int]()
    for _ in range(Q):
        var t = io.nextInt()
        if t == 0:
            var x = io.nextInt()
            post.prepend(x)
        elif t == 1:
            var d = io.nextInt()
            while d > 0:
                pre.append(post.pop(0))
                d -= 1
            while d < 0:
                post.prepend(pre.pop())
                d += 1
        else:
            _ = post.pop(0)
    for i in pre:
        print(i[])
    for i in post:
        print(i[])
