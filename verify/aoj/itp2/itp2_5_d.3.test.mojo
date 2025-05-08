# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/problems/ITP2_5_D

from atcoder.io import IO
from atcoder.py.itertools import permutations


fn main() raises:
    var io = IO()
    var N = io.nextInt()
    for p in permutations(range(1, N + 1)):
        IO.print(p)
