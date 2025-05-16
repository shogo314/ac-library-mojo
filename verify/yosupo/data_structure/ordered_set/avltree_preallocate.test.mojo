# verification-helper: PROBLEM https://judge.yosupo.jp/problem/ordered_set

from atcoder.ext.data_structure.avltree import AVLTree
from atcoder.io import IO


fn main() raises:
    var io = IO()
    var N = io.nextInt()
    var Q = io.nextInt()
    var A = io.nextListInt(N)
    var avl = AVLTree[Int, True](1000001)
    for a in A:
        avl.add(a[])
    for _ in range(Q):
        var q = io.nextInt()
        var x = io.nextInt()
        if q == 0:
            avl.add(x)
        elif q == 1:
            avl.discard(x)
        elif q == 2:
            if x <= len(avl):
                print(avl[x - 1])
            else:
                print(-1)
        elif q == 3:
            print(avl.bisect_right(x))
        elif q == 4:
            var j = avl.bisect_right(x) - 1
            if j == -1:
                print(-1)
            else:
                print(avl[j])
        elif q == 5:
            var j = avl.bisect_left(x)
            if j == len(avl):
                print(-1)
            else:
                print(avl[j])
