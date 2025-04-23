# verification-helper: PROBLEM https://judge.yosupo.jp/problem/sum_of_floor_of_linear

from atcoder.io import IO
from atcoder.math import floor_sum


fn main() raises:
    var io = IO()
    var T = io.nextInt()
    for _ in range(T):
        var N = io.nextInt()
        var M = io.nextInt()
        var A = io.nextInt()
        var B = io.nextInt()
        print(floor_sum(N, M, A, B))
