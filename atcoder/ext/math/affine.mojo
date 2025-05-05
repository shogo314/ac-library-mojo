from atcoder.method_traits import SemiRing


@value
struct Affine[T: SemiRing]:
    var a: T
    var b: T

    fn assign(self, x: T) -> T:
        return self.a * x + self.b

    fn assign(self, o: Self) -> Self:
        return Self(self.a * o.a, self.a * o.b + self.b)

    fn __call__(self, x: T) -> T:
        return self.assign(x)

    fn __call__(self, o: Self) -> Self:
        return self.assign(o)
