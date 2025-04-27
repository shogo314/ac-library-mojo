from atcoder.method_traits import HasLtCollectionElement


@value
struct AVLTreeNodePointer:
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
struct AVLTreeNode[T: HasLtCollectionElement]:
    var key: T
    var idx: AVLTreeNodePointer
    var par: AVLTreeNodePointer
    var left: AVLTreeNodePointer
    var right: AVLTreeNodePointer
    var level: Int32
    var size: Int32

    fn __init__(out self, key: T):
        self.key = key
        self.idx = AVLTreeNodePointer()
        self.par = AVLTreeNodePointer()
        self.left = AVLTreeNodePointer()
        self.right = AVLTreeNodePointer()
        self.level = 0
        self.size = 1

    fn __init__(
        out self, key: T, idx: AVLTreeNodePointer, par: AVLTreeNodePointer
    ):
        self.key = key
        self.idx = idx
        self.par = par
        self.left = AVLTreeNodePointer()
        self.right = AVLTreeNodePointer()
        self.level = 0
        self.size = 1


struct AVLTree[T: HasLtCollectionElement, multi: Bool = False]:
    var _data: List[AVLTreeNode[T]]
    var _root: AVLTreeNodePointer

    fn __init__(out self):
        self._root = AVLTreeNodePointer()
        self._data = List[AVLTreeNode[T]]()

    fn __bool__(self) -> Bool:
        return Bool(self._root)

    fn __len__(self) -> Int:
        if self._root:
            return Int(self._data[self._root.p].size)
        else:
            return 0

    fn clear(mut self):
        self._root = AVLTreeNodePointer()
        self._data.clear()

    fn bisect_left(self, v: T) -> Int:
        var k = Int32(0)
        var p = self._root
        while p:
            var node = self._data[p.p]
            if node.key < v:
                k += 1
                if node.left:
                    k += self._data[node.left.p].size
                p = node.right
            else:
                p = node.left
        return Int(k)

    fn bisect_right(self, v: T) -> Int:
        var k = Int32(0)
        var p = self._root
        while p:
            var node = self._data[p.p]
            if v < node.key:
                p = node.left
            else:
                k += 1
                if node.left:
                    k += self._data[node.left.p].size
                p = node.right
        return Int(k)

    fn __getitem__(self, i: Int) -> T:
        debug_assert(0 <= i < len(self))
        var k = Int32(i)
        var p = self._root
        while True:
            var node = self._data[p.p]
            if k < self._size(node.left):
                p = node.left.copy()  # copyは消したら駄目
            elif self._size(node.left) < k:
                k -= self._size(node.left) + Int32(1)
                p = node.right.copy()  # copyは消したら駄目
            else:
                return node.key

    fn __contains__(self, v: T) -> Bool:
        return Bool(self._find(v))

    fn add(mut self, v: T):
        if not self._root:
            self._data.clear()
            var node = AVLTreeNode(
                v, AVLTreeNodePointer(0), AVLTreeNodePointer()
            )
            self._root = node.idx
            self._data.append(node)
            return
        var p = self._root.copy()
        var new_node: AVLTreeNode[T]
        while True:
            var node = self._data[p.p]
            if node.key < v:
                if node.right:
                    p = node.right.copy()
                else:
                    p = AVLTreeNodePointer(len(self._data))
                    self._data[node.idx.p].right = p.copy()
                    new_node = AVLTreeNode[T](v, p.copy(), node.idx.copy())
                    break
            elif v < node.key:
                if node.left:
                    p = node.left.copy()
                else:
                    p = AVLTreeNodePointer(len(self._data))
                    self._data[node.idx.p].left = p.copy()
                    new_node = AVLTreeNode[T](v, p.copy(), node.idx.copy())
                    break
            elif multi:
                if node.right:
                    p = node.right.copy()
                else:
                    p = AVLTreeNodePointer(len(self._data))
                    self._data[node.idx.p].right = p.copy()
                    new_node = AVLTreeNode[T](v, p.copy(), node.idx.copy())
                    break
            else:
                return
        self._data.append(new_node)
        self._balance(p)

    fn remove(mut self, v: T):
        var p = self._find(v)
        debug_assert(Bool(p))
        self._remove(p)

    fn discard(mut self, v: T):
        var p = self._find(v)
        if p:
            self._remove(p)

    fn _find(self, v: T) -> AVLTreeNodePointer:
        var p = self._root
        while p:
            var node = self._data[p.p]
            if v < node.key:
                p = node.left
            elif node.key < v:
                p = node.right
            else:
                return node.idx
        return AVLTreeNodePointer()

    fn _remove(mut self, q: AVLTreeNodePointer):
        debug_assert(Bool(q))
        var node = self._data[q.p].copy()
        var par = node.par.copy()
        var p = AVLTreeNodePointer()
        if node.left and node.right:
            var r = node.left
            debug_assert(Bool(r))
            while self._data[r.p].right:
                r = self._data[r.p].right
            debug_assert(Bool(r))
            self._remove(r)
            self._data[q.p].key = self._data[r.p].key
        elif node.left or node.right:
            self._data[q.p].par = AVLTreeNodePointer()
            self._data[q.p].left = AVLTreeNodePointer()
            self._data[q.p].right = AVLTreeNodePointer()
            if node.left:
                p = node.left
                self._data[p.p].par = node.par
            elif node.right:
                p = node.right
                self._data[p.p].par = node.par
            if par:
                if node.key < self._data[par.p].key:
                    self._data[par.p].left = p
                elif self._data[par.p].key < node.key:
                    self._data[par.p].right = p
                else:
                    debug_assert(False)
            else:
                self._root = p
            self._balance(p)
        else:
            self._data[q.p].par = AVLTreeNodePointer()
            if par:
                if node.key < self._data[par.p].key:
                    self._data[par.p].left = p
                elif self._data[par.p].key < node.key:
                    self._data[par.p].right = p
                else:
                    debug_assert(False)
                self._balance(par)
            else:
                self.clear()

    fn _balance(mut self, q: AVLTreeNodePointer):
        var p = q
        while p:
            self._update(p)
            var node = self._data[p.p].copy()
            var par = node.par
            if self._level(node.left) == self._level(node.right) + 2:
                if self._level(self._data[node.left.p].left) + 1 == self._level(
                    self._data[node.left.p].right
                ):
                    self._data[p.p].left = self._rotate_left(node.left)
                node = self._data[p.p].copy()
                debug_assert(
                    self._level(self._data[node.left.p].left)
                    <= self._level(self._data[node.left.p].right) + 2
                )
                if par:
                    if self._data[par.p].key < node.key:
                        p = self._rotate_right(p)
                        self._data[par.p].right = p.copy()
                    elif node.key < self._data[par.p].key:
                        p = self._rotate_right(p)
                        self._data[par.p].left = p.copy()
                    else:
                        debug_assert(False)
                else:
                    self._root = self._rotate_right(p)
                    break
                node = self._data[p.p].copy()
            elif self._level(node.left) + 2 == self._level(node.right):
                if (
                    self._level(self._data[node.right.p].left)
                    == self._level(self._data[node.right.p].right) + 1
                ):
                    self._data[p.p].right = self._rotate_right(node.right)
                node = self._data[p.p].copy()
                debug_assert(
                    self._level(self._data[node.right.p].left) + 2
                    >= self._level(self._data[node.right.p].right)
                )
                if par:
                    if self._data[par.p].key < node.key:
                        p = self._rotate_left(p)
                        self._data[par.p].right = p.copy()
                    elif node.key < self._data[par.p].key:
                        p = self._rotate_left(p)
                        self._data[par.p].left = p.copy()
                    else:
                        debug_assert(False)
                else:
                    self._root = self._rotate_left(p)
                    break
                node = self._data[p.p].copy()
            debug_assert(
                abs(self._level(node.left) - self._level(node.right))
                <= Int32(1)
            )
            p = self._data[p.p].par.copy()

    fn _rotate_right(mut self, p: AVLTreeNodePointer) -> AVLTreeNodePointer:
        debug_assert(Bool(p))
        debug_assert(Bool(self._data[p.p].left))
        var node = self._data[p.p].copy()
        var left = self._data[node.left.p].copy()
        var root = node.par.copy()
        self._data[node.idx.p].par = left.idx.copy()
        self._data[node.idx.p].left = left.right.copy()
        self._data[left.idx.p].par = root.copy()
        self._data[left.idx.p].right = node.idx.copy()
        if left.right:
            self._data[left.right.p].par = node.idx.copy()
        self._update(node.idx)
        self._update(left.idx)
        return left.idx.copy()

    fn _rotate_left(mut self, p: AVLTreeNodePointer) -> AVLTreeNodePointer:
        debug_assert(Bool(p))
        debug_assert(Bool(self._data[p.p].right))
        var node = self._data[p.p].copy()
        var right = self._data[node.right.p].copy()
        var root = node.par.copy()
        self._data[node.idx.p].par = right.idx.copy()
        self._data[node.idx.p].right = right.left.copy()
        self._data[right.idx.p].par = root.copy()
        self._data[right.idx.p].left = node.idx.copy()
        if right.left:
            self._data[right.left.p].par = node.idx.copy()
        self._update(node.idx)
        self._update(right.idx)
        return right.idx.copy()

    fn _update(mut self, p: AVLTreeNodePointer):
        debug_assert(Bool(p))
        var left = self._data[p.p].left
        var right = self._data[p.p].right
        self._data[p.p].level = max(
            self._level(left), self._level(right)
        ) + Int32(1)
        self._data[p.p].size = Int32(1) + self._size(left) + self._size(right)

    fn _level(self, p: AVLTreeNodePointer) -> Int32:
        if p:
            return self._data[p.p].level
        else:
            return -1

    fn _size(self, p: AVLTreeNodePointer) -> Int32:
        if p:
            return self._data[p.p].size
        else:
            return 0
