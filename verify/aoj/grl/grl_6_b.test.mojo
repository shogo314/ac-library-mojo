# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/problems/GRL_6_B

from atcoder.io import IO
from atcoder.mincostflow import MCFGraph


fn main() raises:
    var io = IO()
    var n = io.nextInt()
    var m = io.nextInt()
    var f = io.nextInt()
    var mcf_graph = MCFGraph(n)
    for _ in range(m):
        var u = io.nextInt()
        var v = io.nextInt()
        var c = io.nextInt()
        var d = io.nextInt()
        _ = mcf_graph.add_edge(u, v, c, d)
    var ans = mcf_graph.flow(0, n - 1, f)
    if ans[0] == f:
        print(ans[1])
    else:
        print(-1)
