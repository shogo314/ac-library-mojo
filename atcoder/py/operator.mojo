from atcoder.method_traits import (
    HasInitInt,
    HasAdd,
    HasNeg,
    HasMul,
    HasTruediv,
)


fn add[T: HasAdd](x: T, y: T) -> T:
    return x + y


fn neg[T: HasNeg](x: T) -> T:
    return -x


fn mul[T: HasMul](x: T, y: T) -> T:
    return x * y


fn truediv[T: HasTruediv](x: T, y: T) -> T:
    return x / y


fn lt[T: LessThanComparable](x: T, y: T) -> Bool:
    return x < y


fn gt[T: LessThanComparable](x: T, y: T) -> Bool:
    return y < x
