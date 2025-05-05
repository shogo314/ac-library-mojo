from atcoder.method_traits import SemiRing


@value
struct Affine[T: SemiRing]:
    var a: T
    var b: T

    fn __init__(out self):
        self.a = T(1)
        self.b = T()

    fn assign(self, x: T) -> T:
        return self.a * x + self.b

    fn assign(self, o: Self) -> Self:
        return Self(self.a * o.a, self.a * o.b + self.b)

    fn __call__(self, x: T) -> T:
        return self.assign(x)

    fn __call__(self, o: Self) -> Self:
        return self.assign(o)

    fn __add__(self, o: Self) -> Self:
        return Self(self.a + o.a, self.b + o.b)

    fn __add__(self, b: T) -> Self:
        return Self(self.a, self.b + b)

    fn __mul__(self, a: T) -> Self:
        return Self(self.a * a, self.b * a)
