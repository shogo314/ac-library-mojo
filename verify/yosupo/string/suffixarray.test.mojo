# verification-helper: PROBLEM https://judge.yosupo.jp/problem/suffixarray

from atcoder.io import IO
from atcoder.string import suffix_array


fn main() raises:
    var io = IO()
    IO.print(suffix_array(io.next()))
