# verification-helper: PROBLEM https://judge.yosupo.jp/problem/many_aplusb

from atcoder.io import IO


fn main() raises:
    var io = IO[256]()
    var T = io.nextInt()
    for _ in range(T):
        var A = io.nextInt()
        var B = io.nextInt()
        print(A + B)
