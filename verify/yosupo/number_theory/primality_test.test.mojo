# verification-helper: PROBLEM https://judge.yosupo.jp/problem/primality_test

from atcoder.io import IO
from atcoder.py.sympy import isprime


fn main() raises:
    var io = IO()
    var Q = io.nextInt()
    for _ in range(Q):
        var N = io.nextInt()
        if isprime(N):
            print("Yes")
        else:
            print("No")
