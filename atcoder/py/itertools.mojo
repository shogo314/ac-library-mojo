from builtin.range import _ZeroStartingRange, _SequentialRange, _StridedRange


@value
struct _PermutationIter[T: LessThanComparable & Copyable & Movable]:
    var _data: List[T]
    var _has_next: Bool

    fn __init__(out self, data: List[T]):
        self._data = data
        self._has_next = True

    fn __iter__(self) -> Self:
        return self

    fn __next__(mut self, out p: List[T]):
        p = self._data
        for i in reversed(range(len(self._data) - 1)):
            if self._data[i] < self._data[i + 1]:
                var j = len(self._data) - 1
                while not self._data[i] < self._data[j]:
                    j -= 1
                self._data.swap_elements(i, j)
                for k in range(1, (len(self._data) - i + 1) // 2):
                    self._data.swap_elements(i + k, len(self._data) - k)
                break
        else:
            self._has_next = False

    @always_inline
    fn __has_next__(self) -> Bool:
        return self._has_next


fn permutations[
    T: LessThanComparable & Copyable & Movable
](v: List[T]) -> _PermutationIter[T]:
    fn cmp(x: T, y: T) capturing -> Bool:
        return x < y

    var sorted_v = v
    sort[cmp_fn=cmp](sorted_v)
    return _PermutationIter(sorted_v)


fn permutations(v: _ZeroStartingRange) -> _PermutationIter[Int]:
    var sorted_v = List[Int](capacity=len(v))
    for i in v:
        sorted_v.append(i)
    return _PermutationIter(sorted_v)


fn permutations(v: _SequentialRange) -> _PermutationIter[Int]:
    var sorted_v = List[Int](capacity=len(v))
    for i in v:
        sorted_v.append(i)
    return _PermutationIter(sorted_v)


fn permutations(v: _StridedRange) -> _PermutationIter[Int]:
    var sorted_v = List[Int](capacity=len(v))
    if v.step < 0:
        for i in reversed(v):
            sorted_v.append(i)
    else:
        for i in v:
            sorted_v.append(i)
    return _PermutationIter(sorted_v)
