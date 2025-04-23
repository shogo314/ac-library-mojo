# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/problems/GRL_7_A

from atcoder.io import IO
from atcoder.maxflow import MFGraph


fn main() raises:
    var io = IO()
    var X = io.nextInt()
    var Y = io.nextInt()
    var E = io.nextInt()
    var mf_graph = MFGraph[Int](X + Y + 2)
    for i in range(X):
        _ = mf_graph.add_edge(X + Y, i, 1)
    for i in range(Y):
        _ = mf_graph.add_edge(X + i, X + Y + 1, 1)
    for _ in range(E):
        var a = io.nextInt()
        var b = io.nextInt()
        _ = mf_graph.add_edge(a, X + b, 1)
    print(mf_graph.flow(X + Y, X + Y + 1, Int.MAX))
