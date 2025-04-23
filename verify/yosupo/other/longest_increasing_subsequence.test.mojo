# verification-helper: PROBLEM https://judge.yosupo.jp/problem/longest_increasing_subsequence

from atcoder.io import IO
from atcoder.ext.algorithm import longest_increasing_subsequence


fn main() raises:
    var io = IO()
    var N = io.nextInt()
    var A = io.nextListInt(N)
    var ans = longest_increasing_subsequence(A)
    print(len(ans))
    IO.print(ans)
