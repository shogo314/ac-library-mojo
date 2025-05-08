# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/problems/ITP2_5_D

from atcoder.io import IO
from atcoder.py.itertools import permutations


fn main() raises:
    var io = IO()
    var N = io.nextInt()
    var tmp = List[Int](capacity=N)
    for i in range(1, N + 1):
        tmp.append(i)
    for p in permutations(tmp):
        IO.print(p)
