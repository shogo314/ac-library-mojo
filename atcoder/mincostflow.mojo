from collections import Deque

from atcoder._csr import CSR
from atcoder.py.heapq import heappop, heappush

alias Cap = Int
alias Cost = Int


@value
struct MCFEdge:
    var src: Int
    var dst: Int
    var cap: Cap
    var flow: Cap
    var cost: Cost


@value
struct _MCFEdge:
    var dst: Int
    var rev: Int
    var cap: Cap
    var cost: Cost


@value
struct MCFGraph:
    var _n: Int
    var _edges: List[MCFEdge]

    fn __init__(out self, n: Int):
        self._n = n
        self._edges = List[MCFEdge]()

    fn add_edge(mut self, src: Int, dst: Int, cap: Cap, cost: Cost) -> Int:
        debug_assert(0 <= src < self._n)
        debug_assert(0 <= dst < self._n)
        debug_assert(Cap() <= cap)
        debug_assert(Cost() <= cost)
        var m = len(self._edges)
        self._edges.append(MCFEdge(src, dst, cap, Cap(), cost))
        return m

    fn get_edge(self, i: Int) -> MCFEdge:
        var m = len(self._edges)
        debug_assert(0 <= i < m)
        return self._edges[i]

    fn edges(self) -> List[MCFEdge]:
        return self._edges

    fn flow(mut self, s: Int, t: Int, flow_limit: Cap) -> (Cap, Cost):
        return self.slope(s, t, flow_limit)[-1]

    fn slope(mut self, s: Int, t: Int, flow_limit: Cap) -> List[(Cap, Cost)]:
        debug_assert(0 <= s < self._n)
        debug_assert(0 <= t < self._n)
        debug_assert(s != t)
        var m = len(self._edges)
        var edge_idx = List[Int](length=m, fill=0)

        var degree = List[Int](length=self._n, fill=0)
        var redge_idx = List[Int](length=m, fill=0)
        var elist = List[(Int, _MCFEdge)]()
        for i in range(m):
            var e = self._edges[i]
            edge_idx[i] = degree[e.src]
            degree[e.src] += 1
            redge_idx[i] = degree[e.dst]
            degree[e.dst] += 1
            elist.append((e.src, _MCFEdge(e.dst, -1, e.cap - e.flow, e.cost)))
            elist.append((e.dst, _MCFEdge(e.src, -1, e.flow, -e.cost)))
        var g = CSR(self._n, elist)
        for i in range(m):
            var e = self._edges[i]
            edge_idx[i] += g.start[e.src]
            redge_idx[i] += g.start[e.dst]
            g.elist[edge_idx[i]].rev = redge_idx[i]
            g.elist[redge_idx[i]].rev = edge_idx[i]

        var result = self._slope(g, s, t, flow_limit)

        for i in range(m):
            var e = g.elist[edge_idx[i]]
            self._edges[i].flow = self._edges[i].cap - e.cap

        return result

    fn _slope(
        self, mut g: CSR[_MCFEdge], s: Int, t: Int, flow_limit: Cap
    ) -> List[(Cap, Cost)]:
        var dual_dist = List[(Cost, Cost)](
            length=self._n, fill=(Cost(), Cost())
        )
        var prev_e = List[Int](length=self._n, fill=0)
        var vis = List[Bool](length=self._n, fill=False)

        var que_min = List[Int]()
        var que = List[_Q]()

        var flow = Cap()
        var cost = Cost(0)
        var prev_cost_per_flow = Cost(-1)
        var result = List[(Cap, Cost)]((Cap(), Cost(0)))
        while flow < flow_limit:
            for i in range(self._n):
                dual_dist[i][1] = Cost(Int.MAX)
                vis[i] = False
            que_min.clear()
            que.clear()

            dual_dist[s][1] = Cost(0)
            que_min.append(s)

            while que_min or len(que):
                var v: Int
                if que_min:
                    v = que_min.pop()
                else:
                    v = heappop(que).dst
                if vis[v]:
                    continue
                vis[v] = True
                if v == t:
                    break
                var dual_v = dual_dist[v][0]
                var dist_v = dual_dist[v][1]
                for i in range(g.start[v], g.start[v + 1]):
                    var e = g.elist[i]
                    if e.cap == Cap():
                        continue
                    var _cost = e.cost - dual_dist[e.dst][0] + dual_v
                    if dual_dist[e.dst][1] - dist_v > _cost:
                        var dist_dst = dist_v + _cost
                        dual_dist[e.dst][1] = dist_dst
                        prev_e[e.dst] = e.rev
                        if dist_dst == dist_v:
                            que_min.append(e.dst)
                        else:
                            heappush(que, _Q(dist_dst, e.dst))
            if not vis[t]:
                break
            for v in range(self._n):
                if not vis[v]:
                    continue
                dual_dist[v][0] = dual_dist[v][0] - (
                    dual_dist[t][1] - dual_dist[v][1]
                )

            var c = flow_limit - flow
            var v = t
            while v != s:
                var e = g.elist[prev_e[v]]
                if c > g.elist[e.rev].cap:
                    c = g.elist[e.rev].cap
                v = g.elist[prev_e[v]].dst
            v = t
            while v != s:
                var e = g.elist[prev_e[v]]
                g.elist[prev_e[v]].cap = e.cap + c
                g.elist[e.rev].cap = g.elist[e.rev].cap - c
                v = g.elist[prev_e[v]].dst
            var d = Cost(0) - dual_dist[s][0]
            flow = flow + c
            cost = cost + c * d
            if prev_cost_per_flow == d:
                _ = result.pop()
            result.append((flow, cost))
            prev_cost_per_flow = d
        return result


@value
struct _Q:
    var key: Cost
    var dst: Int

    fn __lt__(self, o: Self) -> Bool:
        return self.key < o.key
