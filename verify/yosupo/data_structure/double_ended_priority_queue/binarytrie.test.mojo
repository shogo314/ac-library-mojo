# verification-helper: PROBLEM https://judge.yosupo.jp/problem/double_ended_priority_queue

from atcoder.io import IO
from atcoder.ext.data_structure.binarytrie import BinaryTrie


fn main() raises:
    var io = IO()
    var N = io.nextInt()
    var Q = io.nextInt()
    var S = io.nextListInt(N)
    var trie = BinaryTrie[]()
    for s in S:
        trie.add(s[] + 10**9)
    for _ in range(Q):
        var op = io.nextInt()
        if op == 0:
            var x = io.nextInt()
            trie.add(x + 10**9)
        elif op == 1:
            var ans = Int(trie[0])
            trie.remove(ans)
            print(ans - 10**9)
        else:
            var ans = Int(trie[len(trie) - 1])
            trie.remove(ans)
            print(ans - 10**9)
