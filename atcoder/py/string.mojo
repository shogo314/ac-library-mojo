fn string_to_list(s: String) -> List[Int]:
    var res = List[Int](capacity=len(s))
    for i in range(len(s)):
        res.append(ord(s[i]))
    return res
