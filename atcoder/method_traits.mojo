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


trait HasLt:
    fn __lt__(self, x: Self) -> Bool:
        pass


trait HasEq:
    fn __eq__(self, x: Self) -> Bool:
        pass


trait HasInitInt:
    fn __init__(out self, x: Int):
        pass


trait HasInitUInt64:
    fn __init__(out self, x: UInt64):
        pass


trait HasInitStringRaising:
    fn __init__(out self, x: String) raises:
        pass


trait HasLtCollectionElement(CollectionElement, HasLt):
    pass


trait HasEqCollectionElement(CollectionElement, HasEq):
    pass


trait AddMonoid(CollectionElement, Defaultable, HasAdd):
    pass


trait MulMonoid(CollectionElement, HasInitInt, HasMul):
    pass


trait AddGroup(AddMonoid, HasNeg):
    pass
