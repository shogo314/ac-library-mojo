# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/problems/GRL_6_A

from atcoder.io import IO
from atcoder.maxflow import MFGraph


fn main() raises:
    var io = IO()
    var n = io.nextInt()
    var m = io.nextInt()
    var mf_graph = MFGraph[Int](n)
    for _ in range(m):
        var u = io.nextInt()
        var v = io.nextInt()
        var c = io.nextInt()
        _ = mf_graph.add_edge(u, v, c)
    print(mf_graph.flow(0, n - 1, Int.MAX))
