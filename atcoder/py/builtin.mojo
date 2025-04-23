from testing import assert_true


fn _pow_mod_64(x: UInt64, n: UInt64, m: UInt64) -> UInt64:
    """
    Preconditions:
        - 0 <= n
        - 2 <= m < 2**32
    """
    var r = UInt64(1)
    var y = x % m
    var n_ = n
    while n_:
        if n_ & 1:
            r = r * y % m
        y = y * y % m
        n_ = n_ >> 1
    return r


fn _pow_mod_128(x: UInt128, n: UInt128, m: UInt128) -> UInt128:
    """
    Preconditions:
        - 0 <= n
        - 2 <= m < 2**64
    """
    var r = UInt128(1)
    var y = x % m
    var n_ = n
    while n_:
        if n_ & 1:
            r = r * y % m
        y = y * y % m
        n_ = n_ >> 1
    return r


fn pow_mod(x: Int, n: Int, m: Int) raises -> Int:
    assert_true(1 <= m)
    assert_true(0 <= n)
    if m == 1:
        return 0
    if m < (1 << 32):
        return Int(_pow_mod_64(x, n, m))
    else:
        return Int(_pow_mod_128(x, n, m))
