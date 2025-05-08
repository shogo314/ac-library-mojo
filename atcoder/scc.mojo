from atcoder._scc import _SCCGraph


@value
struct SCCGraph:
    var internal: _SCCGraph

    fn __init__(out self, n: Int):
        self.internal = _SCCGraph(n)

    fn add_edge(mut self, src: Int, dst: Int):
        var n = self.internal.num_vertices()
        debug_assert(0 <= src < n)
        debug_assert(0 <= dst < n)
        self.internal.add_edge(src, dst)

    fn scc(self) -> List[List[Int]]:
        return self.internal.scc()
