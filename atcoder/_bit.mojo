fn bit_ceil(n: UInt32) -> UInt32:
    var x: UInt32 = 1
    while x < n:
        x *= 2
    return x


fn countr_zero(n: UInt32) -> Int:
    var x: Int = 0
    while n & (1 << x) == 0:
        x += 1
    return x
