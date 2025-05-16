from memory import UnsafePointer
from os import abort


@value
struct AVLTreeNode[ElementType: LessThanComparable & Copyable & Movable]:
    alias _NodePointer = UnsafePointer[Self]
    var key: ElementType
    var par: Self._NodePointer
    var left: Self._NodePointer
    var right: Self._NodePointer
    var level: Int32
    var size: Int32

    fn __init__(out self, owned key: ElementType):
        self.key = key
        self.par = Self._NodePointer()
        self.left = Self._NodePointer()
        self.right = Self._NodePointer()
        self.level = 0
        self.size = 1


@value
struct AVLTree[ElementType: LessThanComparable & Copyable & Movable]:
    alias _Node = AVLTreeNode[ElementType]
    alias _NodePointer = UnsafePointer[Self._Node]
    var _root: Self._NodePointer

    fn __init__(out self):
        self._root = Self._NodePointer()

    @always_inline
    fn __bool__(self) -> Bool:
        return Bool(self._root)

    @always_inline
    fn __len__(self) -> Int:
        return Int(self._size(self._root))

    @staticmethod
    @always_inline
    fn _make_node(owned key: ElementType) -> Self._NodePointer:
        var node = Self._Node(key^)
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

    fn clear(mut self):
        if self._root:
            Self._destruct(self._root)
            self._root.free()
            self._root = Self._NodePointer()

    fn bisect_left(self, key: ElementType) -> Int:
        var k = Int32(0)
        var p = self._root
        while p:
            if p[].key < key:
                k += self._size(p[].left) + 1
                p = p[].right
            else:
                p = p[].left
        return Int(k)

    fn bisect_right(self, key: ElementType) -> Int:
        var k = Int32(0)
        var p = self._root
        while p:
            if key < p[].key:
                p = p[].left
            else:
                k += self._size(p[].left) + 1
                p = p[].right
        return Int(k)

    fn __getitem__(self, idx: Int) -> ElementType:
        debug_assert(-len(self) <= idx < len(self))
        var i = idx
        if i < 0:
            i += len(self)
        var k = Int32(i)
        var p = self._root
        while True:
            if k < self._size(p[].left):
                p = p[].left
            elif self._size(p[].left) < k:
                k -= self._size(p[].left) + Int32(1)
                p = p[].right
            else:
                return p[].key

    @always_inline
    fn __contains__(self, key: ElementType) -> Bool:
        return Bool(self._find(key))

    fn add(mut self, owned key: ElementType):
        if not self._root:
            self._root = Self._make_node(key^)
            return
        var p = self._root
        while True:
            if p[].key < key:
                if p[].right:
                    p = p[].right
                else:
                    var addr = Self._make_node(key^)
                    addr[].par = p
                    p[].right = addr
                    break
            elif key < p[].key:
                if p[].left:
                    p = p[].left
                else:
                    var addr = Self._make_node(key^)
                    addr[].par = p
                    p[].left = addr
                    break
            else:
                return
        self._balance(p)

    fn discard(mut self, key: ElementType):
        var p = self._find(key)
        if p:
            self._remove(p)

    fn _balance(mut self, owned p: Self._NodePointer):
        while p:
            self._update(p)
            var par = p[].par
            if self._level(p[].left) == self._level(p[].right) + 2:
                if self._level(p[].left[].left) + 1 == self._level(
                    p[].left[].right
                ):
                    p[].left = self._rotate_left(p[].left)
                debug_assert(
                    self._level(p[].left[].left)
                    <= self._level(p[].left[].right) + 2
                )
                if par:
                    if par[].key < p[].key:
                        par[].right = p = self._rotate_right(p)
                    elif p[].key < par[].key:
                        par[].left = p = self._rotate_right(p)
                    else:
                        debug_assert(False)
                else:
                    self._root = self._rotate_right(p)
            elif self._level(p[].left) + 2 == self._level(p[].right):
                if (
                    self._level(p[].right[].left)
                    == self._level(p[].right[].right) + 1
                ):
                    p[].right = self._rotate_right(p[].right)
                debug_assert(
                    self._level(p[].right[].left) + 2
                    >= self._level(p[].right[].right)
                )
                if par:
                    if par[].key < p[].key:
                        par[].right = p = self._rotate_left(p)
                    elif p[].key < par[].key:
                        par[].left = p = self._rotate_left(p)
                    else:
                        debug_assert(False)
                else:
                    self._root = self._rotate_left(p)
            debug_assert(
                abs(self._level(p[].left) - self._level(p[].right)) <= Int32(1)
            )
            p = par

    fn _rotate_left(mut self, owned p: Self._NodePointer) -> Self._NodePointer:
        debug_assert(Bool(p))
        debug_assert(Bool(p[].right))
        var right = p[].right
        var root = p[].par
        p[].par = right
        p[].right = right[].left
        right[].par = root
        if right[].left:
            right[].left[].par = p
        right[].left = p
        self._update(p)
        self._update(right)
        return right

    fn _rotate_right(mut self, owned p: Self._NodePointer) -> Self._NodePointer:
        debug_assert(Bool(p))
        debug_assert(Bool(p[].left))
        var left = p[].left
        var root = p[].par
        p[].par = left
        p[].left = left[].right
        left[].par = root
        if left[].right:
            left[].right[].par = p
        left[].right = p
        self._update(p)
        self._update(left)
        return left

    fn _find(self, key: ElementType) -> Self._NodePointer:
        var p = self._root
        while p:
            if key < p[].key:
                p = p[].left
            elif p[].key < key:
                p = p[].right
            else:
                break
        return p

    fn _remove(mut self, owned p: Self._NodePointer):
        debug_assert(Bool(p))
        var par = p[].par
        if p[].left and p[].right:
            var r = p[].left
            debug_assert(Bool(r))
            while r[].right:
                r = r[].right
            debug_assert(Bool(r))
            var key = r[].key
            self._remove(r)
            p[].key = key
        elif p[].left or p[].right:
            var q: Self._NodePointer
            if p[].left:
                q = p[].left
            else:
                q = p[].right
            q[].par = par
            if par:
                if p[].key < par[].key:
                    par[].left = q
                elif par[].key < p[].key:
                    par[].right = q
                else:
                    debug_assert(False)
            else:
                self._root = q
            p.free()
            self._balance(q)
        else:
            if par:
                if p[].key < par[].key:
                    par[].left = Self._NodePointer()
                elif par[].key < p[].key:
                    par[].right = Self._NodePointer()
                else:
                    debug_assert(False)
                p.free()
                self._balance(par)
            else:
                p.free()
                self._root = Self._NodePointer()

    @always_inline
    fn _level(self, p: Self._NodePointer) -> Int32:
        if p:
            return p[].level
        else:
            return -1

    @always_inline
    fn _size(self, p: Self._NodePointer) -> Int32:
        if p:
            return p[].size
        else:
            return 0

    @always_inline
    fn _update(mut self, p: Self._NodePointer):
        debug_assert(Bool(p))
        var left = p[].left
        var right = p[].right
        p[].level = max(self._level(left), self._level(right)) + Int32(1)
        p[].size = Int32(1) + self._size(left) + self._size(right)
