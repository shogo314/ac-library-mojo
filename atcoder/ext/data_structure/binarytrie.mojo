from sys import bitwidthof


@value
struct BinaryTrieNodePointer:
    var p: Int32

    fn __init__(out self, x: Int):
        self.p = Int32(x)

    fn __init__(out self):
        self.p = Int32(-1)

    fn __bool__(self) -> Bool:
        return self.p != -1

    fn __eq__(self, o: Self) -> Bool:
        return self.p == o.p

    fn __ne__(self, o: Self) -> Bool:
        return self.p != o.p


@value
struct BinaryTrieNode:
    var left: BinaryTrieNodePointer
    var right: BinaryTrieNodePointer
    var size: Int

    fn __init__(out self):
        self.left = BinaryTrieNodePointer()
        self.right = BinaryTrieNodePointer()
        self.size = 0


@value
struct BinaryTrie[D: Int = 64]:
    alias P = BinaryTrieNodePointer
    var _data: List[BinaryTrieNode]
    var _root: Self.P

    fn _size(self, p: Self.P) -> Int:
        if p:
            return self._data[p.p].size
        else:
            return 0

    fn _update(mut self, p: Self.P):
        debug_assert(Bool(p))
        self._data[p.p].size = self._size(self._data[p.p].left) + self._size(
            self._data[p.p].right
        )

    fn __init__(out self):
        constrained[1 <= D <= 64]()
        constrained[bitwidthof[UInt]() == 64]()
        self._data = List[BinaryTrieNode]()
        self._data.append(BinaryTrieNode())
        self._root = Self.P(0)

    fn __len__(self) -> Int:
        return self._size(self._root)

    fn __bool__(self) -> Bool:
        return len(self)

    fn clear(mut self):
        self._data.clear()
        self._data.append(BinaryTrieNode())
        self._root = Self.P(0)

    fn __getitem__(self, idx: Int) -> UInt:
        debug_assert(0 <= idx < len(self))
        var k = idx
        var p = self._root
        var res = 0
        for i in reversed(range(D)):
            if k < self._size(self._data[p.p].left):
                p = self._data[p.p].left
            else:
                k -= self._size(self._data[p.p].left)
                p = self._data[p.p].right
                res |= UInt(1) << i
        return res

    fn count(self, x: UInt) -> Int:
        debug_assert(D == 64 or x < (UInt(1) << D))
        var p = self._root
        for i in reversed(range(D)):
            if (x >> i) & UInt(1):
                if not self._data[p.p].right:
                    return 0
                p = self._data[p.p].right
            else:
                if not self._data[p.p].left:
                    return 0
                p = self._data[p.p].left
        return self._size(p)

    fn __contains__(self, x: UInt) -> Bool:
        return Bool(self.count(x))

    fn add(mut self, x: UInt, cnt: Int = 1):
        debug_assert(D == 64 or x < (UInt(1) << D))
        var p = self._root
        var l = List[Self.P]()
        l.append(p)
        for i in reversed(range(D)):
            if (x >> i) & UInt(1):
                if not self._data[p.p].right:
                    self._data[p.p].right = Self.P(len(self._data))
                    self._data.append(BinaryTrieNode())
                p = self._data[p.p].right
            else:
                if not self._data[p.p].left:
                    self._data[p.p].left = Self.P(len(self._data))
                    self._data.append(BinaryTrieNode())
                p = self._data[p.p].left
            l.append(p)
        p = l.pop()
        self._data[p.p].size += cnt
        while l:
            p = l.pop()
            self._update(p)

    fn remove(mut self, x: UInt, cnt: Int = 1):
        debug_assert(cnt <= self.count(x))
        var p = self._root
        var l = List[Self.P]()
        l.append(p)
        for i in reversed(range(D)):
            if (x >> i) & UInt(1):
                if not self._data[p.p].right:
                    return
                p = self._data[p.p].right
            else:
                if not self._data[p.p].left:
                    return
                p = self._data[p.p].left
            l.append(p)
        p = l.pop()
        self._data[p.p].size -= cnt
        while l:
            p = l.pop()
            self._update(p)

    fn bisect_left(self, x: UInt) -> Int:
        var k = 0
        var p = self._root
        var l = List[Self.P]()
        l.append(p)
        for i in reversed(range(D)):
            if (x >> i) & UInt(1):
                k += self._size(self._data[p.p].left)
                if not self._data[p.p].right:
                    break
                p = self._data[p.p].right
            else:
                if not self._data[p.p].left:
                    break
                p = self._data[p.p].left
            l.append(p)
        return k

    fn bisect_right(self, x: UInt) -> Int:
        var k = 0
        var p = self._root
        var l = List[Self.P]()
        l.append(p)
        for i in reversed(range(D)):
            if (x >> i) & UInt(1):
                k += self._size(self._data[p.p].left)
                if not self._data[p.p].right:
                    break
                p = self._data[p.p].right
            else:
                if not self._data[p.p].left:
                    break
                p = self._data[p.p].left
            l.append(p)
        else:
            k += self._size(p)
        return k
