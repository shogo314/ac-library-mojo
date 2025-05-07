from bit import next_power_of_two, count_trailing_zeros

from atcoder._math import _primitive_root
from atcoder.modint import StaticModint


struct _FFTInfo[M: Int]:
    var root: List[StaticModint[M]]
    var iroot: List[StaticModint[M]]
    var rate2: List[StaticModint[M]]
    var irate2: List[StaticModint[M]]
    var rate3: List[StaticModint[M]]
    var irate3: List[StaticModint[M]]

    fn __init__(out self):
        alias mint = StaticModint[M]
        alias g = _primitive_root(M)
        alias rank2 = count_trailing_zeros(M - 1)

        self.root = List[mint]()
        self.root.resize(rank2 + 1, mint())
        self.iroot = List[mint]()
        self.iroot.resize(rank2 + 1, mint())
        self.rate2 = List[mint]()
        self.rate2.resize(max(0, rank2 - 1), mint())
        self.irate2 = List[mint]()
        self.irate2.resize(max(0, rank2 - 1), mint())
        self.rate3 = List[mint]()
        self.rate3.resize(max(0, rank2 - 2), mint())
        self.irate3 = List[mint]()
        self.irate3.resize(max(0, rank2 - 2), mint())

        self.root[rank2] = mint(g).pow((M - 1) >> rank2)
        self.iroot[rank2] = self.root[rank2].inv()
        for i in reversed(range(rank2)):
            self.root[i] = self.root[i + 1] * self.root[i + 1]
            self.iroot[i] = self.iroot[i + 1] * self.iroot[i + 1]

        var prod = mint(1)
        var iprod = mint(1)
        for i in range(rank2 - 1):
            self.rate2[i] = self.root[i + 2] * prod
            self.irate2[i] = self.iroot[i + 2] * iprod
            prod = prod * self.iroot[i + 2]
            iprod = iprod * self.root[i + 2]

        prod = mint(1)
        iprod = mint(1)
        for i in range(rank2 - 2):
            self.rate3[i] = self.root[i + 3] * prod
            self.irate3[i] = self.iroot[i + 3] * iprod
            prod = prod * self.iroot[i + 3]
            iprod = iprod * self.root[i + 3]


fn _butterfly[M: Int](mut a: List[StaticModint[M]]):
    alias mint = StaticModint[M]
    var n = len(a)
    var h = count_trailing_zeros(n)
    var info = _FFTInfo[M]()
    var ln = 0
    while ln < h:
        if h - ln == 1:
            var p = 1 << (h - ln - 1)
            var rot = mint(1)
            for s in range(1 << ln):
                var offset = s << (h - ln)
                for i in range(p):
                    var l = a[i + offset]
                    var r = a[i + offset + p] * rot
                    a[i + offset] = l + r
                    a[i + offset + p] = l - r
                if s + 1 != (1 << ln):
                    rot = rot * info.rate2[count_trailing_zeros(~UInt32(s))]
            ln += 1
        else:
            var p = 1 << (h - ln - 2)
            var rot = mint(1)
            var imag = info.root[2]
            for s in range(1 << ln):
                var rot2 = rot * rot
                var rot3 = rot2 * rot
                var offset = s << (h - ln)
                for i in range(p):
                    alias mod2 = UInt64(M) * UInt64(M)
                    var a0 = a[i + offset].valu64()
                    var a1 = a[i + offset + p].valu64() * rot.valu64()
                    var a2 = a[i + offset + 2 * p].valu64() * rot2.valu64()
                    var a3 = a[i + offset + 3 * p].valu64() * rot3.valu64()
                    var a1na3imag = mint(
                        a1 + mod2 - a3
                    ).valu64() * imag.valu64()
                    var na2 = mod2 - a2
                    a[i + offset] = mint(a0 + a2 + a1 + a3)
                    a[i + offset + 1 * p] = mint(
                        a0 + a2 + (2 * mod2 - (a1 + a3))
                    )
                    a[i + offset + 2 * p] = mint(a0 + na2 + a1na3imag)
                    a[i + offset + 3 * p] = mint(a0 + na2 + (mod2 - a1na3imag))
                if s + 1 != (1 << ln):
                    rot = rot * info.rate3[count_trailing_zeros(~UInt32(s))]
            ln += 2


