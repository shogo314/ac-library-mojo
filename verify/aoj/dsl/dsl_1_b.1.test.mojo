# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/problems/DSL_1_B

from atcoder.io import IO
from atcoder.ext.potentialized_unionfind import PotentializedUnionFind
from atcoder.py.operator import add, neg


fn main() raises:
    var io = IO()
    var n = io.nextInt()
    var q = io.nextInt()
    var uf = PotentializedUnionFind[Int](n, add[Int], 0, neg[Int])
    for _ in range(q):
        t = io.nextInt()
        if t == 0:
            var x = io.nextInt()
            var y = io.nextInt()
            var z = io.nextInt()
            _ = uf.merge(x, y, z)
        else:
            var x = io.nextInt()
            var y = io.nextInt()
            if uf.same(x, y):
                print(uf.diff(x, y))
            else:
                print("?")
