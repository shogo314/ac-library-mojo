from atcoder.string import string_to_list


fn levenshtein_distance[
    C: EqualityComparable & Copyable & Movable
](s1: List[C], s2: List[C]) -> Int:
    var dp = List[List[Int]](
        length=len(s1) + 1, fill=List[Int](length=len(s2) + 1, fill=0)
    )
    for i in range(len(s1)):
        dp[i + 1][0] = i + 1
    for j in range(len(s2)):
        dp[0][j + 1] = j + 1
    for i in range(len(s1)):
        for j in range(len(s2)):
            dp[i + 1][j + 1] = min(
                dp[i][j + 1] + 1,
                dp[i + 1][j] + 1,
                dp[i][j] + (s1[i] != s2[j]),
            )
    return dp[-1][-1]


fn levenshtein_distance(s1: String, s2: String) -> Int:
    return levenshtein_distance(string_to_list(s1), string_to_list(s2))


fn edit_distance[
    C: EqualityComparable & Copyable & Movable
](s1: List[C], s2: List[C]) -> Int:
    return levenshtein_distance(s1, s2)


fn edit_distance(s1: String, s2: String) -> Int:
    return levenshtein_distance(s1, s2)
