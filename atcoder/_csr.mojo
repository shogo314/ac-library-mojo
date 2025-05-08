struct CSR[E: Copyable & Movable]:
    var start: List[Int]
    var elist: List[E]

    fn __init__(out self, n: Int, edges: List[(Int, E)]):
        self.start = List[Int](capacity=n + 1)
        self.elist = List[E](capacity=len(edges))
        var tmp = List[List[E]](length=n, fill=List[E]())
        for e in edges:
            tmp[e[][0]].append(e[][1])
        self.start.append(0)
        for i in range(n):
            self.start.append(self.start[-1] + len(tmp[i]))
            self.elist.extend(tmp[i])
