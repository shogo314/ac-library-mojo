# verification-helper: PROBLEM https://judge.yosupo.jp/problem/bipartitematching

from atcoder.io import IO
from atcoder.maxflow import MFGraph


fn main() raises:
    var io = IO()
    var L = io.nextInt()
    var R = io.nextInt()
    var M = io.nextInt()
    var mf_graph = MFGraph[Int](L + R + 2)
    for i in range(L):
        _ = mf_graph.add_edge(L + R, i, 1)
    for i in range(R):
        _ = mf_graph.add_edge(L + i, L + R + 1, 1)
    for _ in range(M):
        var a = io.nextInt()
        var b = io.nextInt()
        _ = mf_graph.add_edge(a, L + b, 1)
    var ans = mf_graph.flow(L + R, L + R + 1, Int.MAX)
    print(ans)
    for e in mf_graph.edges():
        if e[].src == L + R:
            continue
        if e[].dst == L + R + 1:
            continue
        if e[].flow == 0:
            continue
        print(e[].src, e[].dst - L)
