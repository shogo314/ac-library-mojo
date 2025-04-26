from atcoder.py.builtin import pow_mod


fn _miller_rabin(n: Int, l: List[Int]) -> Bool:
    var s = 0
    var d = n - 1
    while d % 2 == 0:
        s += 1
        d //= 2
    for a in l:
        if n <= a[]:
            return True
        var x: Int
        try:
            x = Int(pow_mod(a[], d, n))
        except:
            return False
        if x != 1:
            for _ in range(s):
                if x == n - 1:
                    break
                x = Int(Int128(x) * Int128(x) % Int128(n))
            else:
                return False
    return True


fn isprime(n: Int) -> Bool:
    if n <= 1:
        return False
    if n == 2:
        return True
    if n % 2 == 0:
        return False
    if n < 4759123141:
        return _miller_rabin(n, List[Int](2, 7, 61))
    else:
        return _miller_rabin(
            n, List[Int](2, 325, 9375, 28178, 450775, 9780504, 1795265022)
        )
