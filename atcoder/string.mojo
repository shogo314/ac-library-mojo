from atcoder.method_traits import HasEqCollectionElement
from atcoder.py.string import string_to_list


fn z_algorithm[S: HasEqCollectionElement](s: List[S]) -> List[Int]:
    var n = len(s)
    if n == 0:
        return List[Int]()
    var z = List[Int](0) * n
    var j = 0
    for i in range(1, n):
        if j + z[j] <= i:
            z[i] = 0
        else:
            z[i] = min(j + z[j] - i, z[i - j])
        while i + z[i] < n and s[z[i]] == s[i + z[i]]:
            z[i] += 1
        if j + z[j] < i + z[i]:
            j = i
    z[0] = n
    return z


fn z_algorithm(s: String) -> List[Int]:
    return z_algorithm(string_to_list(s))


fn suffix_array(s: String) -> List[Int]:
    return _sa_is(string_to_list(s), 255)


fn _sa_is(s: List[Int], upper: Int) -> List[Int]:
    var n = len(s)
    if n == 0:
        return List[Int]()
    elif n == 1:
        return List[Int](0)
    elif n == 2:
        if s[0] < s[1]:
            return List[Int](0, 1)
        else:
            return List[Int](1, 0)
    var sa = List[Int]()
    sa.resize(n, 0)
    var ls = List[Bool]()
    ls.resize(n, False)
    for i in reversed(range(n - 1)):
        if s[i] == s[i + 1]:
            ls[i] = ls[i + 1]
        else:
            ls[i] = s[i] < s[i + 1]
    var sum_l = List[Int]()
    sum_l.resize(upper + 1, 0)
    var sum_s = List[Int]()
    sum_s.resize(upper + 1, 0)
    for i in range(n):
        if ls[i]:
            sum_l[s[i] + 1] += 1
        else:
            sum_s[s[i]] += 1
    for i in range(upper + 1):
        sum_s[i] += sum_l[i]
        if i < upper:
            sum_l[i + 1] += sum_s[i]

    var lms_map = List[Int]()
    lms_map.resize(n + 1, -1)
    var m = 0
    for i in range(1, n):
        if ls[i] and not ls[i - 1]:
            lms_map[i] = m
            m += 1
    var lms = List[Int](capacity=m)
    for i in range(1, n):
        if ls[i] and not ls[i - 1]:
            lms.append(i)

    @parameter
    if True:
        sa.clear()
        sa.resize(n, -1)
        var buf = List[Int]()
        buf.resize(upper + 1, 0)
        for i in range(upper + 1):
            buf[i] = sum_s[i]
        for d in lms:
            if d[] == n:
                continue
            sa[buf[s[d[]]]] = d[]
            buf[s[d[]]] += 1
        for i in range(upper + 1):
            buf[i] = sum_l[i]
        sa[buf[s[n - 1]]] = n - 1
        buf[s[n - 1]] += 1
        for i in range(n):
            var v = sa[i]
            if v >= 1 and not ls[v - 1]:
                sa[buf[s[v - 1]]] = v - 1
                buf[s[v - 1]] += 1
        for i in range(upper + 1):
            buf[i] = sum_l[i]
        for i in reversed(range(n)):
            var v = sa[i]
            if v >= 1 and ls[v - 1]:
                buf[s[v - 1] + 1] -= 1
                sa[buf[s[v - 1] + 1]] = v - 1
    if m == 0:
        return sa

    var sorted_lms = List[Int](capacity=m)
    for v in sa:
        if lms_map[v[]] != -1:
            sorted_lms.append(v[])
    var rec_s = List[Int]()
    rec_s.resize(m, 0)
    var rec_upper = 0
    rec_s[lms_map[sorted_lms[0]]] = 0
    for i in range(1, m):
        var l = sorted_lms[i - 1]
        var r = sorted_lms[i]
        var end_l: Int
        if lms_map[l] + 1 < m:
            end_l = lms[lms_map[l] + 1]
        else:
            end_l = n
        var end_r: Int
        if lms_map[r] + 1 < m:
            end_r = lms[lms_map[r] + 1]
        else:
            end_r = n
        var same = True
        if end_l - l != end_r - r:
            same = False
        else:
            while l < end_l and s[l] == s[r]:
                l += 1
                r += 1
            if l == n or s[l] != s[r]:
                same = False
        if not same:
            rec_upper += 1
        rec_s[lms_map[sorted_lms[i]]] = rec_upper
    var rec_sa = _sa_is(rec_s, rec_upper)
    for i in range(m):
        sorted_lms[i] = lms[rec_sa[i]]

    @parameter
    if True:
        sa.clear()
        sa.resize(n, -1)
        var buf = List[Int]()
        buf.resize(upper + 1, 0)
        for i in range(upper + 1):
            buf[i] = sum_s[i]
        for d in sorted_lms:
            if d[] == n:
                continue
            sa[buf[s[d[]]]] = d[]
            buf[s[d[]]] += 1
        for i in range(upper + 1):
            buf[i] = sum_l[i]
        sa[buf[s[n - 1]]] = n - 1
        buf[s[n - 1]] += 1
        for i in range(n):
            var v = sa[i]
            if v >= 1 and not ls[v - 1]:
                sa[buf[s[v - 1]]] = v - 1
                buf[s[v - 1]] += 1
        for i in range(upper + 1):
            buf[i] = sum_l[i]
        for i in reversed(range(n)):
            var v = sa[i]
            if v >= 1 and ls[v - 1]:
                buf[s[v - 1] + 1] -= 1
                sa[buf[s[v - 1] + 1]] = v - 1
    return sa


fn lcp_array(s: String, sa: List[Int]) -> List[Int]:
    return lcp_array(string_to_list(s), sa)


fn lcp_array[C: HasEqCollectionElement](s: List[C], sa: List[Int]) -> List[Int]:
    debug_assert(len(s) == len(sa))
    var n = len(s)
    debug_assert(n >= 1)
    var rnk = List[Int]()
    rnk.resize(n, 0)
    for i in range(n):
        debug_assert(0 <= sa[i] < n)
        rnk[sa[i]] = i
    var lcp = List[Int]()
    lcp.resize(n - 1, 0)
    var h = 0
    for i in range(n):
        if h:
            h -= 1
        if rnk[i] == 0:
            continue
        var j = sa[rnk[i] - 1]
        while j + h < n and i + h < n and s[j + h] == s[i + h]:
            h += 1
        lcp[rnk[i] - 1] = h
    return lcp
