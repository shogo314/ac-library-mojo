fn prev_permutation[T: LessThanComparable & Copyable & Movable](mut v: List[T]):
    for i in reversed(range(len(v) - 1)):
        if v[i + 1] < v[i]:
            var j = len(v) - 1
            while not v[j] < v[i]:
                j -= 1
            v.swap_elements(i, j)
            for k in range(1, (len(v) - i + 1) // 2):
                v.swap_elements(i + k, len(v) - k)
            break
    else:
        v = List[T]()


fn next_permutation[T: LessThanComparable & Copyable & Movable](mut v: List[T]):
    for i in reversed(range(len(v) - 1)):
        if v[i] < v[i + 1]:
            var j = len(v) - 1
            while not v[i] < v[j]:
                j -= 1
            v.swap_elements(i, j)
            for k in range(1, (len(v) - i + 1) // 2):
                v.swap_elements(i + k, len(v) - k)
            break
    else:
        v = List[T]()
