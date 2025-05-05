# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/problems/ALDS1_1_B

from atcoder.io import IO
from math import gcd


fn main() raises:
    var io = IO()
    var x = io.nextInt()
    var y = io.nextInt()
    print(gcd(x, y))
