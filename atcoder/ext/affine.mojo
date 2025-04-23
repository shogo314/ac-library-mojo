from atcoder.method_traits import HasAdd, HasMul


trait AffineElement(HasAdd, HasMul, CollectionElement):
    pass


@value
struct Affine[T: AffineElement]:
    var a: T
    var b: T

    fn assign(self, x: T) -> T:
        return self.a * x + self.b

    fn assign(self, o: Self) -> Self:
        return Self(self.a * o.a, self.a * o.b + self.b)
