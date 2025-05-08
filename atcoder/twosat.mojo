from atcoder._scc import _SCCGraph


struct TwoSat:
    var _n: Int
    var _answer: List[Bool]
    var _scc: _SCCGraph

    fn __init__(out self, n: Int):
        self._n = n
        self._scc = _SCCGraph(2 * n)
        self._answer = List(length=n, fill=False)

    fn add_clause(mut self, i: Int, f: Bool, j: Int, g: Bool):
        debug_assert(0 <= i < self._n)
        debug_assert(0 <= j < self._n)
        self._scc.add_edge(2 * i + (not f), 2 * j + g)
        self._scc.add_edge(2 * j + (not g), 2 * i + f)

    fn satisfiable(mut self) -> Bool:
        var ids = self._scc.scc_ids()[1]
        for i in range(self._n):
            if ids[2 * i] == ids[2 * i + 1]:
                return False
            self._answer[i] = ids[2 * i] < ids[2 * i + 1]
        return True

    fn answer(self) -> List[Bool]:
        return self._answer
