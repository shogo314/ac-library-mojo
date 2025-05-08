from collections import Deque

from atcoder.method_traits import HasAdd, HasSub


alias Capable = Copyable & Movable & Defaultable & HasAdd & HasSub & Comparable


@value
struct MFEdge[Cap: Capable]:
    var src: Int
    var dst: Int
    var cap: Cap
    var flow: Cap


@value
struct _MFEdge[Cap: Capable]:
    var dst: Int
    var rev: Int
    var cap: Cap


struct MFGraph[Cap: Capable]:
    var _n: Int
    var _g: List[List[_MFEdge[Cap]]]
    var _pos: List[(Int, Int)]

    fn __init__(out self, n: Int):
        self._n = n
        self._g = List(length=n, fill=List[_MFEdge[Cap]]())
        self._pos = List[(Int, Int)]()

    fn add_edge(mut self, src: Int, dst: Int, cap: Cap) -> Int:
        debug_assert(0 <= src < self._n)
        debug_assert(0 <= dst < self._n)
        debug_assert(Cap() <= cap)
        var m = len(self._pos)
        self._pos.append((src, len(self._g[src])))
        var src_id = len(self._g[src])
        var dst_id = len(self._g[dst])
        if src == dst:
            dst_id += 1
        self._g[src].append(_MFEdge(dst, dst_id, cap))
        self._g[dst].append(_MFEdge(src, src_id, Cap()))
        return m

    fn get_edge(self, i: Int) -> MFEdge[Cap]:
        var m = len(self._pos)
        debug_assert(0 <= i < m)
        var _e = self._g[self._pos[i][0]][self._pos[i][1]]
        var _re = self._g[_e.dst][_e.rev]
        return MFEdge(self._pos[i][0], _e.dst, _e.cap + _re.cap, _re.cap)

    fn edges(self) -> List[MFEdge[Cap]]:
        var m = len(self._pos)
        var result = List[MFEdge[Cap]]()
        for i in range(m):
            result.append(self.get_edge(i))
        return result

    fn change_edge(mut self, i: Int, new_cap: Cap, new_flow: Cap):
        var m = len(self._pos)
        debug_assert(0 <= i < m)
        debug_assert(Cap() <= new_flow <= new_cap)
        var _e = self._g[self._pos[i][0]][self._pos[i][1]]
        var _re = self._g[_e.dst][_e.rev]
        _e.cap = new_cap - new_flow
        _re.cap = new_flow
        self._g[self._pos[i][0]][self._pos[i][1]] = _e
        self._g[_e.dst][_e.rev] = _re

    fn flow(mut self, s: Int, t: Int, flow_limit: Cap) -> Cap:
        debug_assert(0 <= s < self._n)
        debug_assert(0 <= t < self._n)
        debug_assert(s != t)
        var level = List[Int](length=self._n, fill=0)
        var current_edge = List[Int](length=self._n, fill=0)

        var flow = Cap()
        while flow < flow_limit:
            for i in range(self._n):
                level[i] = -1
            level[s] = 0
            var queue = Deque[Int]()
            queue.append(s)
            while queue:
                var v: Int
                try:
                    v = queue.popleft()
                except:
                    v = -1  # unreachable
                for e in self._g[v]:
                    if e[].cap == Cap() or level[e[].dst] >= 0:
                        continue
                    level[e[].dst] = level[v] + 1
                    if e[].dst == t:
                        queue.clear()
                        break
                    queue.append(e[].dst)

            if level[t] == -1:
                break
            for i in range(self._n):
                current_edge[i] = 0

            var res = Cap()
            var stack = List[(Int, Cap, Cap, Bool)]()
            stack.append((t, flow_limit - flow, Cap(), True))
            while stack:
                var v = stack[-1][0]
                var up = stack[-1][1]
                var w = stack[-1][2]
                var f = stack[-1][3]
                _ = stack.pop()
                if v == s:
                    res = up
                    continue
                var i = current_edge[v]
                if i == len(self._g[v]):
                    level[v] = self._n
                    res = w
                    continue
                var e = self._g[v][i]
                if f:
                    if (
                        level[v] <= level[e.dst]
                        or self._g[e.dst][e.rev].cap == Cap()
                    ):
                        current_edge[v] += 1
                        stack.append((v, up, w, True))
                        continue
                    var tmp = up - w
                    if tmp > self._g[e.dst][e.rev].cap:
                        tmp = self._g[e.dst][e.rev].cap
                    stack.append((v, up, w, False))
                    stack.append((e.dst, tmp, Cap(), True))
                else:
                    var d = res
                    if d <= Cap():
                        current_edge[v] += 1
                        stack.append((v, up, w, True))
                        continue
                    self._g[v][i].cap = self._g[v][i].cap + d
                    self._g[e.dst][e.rev].cap = self._g[e.dst][e.rev].cap - d
                    w = w + d
                    if w == up:
                        res = w
                        continue
                    current_edge[v] += 1
                    stack.append((v, up, w, True))
            flow = flow + res
        return flow
