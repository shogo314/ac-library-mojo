# verification-helper: PROBLEM https://judge.yosupo.jp/problem/ordered_set

from atcoder.io import IO
from atcoder.segtree import RSumQ, max_right
from atcoder.py.bisect import bisect_left, bisect_right


fn eq_0(a: Int) -> Bool:
    return a == 0


fn main() raises:
    var io = IO()
    var N = io.nextInt()
    var Q = io.nextInt()
    var A = io.nextListInt(N)
    var tx = List[(Int, Int)]()
    for _ in range(Q):
        var t = io.nextInt()
        var x = io.nextInt()
        tx.append((t, x))
    var tmp = A
    for i in range(Q):
        if tx[i][0] <= 1:
            tmp.append(tx[i][1])
    sort(tmp)
    var v = List[Int]()
    for a in tmp:
        if len(v) == 0 or v[-1] < a[]:
            v.append(a[])
    var init = List[Int](length=len(v), fill=0)
    for a in A:
        init[bisect_left(v, a[])] = 1
    var seg = RSumQ(init)
    for i in range(Q):
        var t = tx[i][0]
        var x = tx[i][1]
        if t == 0:
            var idx = bisect_left(v, x)
            seg.set(idx, 1)
        elif t == 1:
            var idx = bisect_left(v, x)
            seg.set(idx, 0)
        elif t == 2:

            fn f(a: Int) -> Bool:
                return a < x

            var idx = max_right(seg, 0, f)
            if idx == len(v):
                print(-1)
            else:
                print(v[idx])
        elif t == 3:
            var idx = bisect_right(v, x)
            print(seg.prod(0, idx))
        elif t == 4:
            var r = bisect_right(v, x)
            var idx = seg.min_left[eq_0](r) - 1
            if idx == -1:
                print(-1)
            else:
                print(v[idx])
        elif t == 5:
            var l = bisect_left(v, x)
            var idx = seg.max_right[eq_0](l)
            if idx == len(v):
                print(-1)
            else:
                print(v[idx])
