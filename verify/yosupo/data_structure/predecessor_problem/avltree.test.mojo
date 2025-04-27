# verification-helper: PROBLEM https://judge.yosupo.jp/problem/predecessor_problem

from atcoder.ext.data_structure.avltree import AVLTree
from atcoder.io import IO


fn main() raises:
    var io = IO()
    var N = io.nextInt()
    var Q = io.nextInt()
    var T = io.next()
    var avltree = AVLTree[Int]()
    for i in range(N):
        if T[i] == "1":
            avltree.add(i)
    for _ in range(Q):
        var q = io.nextInt()
        var k = io.nextInt()
        if q == 0:
            avltree.add(k)
        elif q == 1:
            avltree.discard(k)
        elif q == 2:
            print(Int(k in avltree))
        elif q == 3:
            var j = avltree.bisect_left(k)
            if j == len(avltree):
                print(-1)
            else:
                print(avltree[j])
        elif q == 4:
            var j = avltree.bisect_right(k) - 1
            if j == -1:
                print(-1)
            else:
                print(avltree[j])
