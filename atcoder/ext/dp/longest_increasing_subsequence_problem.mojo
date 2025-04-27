from atcoder.py.bisect import bisect_left


fn longest_increasing_subsequence(a: List[Int]) -> List[Int]:
    if len(a) == 0:
        return List[Int]()
    var dp = List[Int]()
    dp.resize(len(a), Int.MAX)
    var tmp = List[(Int, Int)](capacity=len(a))
    for i in range(len(a)):
        var j = bisect_left(dp, a[i])
        dp[j] = a[i]
        tmp.append((j, i))
    var ans = List[Int]()
    var m = -1
    for i in reversed(range(len(a))):
        if dp[i] < Int.MAX:
            m = i
            break
    while m >= 0:
        for i in reversed(range(len(tmp))):
            if tmp[i][0] == m:
                ans.append(tmp[i][1])
                m -= 1
    ans.reverse()
    return ans
