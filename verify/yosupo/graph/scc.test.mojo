# verification-helper: PROBLEM https://judge.yosupo.jp/problem/scc

from atcoder.io import IO
from atcoder.scc import SCCGraph


fn main() raises:
    var io = IO()
    var N = io.nextInt()
    var M = io.nextInt()
    var graph = SCCGraph(N)
    for _ in range(M):
        var a = io.nextInt()
        var b = io.nextInt()
        graph.add_edge(a, b)
    var ans = graph.scc()
    print(len(ans))
    for i in range(len(ans)):
        print(len(ans[i]), end=" ")
        IO.print(ans[i])
