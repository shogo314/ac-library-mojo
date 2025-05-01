# verification-helper: PROBLEM https://judge.yosupo.jp/problem/predecessor_problem

from atcoder.ext.data_structure.wordsizetree import WordSizeTree
from atcoder.io import IO


fn main() raises:
    var io = IO()
    var N = io.nextInt()
    var Q = io.nextInt()
    var T = io.next()
    var wstree = WordSizeTree[4]()
    for i in range(N):
        if T[i] == "1":
            wstree.add(i)
    for _ in range(Q):
        var q = io.nextInt()
        var k = io.nextInt()
        if q == 0:
            wstree.add(k)
        elif q == 1:
            wstree.extract(k)
        elif q == 2:
            print(Int(k in wstree))
        elif q == 3:
            print(wstree.ge(k))
        elif q == 4:
            print(wstree.le(k))
