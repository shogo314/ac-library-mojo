from atcoder._csr import CSR


@value
struct _SCCEdge:
    var dst: Int


struct _SCCGraph:
    var _n: Int
    var _edges: List[(Int, _SCCEdge)]

    fn __init__(out self, n: Int):
        self._n = n
        self._edges = List[(Int, _SCCEdge)]()

    fn num_vertices(self) -> Int:
        return self._n

    fn add_edge(mut self, src: Int, dst: Int):
        self._edges.append((src, _SCCEdge(dst)))

    fn scc_ids(self) -> (Int, List[Int]):
        var g = CSR[_SCCEdge](self._n, self._edges)
        var now_ord = 0
        var group_num = 0
        var visited = List[Int](capacity=self._n)
        var low = List[Int](length=self._n, fill=0)
        var order = List[Int](length=self._n, fill=-1)
        var ids = List[Int](length=self._n, fill=0)
        var pre = -1
        for idx in range(self._n):
            if order[idx] != -1:
                continue
            var stk = List[(Int, Int)]((idx, g.start[idx]))
            while stk:
                var v = stk[-1][0]
                var i = stk[-1][1]
                _ = stk.pop()
                if i == g.start[v]:
                    order[v] = now_ord
                    low[v] = now_ord
                    now_ord += 1
                    visited.append(v)
                if i > g.start[v]:
                    if pre == g.elist[i - 1].dst:
                        low[v] = min(low[v], low[g.elist[i - 1].dst])
                    else:
                        low[v] = min(low[v], order[g.elist[i - 1].dst])
                if i < g.start[v + 1]:
                    var dst = g.elist[i].dst
                    stk.append((v, i + 1))
                    if order[dst] == -1:
                        stk.append((dst, g.start[dst]))
                if i == g.start[v + 1]:
                    if low[v] == order[v]:
                        while True:
                            var u = visited.pop()
                            order[u] = self._n
                            ids[u] = group_num
                            if u == v:
                                break
                        group_num += 1
                pre = v
        for i in range(self._n):
            ids[i] = group_num - 1 - ids[i]
        return (group_num, ids)

    fn scc(self) -> List[List[Int]]:
        var ids = self.scc_ids()
        var group_num = ids[0]
        var counts = List[Int](length=group_num, fill=0)
        for i in range(self._n):
            counts[ids[1][i]] += 1
        var groups = List[List[Int]](length=group_num, fill=List[Int]())
        for i in range(group_num):
            groups[i].reserve(counts[i])
        for i in range(self._n):
            groups[ids[1][i]].append(i)
        return groups
