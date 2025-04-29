# verification-helper: PROBLEM https://judge.yosupo.jp/problem/static_range_sum

from atcoder.io import IO


fn main() raises:
    var io = IO()
    var N = io.nextInt()
    var Q = io.nextInt()
    var a = io.nextListInt(N)
    var acc = List[Int]()
    acc.resize(N + 1, 0)
    for i in range(N):
        acc[i + 1] = acc[i] + a[i]
    for _ in range(Q):
        var l = io.nextInt()
        var r = io.nextInt()
        print(acc[r] - acc[l])
