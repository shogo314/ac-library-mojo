trait HasAdd:
    fn __add__(self, x: Self) -> Self:
        pass


trait HasSub:
    fn __sub__(self, x: Self) -> Self:
        pass


trait HasNeg:
    fn __neg__(self) -> Self:
        pass


trait HasMul:
    fn __mul__(self, x: Self) -> Self:
        pass


trait HasTruediv:
    fn __truediv__(self, x: Self) -> Self:
        pass


trait Invable(HasInitInt, HasTruediv):
    pass


trait HasInitInt:
    fn __init__[T: Intable](out self, x: T):
        pass


trait HasInitStringRaising:
    fn __init__(out self, x: String) raises:
        pass


trait AddMonoid(Copyable & Movable, Defaultable, HasAdd):
    pass


trait MulMonoid(Copyable & Movable, HasInitInt, HasMul):
    pass


trait AddGroup(AddMonoid, HasNeg):
    pass


trait MulGroup(MulMonoid, Invable):
    pass


trait SemiRing(AddMonoid, MulMonoid):
    pass


trait Ring(AddGroup, MulMonoid):
    pass


trait Field(AddGroup, MulGroup):
    pass
