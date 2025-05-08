# verification-helper: PROBLEM https://judge.yosupo.jp/problem/associative_array

from atcoder.io import IO
from atcoder.py.bisect import bisect_left


fn main() raises:
    var io = IO()
    var Q = io.nextInt()
    var tk = List[(Int, Int, Int)](capacity=Q)
    var tmp = List[Int](capacity=Q)
    for _ in range(Q):
        var t = io.nextInt()
        var k = io.nextInt()
        var v = 0
        if t == 0:
            v = io.nextInt()
        tmp.append(k)
        tk.append((t, k, v))
    sort(tmp)
    var s = List[Int]()
    for a in tmp:
        if len(s) == 0 or s[-1] < a[]:
            s.append(a[])
    var dat = List[Int](length=len(s), fill=0)
    for i in range(Q):
        var t = tk[i][0]
        var k = tk[i][1]
        if t == 0:
            var v = tk[i][2]
            dat[bisect_left(s, k)] = v
        else:
            print(dat[bisect_left(s, k)])
