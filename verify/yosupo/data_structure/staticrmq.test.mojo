# verification-helper: PROBLEM https://judge.yosupo.jp/problem/staticrmq

from atcoder.io import IO
from atcoder.segtree import RMinQ


fn main() raises:
    var io = IO()
    var n = io.nextInt()
    var q = io.nextInt()
    var a = io.nextListInt(n)
    var seg = RMinQ[Int](a, Int.MAX)
    for _ in range(q):
        var l = io.nextInt()
        var r = io.nextInt()
        print(seg.prod(l, r))
