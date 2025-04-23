from atcoder.method_traits import HasLtCollectionElement


fn bisect_left[T: HasLtCollectionElement](a: List[T], x: T) -> Int:
    var lo = -1
    var hi = len(a)
    while lo + 1 < hi:
        var mid = lo + (hi - lo) // 2
        if a[mid] < x:
            lo = mid
        else:
            hi = mid
    return hi
