from atcoder.method_traits import HasLt


fn bisect_left[T: HasLt & CollectionElement](a: List[T], x: T) -> Int:
    var lo = -1
    var hi = len(a)
    while lo + 1 < hi:
        var mid = lo + (hi - lo) // 2
        if a[mid] < x:
            lo = mid
        else:
            hi = mid
    return hi


fn bisect_right[T: HasLt & CollectionElement](a: List[T], x: T) -> Int:
    var lo = -1
    var hi = len(a)
    while lo + 1 < hi:
        var mid = lo + (hi - lo) // 2
        if x < a[mid]:
            hi = mid
        else:
            lo = mid
    return hi
