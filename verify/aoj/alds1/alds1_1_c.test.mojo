# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/problems/ALDS1_1_C

from atcoder.io import IO
from atcoder.py.sympy import isprime


fn main() raises:
    var io = IO()
    var n = io.nextInt()
    var ans = 0
    for _ in range(n):
        var x = io.nextInt()
        if isprime(x):
            ans += 1
    print(ans)
