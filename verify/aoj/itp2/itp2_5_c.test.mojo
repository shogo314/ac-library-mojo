# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/problems/ITP2_5_C

from atcoder.io import IO
from atcoder.cpp.algorithm import next_permutation, prev_permutation


fn main() raises:
    var io = IO()
    var N = io.nextInt()
    var A = io.nextListInt(N)
    var tmp = A
    prev_permutation(tmp)
    if len(tmp):
        IO.print(tmp)
    tmp = A
    IO.print(tmp)
    next_permutation(tmp)
    if len(tmp):
        IO.print(tmp)
