# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/problems/DPL_1_B

from atcoder.io import IO
from atcoder.ext.algorithm import knapsack_01


fn main() raises:
    var io = IO()
    var N = io.nextInt()
    var W = io.nextInt()
    var vw = List[(Int, Int)](capacity=N)
    for _ in range(N):
        var v = io.nextInt()
        var w = io.nextInt()
        vw.append((v, w))
    print(knapsack_01(vw, W))
