from sys import bitwidthof
from bit import count_leading_zeros, count_trailing_zeros


@value
struct WordSizeTree[D: Int = 5]:
    alias B = 6
    alias W = 1 << Self.B
    var _data: List[UInt]
    var _wp: List[Int]
    var _wpa: List[Int]

    @staticmethod
    fn _test(x: UInt, i: Int) -> Bool:
        debug_assert(0 <= i < Self.W)
        return Bool(x & (UInt(1) << i))

    @staticmethod
    fn _flip(mut x: UInt, i: Int):
        debug_assert(0 <= i < Self.W)
        x ^= UInt(1) << i

    @staticmethod
    fn _set(mut x: UInt, i: Int, v: Bool = True):
        debug_assert(0 <= i < Self.W)
        if v:
            x |= UInt(1) << i
        else:
            Self._reset(x, i)

    @staticmethod
    fn _reset(mut x: UInt, i: Int):
        debug_assert(0 <= i < Self.W)
        if Self._test(x, i):
            Self._flip(x, i)

    @staticmethod
    fn _mulW(x: Int) -> Int:
        return x << Self.B

    @staticmethod
    fn _divW(x: Int) -> Int:
        return x >> Self.B

    @staticmethod
    fn _modW(x: Int) -> Int:
        return x & (Self.W - 1)

    @staticmethod
    fn _ge(x: UInt, i: Int) -> Int:
        debug_assert(0 <= i < Self.W)
        var tmp = x & ~((UInt(1) << i) - 1)
        if tmp:
            return count_trailing_zeros(tmp)
        else:
            return -1

    @staticmethod
    fn _le(x: UInt, i: Int) -> Int:
        debug_assert(0 <= i < Self.W)
        if i + 1 == Self.W:
            return 63 - count_leading_zeros(x)
        return 63 - count_leading_zeros(x & ((UInt(1) << (i + 1)) - 1))

    fn __init__(out self):
        constrained[1 <= D <= 5]()
        constrained[Self.W == bitwidthof[UInt]()]()

        self._wp = List[Int](capacity=(D + 1))
        self._wp.append(1)
        var t = 1

        @parameter
        for _ in range(D):
            t <<= self.B
            self._wp.append(t)

        self._wpa = List[Int](capacity=(D + 1))
        self._wpa.append(0)

        @parameter
        for i in range(D):
            self._wpa.append(self._wp[i] + self._wpa[i])
        self._data = List(length=self._wpa[D], fill=UInt(0))

    fn __contains__(self, x: Int) -> Bool:
        debug_assert(0 <= x < self._wp[D])
        return Self._test(
            self._data[self._wpa[D - 1] + Self._divW(x)], Self._modW(x)
        )

    fn add(mut self, x: Int):
        debug_assert(0 <= x < self._wp[D])
        var y = x

        @parameter
        for i in reversed(range(D)):
            Self._set(self._data[self._wpa[i] + Self._divW(y)], Self._modW(y))
            y = Self._divW(y)

    fn extract(mut self, x: Int):
        debug_assert(0 <= x < self._wp[D])
        if Self._test(
            self._data[self._wpa[D - 1] + Self._divW(x)], Self._modW(x)
        ):
            Self._flip(
                self._data[self._wpa[D - 1] + Self._divW(x)], Self._modW(x)
            )
            var y = Self._divW(x)

            @parameter
            for i in reversed(range(D - 1)):
                Self._set(
                    self._data[self._wpa[i] + Self._divW(y)],
                    Self._modW(y),
                    Bool(self._data[self._wpa[i + 1] + y]),
                )
                y = Self._divW(y)

    fn ge(self, x: Int) -> Int:
        if self._wp[D] <= x:
            return -1
        var y = x
        if y < 0:
            y = 0
        var i = D - 1
        while i >= 0:
            var d = Self._divW(y)
            var m = Self._modW(y)
            var j = Self._ge(self._data[self._wpa[i] + d], m)
            if j != -1:
                y = Self._mulW(d)
                y |= j
                break
            elif d + 1 == self._wp[i]:
                return -1
            else:
                y = d + 1
                i -= 1
        else:
            debug_assert(False)
        while i < D - 1:
            var j = Self._ge(self._data[self._wpa[i + 1] + y], 0)
            debug_assert(0 <= j < Self.W)
            y = Self._mulW(y) + j
            i += 1
        return y

    fn le(self, x: Int) -> Int:
        if x < 0:
            return -1
        var y = x
        if self._wp[D] <= y:
            y = self._wp[D] - 1
        var i = D - 1
        while i >= 0:
            var d = Self._divW(y)
            var m = Self._modW(y)
            var j = Self._le(self._data[self._wpa[i] + d], m)
            if j != -1:
                y = Self._mulW(d)
                y |= j
                break
            elif d == 0:
                return -1
            else:
                y = d - 1
                i -= 1
        else:
            debug_assert(False)
        while i < D - 1:
            var j = Self._le(self._data[self._wpa[i + 1] + y], Self.W - 1)
            debug_assert(0 <= j < Self.W)
            y = Self._mulW(y) + j
            i += 1
        return y
