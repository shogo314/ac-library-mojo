# verification-helper: PROBLEM https://judge.yosupo.jp/problem/ordered_set

from atcoder.ext.data_structure.binarytrie import BinaryTrie
from atcoder.io import IO


fn main() raises:
    var io = IO()
    var N = io.nextInt()
    var Q = io.nextInt()
    var A = io.nextListInt(N)
    var trie = BinaryTrie[30, True](12048576)
    for a in A:
        trie.add(a[])
    for _ in range(Q):
        var q = io.nextInt()
        var x = io.nextInt()
        if q == 0:
            if x not in trie:
                trie.add(x)
        elif q == 1:
            if x in trie:
                trie.remove(x)
        elif q == 2:
            if x <= len(trie):
                print(trie[x - 1])
            else:
                print(-1)
        elif q == 3:
            print(trie.bisect_right(x))
        elif q == 4:
            var j = trie.bisect_right(x) - 1
            if j == -1:
                print(-1)
            else:
                print(trie[j])
        elif q == 5:
            var j = trie.bisect_left(x)
            if j == len(trie):
                print(-1)
            else:
                print(trie[j])
