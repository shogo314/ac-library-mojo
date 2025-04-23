# verification-helper: PROBLEM https://judge.yosupo.jp/problem/unionfind_with_potential

from atcoder.io import IO
from atcoder.ext.potentialized_unionfind import UnionFindPlus
from atcoder.modint import modint998244353

alias mint = modint998244353


fn main() raises:
    var io = IO()
    var N = io.nextInt()
    var Q = io.nextInt()
    var uf = UnionFindPlus[mint](N)
    for _ in range(Q):
        var t = io.nextInt()
        var u = io.nextInt()
        var v = io.nextInt()
        if t == 0:
            x = io.nextInt()
            if uf.same(u, v):
                if uf.diff(v, u) == x:
                    print(1)
                else:
                    print(0)
            else:
                print(1)
                _ = uf.merge(v, u, mint(x))
        else:
            if uf.same(u, v):
                print(uf.diff(v, u))
            else:
                print(-1)
