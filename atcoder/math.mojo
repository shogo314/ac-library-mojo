from testing import assert_true

from atcoder._math import _inv_gcd
from atcoder.py.builtin import pow_mod


fn inv_mod(x: Int, m: Int) raises -> Int:
    assert_true(1 <= m)
    var z = atcoder._math._inv_gcd(x, m)
    assert_true(z[0] == 1)
    return z[1]


fn crt(r: List[Int], m: List[Int]) raises -> (Int, Int):
    assert_true(len(r) == len(m))
    var n = len(r)
    var r0 = 0
    var m0 = 1
    for i in range(n):
        assert_true(1 <= m[i])
        var r1 = r[i] % m[i]
        var m1 = m[i]
        if m0 < m1:
            r0, r1 = r1, r0
            m0, m1 = m1, m0
        if m0 % m1 == 0:
            if r0 % m1 != r1:
                return (0, 0)
            continue
        var tmp = _inv_gcd(m0, m1)
        var g = tmp[0]
        var im = tmp[1]
        var u1 = m1 // g
        if (r1 - r0) % g != 0:
            return (0, 0)
        var x = (r1 - r0) // g % u1 * im % u1
        r0 += x * m0
        m0 *= u1
    return (r0, m0)


fn floor_sum(n: Int, m: Int, a: Int, b: Int) raises -> Int:
    assert_true(1 <= n)
    assert_true(1 <= m)
    var x = a
    var y = b
    ans = 0
    if x >= m:
        ans += (n - 1) * n * (x // m) // 2
        x %= m
    if y >= m:
        ans += n * (y // m)
        y %= m
    y_max = (x * n + y) // m
    x_max = y_max * m - y
    if y_max == 0:
        return ans
    ans += (n - (x_max + x - 1) // x) * y_max
    ans += floor_sum(y_max, x, m, (x - x_max % x) % x)
    return ans
