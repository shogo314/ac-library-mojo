fn knapsack(vw: List[(Int, Int)], weight_limit: Int) -> Int:
    var dp = List[Int](0) * (weight_limit + 1)
    for i in range(len(vw)):
        var v = vw[i][0]
        var w = vw[i][1]
        for j in range(w, weight_limit + 1):
            if dp[j] < dp[j - w] + v:
                dp[j] = dp[j - w] + v
    return dp[weight_limit]


fn knapsack_01(vw: List[(Int, Int)], weight_limit: Int) -> Int:
    var sum_value = 0
    for i in range(len(vw)):
        sum_value += vw[i][0]
    if 2 ** (len(vw) // 2 + 1) < min(sum_value, weight_limit) * len(vw):
        return knapsack_01_meet_in_the_middle(vw, weight_limit)
    elif sum_value < weight_limit:
        return knapsack_01_value(vw, weight_limit, sum_value)
    else:
        return knapsack_01_weight(vw, weight_limit)


@value
struct _ValueWeight:
    var value: Int
    var weight: Int

    fn __lt__(self, o: Self) -> Bool:
        return self.weight < o.weight

    fn __gt__(self, o: Self) -> Bool:
        return o < self

    fn __ge__(self, o: Self) -> Bool:
        return not self < o

    fn __le__(self, o: Self) -> Bool:
        return not o < self

    fn __eq__(self, o: Self) -> Bool:
        return self >= o and self <= o

    fn __ne__(self, o: Self) -> Bool:
        return not self == o


fn knapsack_01_meet_in_the_middle(
    vw: List[(Int, Int)], weight_limit: Int
) -> Int:
    var left = List[_ValueWeight]()
    var right = List[_ValueWeight]()
    var left_n = len(vw) // 2
    var right_n = len(vw) - left_n
    for i in range(1 << left_n):
        var v = 0
        var w = 0
        for j in range(left_n):
            if i >> j & 1:
                v += vw[j][0]
                w += vw[j][1]
        left.append(_ValueWeight(v, w))
    for i in range(1 << right_n):
        var v = 0
        var w = 0
        for j in range(right_n):
            if i >> j & 1:
                v += vw[left_n + j][0]
                w += vw[left_n + j][1]
        right.append(_ValueWeight(v, w))
    sort(left)
    sort(right)
    var stk = List[Int](0)
    for i in range(len(right)):
        stk.append(max(stk[-1], right[i].value))
    var res = 0
    for i in range(len(left)):
        if left[i].weight > weight_limit:
            break
        while left[i].weight + right[-1].weight > weight_limit:
            _ = right.pop()
            _ = stk.pop()
        res = max(res, left[i].value + stk[-1])
    return res


fn knapsack_01_weight(vw: List[(Int, Int)], weight_limit: Int) -> Int:
    var dp = List[Int](0) * (weight_limit + 1)
    for i in range(len(vw)):
        var v = vw[i][0]
        var w = vw[i][1]
        for j in reversed(range(w, weight_limit + 1)):
            if dp[j] < dp[j - w] + v:
                dp[j] = dp[j - w] + v
    return dp[weight_limit]


fn knapsack_01_value(
    vw: List[(Int, Int)], weight_limit: Int, sum_value: Int
) -> Int:
    var dp = List[Int](Int.MAX) * (sum_value + 1)
    dp[0] = 0
    for i in range(len(vw)):
        var v = vw[i][0]
        var w = vw[i][1]
        for j in reversed(range(v, sum_value + 1)):
            if Int.MAX - w < dp[j - v]:
                continue
            if dp[j] > dp[j - v] + w:
                dp[j] = dp[j - v] + w
    for i in reversed(range(sum_value + 1)):
        if dp[i] <= weight_limit:
            return i
    return 0
