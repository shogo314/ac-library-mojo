# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/problems/ITP2_5_D

from atcoder.io import IO
from atcoder.py.itertools import permutations


fn main() raises:
    var io = IO()
    var N = io.nextInt()
    for p in permutations(range(N)):
        var tmp = p
        for i in range(N):
            tmp[i] += 1
        IO.print(tmp)
