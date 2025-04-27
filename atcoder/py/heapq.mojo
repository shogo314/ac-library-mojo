from atcoder.method_traits import HasLtCollectionElement


fn heappush[S: HasLtCollectionElement](mut heap: List[S], item: S):
    var k = len(heap)
    heap.append(item)
    while k:
        var nk = (k - 1) >> 1
        if heap[k] < heap[nk]:
            heap.swap_elements(k, nk)
            k = nk
        else:
            break


fn heappop[S: HasLtCollectionElement](mut heap: List[S]) -> S:
    debug_assert(len(heap))
    if len(heap) == 1:
        return heap.pop()
    var res = heap[0]
    heap.swap_elements(0, len(heap) - 1)
    _ = heap.pop()
    _heapify(heap, 0)
    return res


fn heappushpop[S: HasLtCollectionElement](mut heap: List[S], item: S) -> S:
    if len(heap):
        if not heap[0] < item:
            return item
        else:
            var res = heap[0]
            heap[0] = item
            _heapify(heap, 0)
            return res
    else:
        return item


fn heapify[S: HasLtCollectionElement](mut heap: List[S]):
    for i in reversed(range(len(heap))):
        _heapify(heap, i)


fn heapreplace[
    S: HasLtCollectionElement
](mut heap: List[S], item: S) -> S:
    debug_assert(len(heap))
    var res = heap[0]
    heap[0] = item
    _heapify(heap, 0)
    return res


fn _heapify[S: HasLtCollectionElement](mut heap: List[S], k: Int):
    if len(heap) <= 2 * k + 1:
        pass
    else:
        var nk = 2 * k + 1
        if 2 * k + 2 < len(heap) and heap[2 * k + 2] < heap[2 * k + 1]:
            nk = 2 * k + 2
        if heap[nk] < heap[k]:
            heap.swap_elements(k, nk)
            _heapify(heap, nk)
