[APIs](../../../index.md) > [ext](../../index.md) > [data_structure](../index.md) > [avltree](./index.md) > [AVLTree]()

# AVLTree

```
struct AVLTree[ElementType: LessThanComparable & Copyable & Movable, PreAllocate: Bool = False]
```

## Methods

### `__init__`

```
__init__(out self)
__init__(out self, allocate_size: Int)
```

### `__bool__`

```
__bool__(self) -> Bool
```

### `__len__`

```
__len__(self) -> Int
```

### `clear`

```
clear(mut self)
```

### `bisect_left`

```
bisect_left(self, key: ElementType) -> Int
```

### `bisect_right`

```
bisect_right(self, key: ElementType) -> Int
```

### `__getitem__`

```
__getitem__(self, idx: Int) -> ElementType
```

### `__contains__`

```
__contains__(self, key: ElementType) -> Bool
```

### `add`

```
add(mut self, owned key: ElementType)
```

### `discard`

```
discard(mut self, key: ElementType)
```
