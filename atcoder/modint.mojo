from testing import assert_true

from atcoder._math import _inv_gcd


struct StaticModint[M: Int](WritableCollectionElement):
    var _val: Int

    fn __init__(out self):
        self._val = 0

    fn __init__(out self, v: Int):
        self._val = v % M

    fn __init__(out self, v: UInt64):
        self._val = Int(v % UInt64(M))

    fn __init__(out self, v: String) raises:
        self._val = Int(v) % M

    fn __copyinit__(out self, o: Self):
        self._val = o._val

    fn __moveinit__(out self, owned o: Self):
        self._val = o._val

    fn val(self) -> Int:
        return self._val

    fn valu64(self) -> UInt64:
        return self._val

    fn __iadd__(mut self, rhs: Self):
        self._val += rhs._val
        if self._val >= M:
            self._val -= M

    fn __iadd__(mut self, rhs: Int):
        self += Self(rhs)

    fn __isub__(mut self, rhs: Self):
        self._val -= rhs._val
        if self._val < 0:
            self._val += M

    fn __isub__(mut self, rhs: Int):
        self -= Self(rhs)

    fn __imul__(mut self, rhs: Self):
        self._val *= rhs._val
        self._val %= M

    fn __imul__(mut self, rhs: Int):
        self *= Self(rhs)

    fn __itruediv__(mut self, rhs: Self) raises:
        self *= rhs.inv()

    fn __itruediv__(mut self, rhs: Int) raises:
        self /= Self(rhs)

    fn __pos__(self) -> Self:
        return self

    fn __neg__(self) -> Self:
        return Self() - self

    fn pow(self, n: Int) raises -> Self:
        assert_true(0 <= n)
        var x = self
        var r = Self(1)
        var t = n
        while t:
            if t & 1:
                r *= x
            x = x * x
            t >>= 1
        return r

    fn __pow__(self, n: Int) raises -> Self:
        return self.pow(n)

    fn inv(self) raises -> Self:
        eg = _inv_gcd(self._val, M)
        assert_true(eg[0] == 1)
        return Self(eg[1])

    fn __add__(self, o: Self) -> Self:
        var res = self
        res += o
        return res

    fn __add__(self, o: Int) -> Self:
        var res = self
        res += o
        return res

    fn __sub__(self, o: Self) -> Self:
        var res = self
        res -= o
        return res

    fn __sub__(self, o: Int) -> Self:
        var res = self
        res -= o
        return res

    fn __mul__(self, o: Self) -> Self:
        var res = self
        res *= o
        return res

    fn __mul__(self, o: Int) -> Self:
        var res = self
        res *= o
        return res

    fn __truediv__(self, o: Self) raises -> Self:
        var res = self
        res /= o
        return res

    fn __truediv__(self, o: Int) raises -> Self:
        var res = self
        res /= o
        return res

    fn __eq__(self, rhs: Self) -> Bool:
        return self._val == rhs._val

    fn __eq__(self, rhs: Int) -> Bool:
        return self == Self(rhs)

    fn __ne__(self, rhs: Self) -> Bool:
        return self._val != rhs._val

    fn __ne__(self, rhs: Int) -> Bool:
        return self != Self(rhs)

    fn write_to[W: Writer](self, mut writer: W):
        writer.write(self._val)

    fn __int__(self) -> Int:
        return self._val

    @staticmethod
    fn mod() -> Int:
        return M

    @staticmethod
    fn modu64() -> UInt64:
        return UInt64(M)


alias modint998244353 = StaticModint[998244353]
alias modint1000000007 = StaticModint[1000000007]
alias modint1000000009 = StaticModint[1000000009]
