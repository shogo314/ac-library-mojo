# verification-helper: PROBLEM https://judge.yosupo.jp/problem/unionfind

from atcoder.io import IO
from atcoder.dsu import DSU


fn main() raises:
    var io = IO()
    var N = io.nextInt()
    var Q = io.nextInt()
    var dsu = DSU(N)
    for _ in range(Q):
        var t = io.nextInt()
        var u = io.nextInt()
        var v = io.nextInt()
        if t == 0:
            _ = dsu.merge(u, v)
        else:
            if dsu.same(u, v):
                print(1)
            else:
                print(0)
