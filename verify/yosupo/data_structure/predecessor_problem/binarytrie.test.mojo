# verification-helper: PROBLEM https://judge.yosupo.jp/problem/predecessor_problem

from atcoder.ext.data_structure.binarytrie import BinaryTrie
from atcoder.io import IO


fn main() raises:
    var io = IO()
    var N = io.nextInt()
    var Q = io.nextInt()
    var T = io.next()
    var trie = BinaryTrie[27]()
    for i in range(N):
        if T[i] == "1":
            trie.add(i)
    for _ in range(Q):
        var q = io.nextInt()
        var k = io.nextInt()
        if q == 0:
            if k not in trie:
                trie.add(k)
        elif q == 1:
            if k in trie:
                trie.remove(k)
        elif q == 2:
            print(Int(k in trie))
        elif q == 3:
            var j = trie.bisect_left(k)
            if j == len(trie):
                print(-1)
            else:
                print(trie[j])
        elif q == 4:
            var j = trie.bisect_right(k) - 1
            if j == -1:
                print(-1)
            else:
                print(trie[j])
