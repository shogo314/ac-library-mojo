# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/problems/ITP2_2_D

from collections import LinkedList
from atcoder.io import IO


fn main() raises:
    var io = IO()
    var N = io.nextInt()
    var Q = io.nextInt()
    var l = List(length=(N), fill=LinkedList[Int]())
    for _ in range(Q):
        var p = io.nextInt()
        if p == 0:
            var t = io.nextInt()
            var x = io.nextInt()
            l[t].append(x)
        elif p == 1:
            var t = io.nextInt()
            var tmp = List[Int](capacity=len(l[t]))
            for i in l[t]:
                tmp.append(i[])
            IO.print(tmp)
        else:
            var s = io.nextInt()
            var t = io.nextInt()
            var tmp = LinkedList[Int]()
            swap(l[s],tmp)
            l[t].extend(tmp^)
