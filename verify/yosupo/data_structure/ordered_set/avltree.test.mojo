# verification-helper: PROBLEM https://judge.yosupo.jp/problem/ordered_set

from atcoder.ext.data_structure.avltree import AVLTree
from atcoder.io import IO


fn main() raises:
    var io = IO()
    var N = io.nextInt()
    var Q = io.nextInt()
    var A = io.nextListInt(N)
    var avltree = AVLTree[Int]()
    for a in A:
        avltree.add(a[])
    for _ in range(Q):
        var q = io.nextInt()
        var x = io.nextInt()
        if q == 0:
            avltree.add(x)
        elif q == 1:
            avltree.discard(x)
        elif q == 2:
            if x <= len(avltree):
                print(avltree[x - 1])
            else:
                print(-1)
        elif q == 3:
            print(avltree.bisect_right(x))
        elif q == 4:
            var j = avltree.bisect_right(x) - 1
            if j == -1:
                print(-1)
            else:
                print(avltree[j])
        elif q == 5:
            var j = avltree.bisect_left(x)
            if j == len(avltree):
                print(-1)
            else:
                print(avltree[j])
