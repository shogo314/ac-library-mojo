from atcoder.method_traits import (
    HasInitInt,
    HasAdd,
    HasNeg,
    HasMul,
    HasTruediv,
    HasLt,
    Invable,
)


@always_inline
fn add[T: HasAdd](x: T, y: T) -> T:
    return x + y


@always_inline
fn neg[T: HasNeg](x: T) -> T:
    return -x


@always_inline
fn mul[T: HasMul](x: T, y: T) -> T:
    return x * y


@always_inline
fn truediv[T: HasTruediv](x: T, y: T) -> T:
    return x / y


@always_inline
fn lt[T: LessThanComparable](x: T, y: T) -> Bool:
    return x < y


@always_inline
fn gt[T: LessThanComparable](x: T, y: T) -> Bool:
    return y < x


@always_inline
fn min_[T: HasLt & CollectionElement](x: T, y: T) -> T:
    if y < x:
        return y
    else:
        return x


@always_inline
fn max_[T: HasLt & CollectionElement](x: T, y: T) -> T:
    if x < y:
        return y
    else:
        return x


@always_inline
fn inv[T: Invable](x: T) -> T:
    return T(1) / x
