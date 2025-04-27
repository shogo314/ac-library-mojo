# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/problems/DPL_1_C

from atcoder.io import IO
from atcoder.ext.dp.knapsack_problem import knapsack


fn main() raises:
    var io = IO()
    var N = io.nextInt()
    var W = io.nextInt()
    var vw = List[(Int, Int)](capacity=N)
    for _ in range(N):
        var v = io.nextInt()
        var w = io.nextInt()
        vw.append((v, w))
    print(knapsack(vw, W))
