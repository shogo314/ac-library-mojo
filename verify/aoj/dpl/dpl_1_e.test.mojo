# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/problems/DPL_1_E

from atcoder.io import IO
from atcoder.ext.string import levenshtein_distance


fn main() raises:
    var io = IO()
    print(levenshtein_distance(io.next(), io.next()))
