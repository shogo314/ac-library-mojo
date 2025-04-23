# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/problems/DSL_2_B

from atcoder.io import IO
from atcoder.fenwicktree import FenwickTree


fn main() raises:
    var io = IO()
    var n = io.nextInt()
    var q = io.nextInt()
    var bit = FenwickTree[Int](n)
    for _ in range(q):
        var com = io.nextInt()
        var x = io.nextInt()
        var y = io.nextInt()
        if com == 0:
            bit.add(x - 1, y)
        else:
            print(bit.sum(x - 1, y))
