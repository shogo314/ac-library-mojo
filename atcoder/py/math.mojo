from sys import bitwidthof


fn isqrt(x: Int) -> Int:
    if x < 0:
        return 0

    var r = UInt(0)
    var r2 = UInt(0)

    for p in range(bitwidthof[UInt]() // 2, -1, -1):
        var tr2 = r2 + (r << (p + 1)) + (1 << (p + p))
        if tr2 <= UInt(x):
            r2 = tr2
            r |= 1 << p

    return r
