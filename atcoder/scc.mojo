from testing import assert_true
from atcoder._scc import _SCCGraph


struct SCCGraph:
    var internal: _SCCGraph

    fn __init__(out self, n: Int):
        self.internal = _SCCGraph(n)

    fn add_edge(mut self, src: Int, dst: Int) raises:
        var n = self.internal.num_vertices()
        assert_true(0 <= src < n)
        assert_true(0 <= dst < n)
        self.internal.add_edge(src, dst)

    fn scc(self) -> List[List[Int]]:
        return self.internal.scc()
