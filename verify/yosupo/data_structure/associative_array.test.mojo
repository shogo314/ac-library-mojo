# verification-helper: PROBLEM https://judge.yosupo.jp/problem/associative_array

from collections import Dict
from atcoder.io import IO


fn main() raises:
    var d = Dict[Int, Int]()
    var io = IO()
    var Q = io.nextInt()
    for _ in range(Q):
        var q = io.nextInt()
        if q == 0:
            var k = io.nextInt()
            var v = io.nextInt()
            d[k] = v
        else:
            var k = io.nextInt()
            print(d.get(k, 0))
