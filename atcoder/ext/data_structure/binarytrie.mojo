from sys import bitwidthof
from memory import UnsafePointer
from os import abort


@value
struct BinaryTrieNode:
    alias _NodePointer = UnsafePointer[Self]
    var left: Self._NodePointer
    var right: Self._NodePointer
    var size: Int

    fn __init__(out self):
        self.left = Self._NodePointer()
        self.right = Self._NodePointer()
        self.size = 0


@value
struct BinaryTrie[D: Int = 64]:
    alias _Node = BinaryTrieNode
    alias _NodePointer = UnsafePointer[Self._Node]
    var _root: Self._NodePointer

    @always_inline
    fn _size(self, p: Self._NodePointer) -> Int:
        if p:
            return p[].size
        else:
            return 0

    @always_inline
    fn _update(mut self, p: Self._NodePointer):
        debug_assert(Bool(p))
        p[].size = self._size(p[].left) + self._size(p[].right)

    @staticmethod
    @always_inline
    fn _make_node() -> Self._NodePointer:
        var node = Self._Node()
        var addr = Self._NodePointer.alloc(1)
        if not addr:
            abort("Out of memory")
        addr.init_pointee_move(node)
        return addr

    @staticmethod
    fn _destruct(p: Self._NodePointer):
        debug_assert(Bool(p))
        if p[].left:
            Self._destruct(p[].left)
            p[].left.free()
        if p[].right:
            Self._destruct(p[].right)
            p[].right.free()

    fn __init__(out self):
        constrained[1 <= D <= 64]()
        constrained[bitwidthof[UInt]() == 64]()
        self._root = Self._make_node()

    @always_inline
    fn __len__(self) -> Int:
        return self._size(self._root)

    @always_inline
    fn __bool__(self) -> Bool:
        return len(self)

    fn clear(mut self):
        if self._root:
            self._destruct(self._root)
            self._update(self._root)

    fn __getitem__(self, idx: Int) -> UInt:
        debug_assert(-len(self) <= idx < len(self))
        var k = idx
        if k < 0:
            k += len(self)
        var p = self._root
        var res = 0
        for i in reversed(range(D)):
            debug_assert(Bool(p))
            if k < self._size(p[].left):
                p = p[].left
            else:
                k -= self._size(p[].left)
                p = p[].right
                res |= UInt(1) << i
        return res

    fn count(self, x: UInt) -> Int:
        debug_assert(D == 64 or x < (UInt(1) << D))
        var p = self._root
        for i in reversed(range(D)):
            if (x >> i) & UInt(1):
                if not p[].right:
                    return 0
                p = p[].right
            else:
                if not p[].left:
                    return 0
                p = p[].left
        return self._size(p)

    @always_inline
    fn __contains__(self, x: UInt) -> Bool:
        return Bool(self.count(x))

    fn add(mut self, x: UInt, cnt: Int = 1):
        debug_assert(D == 64 or x < (UInt(1) << D))
        var p = self._root
        var l = List[Self._NodePointer](capacity=D + 1)
        l.append(p)
        for i in reversed(range(D)):
            if (x >> i) & UInt(1):
                if not p[].right:
                    p[].right = Self._make_node()
                p = p[].right
            else:
                if not p[].left:
                    p[].left = Self._make_node()
                p = p[].left
            l.append(p)
        p = l.pop()
        p[].size += cnt
        while l:
            p = l.pop()
            self._update(p)

    fn remove(mut self, x: UInt, cnt: Int = 1):
        debug_assert(cnt <= self.count(x))
        var p = self._root
        var l = List[Self._NodePointer](capacity=D + 1)
        l.append(p)
        for i in reversed(range(D)):
            if (x >> i) & UInt(1):
                if not p[].right:
                    return
                p = p[].right
            else:
                if not p[].left:
                    return
                p = p[].left
            l.append(p)
        p = l.pop()
        p[].size -= cnt
        while l:
            p = l.pop()
            self._update(p)

    fn bisect_left(self, x: UInt) -> Int:
        var k = 0
        var p = self._root
        for i in reversed(range(D)):
            if (x >> i) & UInt(1):
                k += self._size(p[].left)
                if not p[].right:
                    break
                p = p[].right
            else:
                if not p[].left:
                    break
                p = p[].left
        return k

    fn bisect_right(self, x: UInt) -> Int:
        var k = 0
        var p = self._root
        for i in reversed(range(D)):
            if (x >> i) & UInt(1):
                k += self._size(p[].left)
                if not p[].right:
                    break
                p = p[].right
            else:
                if not p[].left:
                    break
                p = p[].left
        else:
            k += self._size(p)
        return k