fn _butterfly_inv[M: Int](mut a: List[StaticModint[M]]):
    alias mint = StaticModint[M]
    var n = len(a)
    var h = count_trailing_zeros(n)
    var info = _FFTInfo[M]()
    var ln = h
    while ln:
        if ln == 1:
            var p = 1 << (h - ln)
            var irot = mint(1)
            for s in range(1 << (ln - 1)):
                var offset = s << (h - ln + 1)
                for i in range(p):
                    var l = a[i + offset]
                    var r = a[i + offset + p]
                    a[i + offset] = l + r
                    a[i + offset + p] = mint(
                        (UInt64(M) + l.valu64() - r.valu64()) * irot.valu64()
                    )
                if s + 1 != (1 << (ln - 1)):
                    irot = irot * info.irate2[count_trailing_zeros(~UInt32(s))]
            ln -= 1
        else:
            var p = 1 << (h - ln)
            var irot = mint(1)
            var iimag = info.iroot[2]
            for s in range(1 << (ln - 2)):
                var irot2 = irot * irot
                var irot3 = irot2 * irot
                var offset = s << (h - ln + 2)
                for i in range(p):
                    var a0 = a[i + offset + 0 * p].valu64()
                    var a1 = a[i + offset + 1 * p].valu64()
                    var a2 = a[i + offset + 2 * p].valu64()
                    var a3 = a[i + offset + 3 * p].valu64()
                    var a2na3iimag = mint(
                        (UInt64(M) + a2 - a3) * iimag.valu64()
                    ).valu64()

                    a[i + offset] = mint(a0 + a1 + a2 + a3)
                    a[i + offset + 1 * p] = mint(
                        (a0 + (UInt64(M) - a1) + a2na3iimag) * irot.valu64()
                    )
                    a[i + offset + 2 * p] = mint(
                        (a0 + a1 + (UInt64(M) - a2) + (UInt64(M) - a3))
                        * irot2.valu64()
                    )
                    a[i + offset + 3 * p] = mint(
                        (a0 + (UInt64(M) - a1) + (UInt64(M) - a2na3iimag))
                        * irot3.val()
                    )
                if s + 1 != (1 << (ln - 2)):
                    irot = irot * info.irate3[count_trailing_zeros(~UInt32(s))]
            ln -= 2


fn _convolution_fft[
    M: Int
](a_: List[StaticModint[M]], b_: List[StaticModint[M]]) -> List[
    StaticModint[M]
]:
    alias mint = StaticModint[M]
    var a = a_
    var b = b_
    var n = len(a)
    var m = len(b)
    var z = next_power_of_two(n + m - 1)
    a.resize(z, mint())
    _butterfly(a)
    b.resize(z, mint())
    _butterfly(b)
    for i in range(z):
        a[i] = a[i] * b[i]
    _butterfly_inv(a)
    a.resize(unsafe_uninit_length=n + m - 1)
    var iz = mint(z).inv()
    for i in range(n + m - 1):
        a[i] = a[i] * iz
    return a


fn convolution_mod[
    M: Int
](a: List[StaticModint[M]], b: List[StaticModint[M]]) -> List[StaticModint[M]]:
    var n = len(a)
    var m = len(b)
    if n == 0 or m == 0:
        return List[StaticModint[M]]()
    var z = next_power_of_two(n + m - 1)
    debug_assert((StaticModint[M].mod() - 1) % z == 0)
    return _convolution_fft(a, b)


fn convolution_int(a: List[Int], b: List[Int]) -> List[Int]:
    var n = len(a)
    var m = len(b)
    if n == 0 or m == 0:
        return List[Int]()

    alias MOD1 = UInt64(754974721)
    alias MOD2 = UInt64(167772161)
    alias MOD3 = UInt64(469762049)
    alias M2M3 = MOD2 * MOD3
    alias M1M3 = MOD1 * MOD3
    alias M1M2 = MOD1 * MOD2
    alias M1M2M3 = MOD1 * MOD2 * MOD3

    alias i1 = UInt64(190329765)
    alias i2 = UInt64(58587104)
    alias i3 = UInt64(187290749)

    alias MAX_AB_BIT = 24
    constrained[MOD1 % (UInt64(1) << MAX_AB_BIT) == 1]()
    constrained[MOD2 % (UInt64(1) << MAX_AB_BIT) == 1]()
    constrained[MOD3 % (UInt64(1) << MAX_AB_BIT) == 1]()
    debug_assert(n + m - 1 <= (1 << MAX_AB_BIT))

    var c1: List[StaticModint[754974721]]
    var c2: List[StaticModint[167772161]]
    var c3: List[StaticModint[469762049]]

    @parameter
    if True:
        alias mint = StaticModint[754974721]
        var am = List[mint]()
        for i in range(n):
            am.append(mint(a[i]))
        var bm = List[mint]()
        for i in range(m):
            bm.append(mint(b[i]))
        c1 = convolution_mod(am, bm)

    @parameter
    if True:
        alias mint = StaticModint[167772161]
        var am = List[mint]()
        for i in range(n):
            am.append(mint(a[i]))
        var bm = List[mint]()
        for i in range(m):
            bm.append(mint(b[i]))
        c2 = convolution_mod(am, bm)

    @parameter
    if True:
        alias mint = StaticModint[469762049]
        var am = List[mint]()
        for i in range(n):
            am.append(mint(a[i]))
        var bm = List[mint]()
        for i in range(m):
            bm.append(mint(b[i]))
        c3 = convolution_mod(am, bm)

    var c = List[Int](capacity=n + m - 1)
    for i in range(n + m - 1):
        var x = UInt64(0)
        x += (c1[i] * StaticModint[754974721](i1)).valu64() * M2M3
        x += (c2[i] * StaticModint[167772161](i2)).valu64() * M1M3
        x += (c3[i] * StaticModint[469762049](i3)).valu64() * M1M2
        var diff = (c1[i] - StaticModint[754974721](x)).val()
        alias offset = List[UInt64](0, 0, M1M2M3, 2 * M1M2M3, 3 * M1M2M3)
        x -= offset[diff % 5]
        c.append(Int(x))
    return c
