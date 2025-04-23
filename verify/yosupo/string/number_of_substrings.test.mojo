# verification-helper: PROBLEM https://judge.yosupo.jp/problem/number_of_substrings

from atcoder.io import IO
from atcoder.string import suffix_array, lcp_array


fn main() raises:
    var io = IO()
    var S = io.next()
    var sa = suffix_array(S)
    var la = lcp_array(S, sa)
    la.append(0)
    var ans = 0
    for i in range(len(S)):
        ans += len(S) - sa[i]
        ans -= la[i]
    print(ans)
