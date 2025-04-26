# verification-helper: PROBLEM https://judge.yosupo.jp/problem/double_ended_priority_queue

from atcoder.io import IO
from atcoder.ext.avltree import AVLTree


fn main() raises:
    var io = IO()
    var N = io.nextInt()
    var Q = io.nextInt()
    var S = io.nextListInt(N)
    var tree = AVLTree[Int]()
    for s in S:
        tree.add(s[])
    for _ in range(Q):
        var op = io.nextInt()
        if op == 0:
            var x = io.nextInt()
            tree.add(x)
        elif op == 1:
            var ans = tree[0]
            print(ans)
            tree.remove(ans)
        else:
            var ans = tree[len(tree) - 1]
            print(ans)
            tree.remove(ans)
