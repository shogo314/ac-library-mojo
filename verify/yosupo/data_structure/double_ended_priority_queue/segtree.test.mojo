# verification-helper: PROBLEM https://judge.yosupo.jp/problem/double_ended_priority_queue

from atcoder.io import IO
from atcoder.segtree import RSumQ
from atcoder.py.bisect import bisect_left


fn eq_0(x: Int) -> Bool:
    return x == 0


fn main() raises:
    var io = IO()
    var N = io.nextInt()
    var Q = io.nextInt()
    var S = io.nextListInt(N)
    var tx = List[(Int, Int)]()
    for _ in range(Q):
        var t = io.nextInt()
        if t == 0:
            var x = io.nextInt()
            tx.append((t, x))
        else:
            tx.append((t, 0))
    var tmp = S
    for i in range(Q):
        if tx[i][0] == 0:
            tmp.append(tx[i][1])
    sort(tmp)
    var v = List[Int]()
    for a in tmp:
        if len(v) == 0 or v[-1] < a[]:
            v.append(a[])
    var init = List[Int](length=len(v), fill=0)
    for s in S:
        init[bisect_left(v, s[])] += 1
    var seg = RSumQ(init)
    for i in range(Q):
        var t = tx[i][0]
        if t == 0:
            var x = tx[i][1]
            var idx = bisect_left(v, x)
            seg.set(idx, seg.get(idx) + 1)
        elif t == 1:
            var idx = seg.max_right[eq_0](0)
            print(v[idx])
            seg.set(idx, seg.get(idx) - 1)
        elif t == 2:
            var idx = seg.min_left[eq_0](len(v)) - 1
            print(v[idx])
            seg.set(idx, seg.get(idx) - 1)
