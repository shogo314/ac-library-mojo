from atcoder.py.builtin import pow_mod


fn _inv_gcd(a: Int, b: Int) -> (Int, Int):
    var s = b
    var t = a % b
    if t == 0:
        return (b, 0)
    var m0 = 0
    var m1 = 1
    while t:
        u = s // t
        s -= t * u
        m0 -= m1 * u
        s, t = t, s
        m0, m1 = m1, m0
    if m0 < 0:
        m0 += b // s
    return (s, m0)


fn _primitive_root(m: Int) -> Int:
    if m == 2:
        return 1
    if m == 167772161:
        return 3
    if m == 469762049:
        return 3
    if m == 754974721:
        return 11
    if m == 998244353:
        return 3

    var divs = List[Int](length=20, fill=0)
    divs[0] = 2
    var cnt = 1
    var x = (m - 1) // 2
    while x % 2 == 0:
        x //= 2

    var i = 3
    while i * i <= x:
        if x % i == 0:
            divs[cnt] = i
            cnt += 1
            while x % i == 0:
                x //= i
        i += 2

    if x > 1:
        divs[cnt] = x
        cnt += 1

    var g = 2
    while True:
        for i in range(cnt):
            if pow_mod(g, (m - 1) // divs[i], m) == 1:
                break
        else:
            return g
        g += 1
