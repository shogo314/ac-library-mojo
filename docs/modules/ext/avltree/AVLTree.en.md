[Modules](../../index.md) > [ext](../index.md) > [avltree](./index.md) > [AVLTree]()

# AVLTree

```
struct AVLTree[T: HasLtCollectionElement]
```

## Methods

### `__init__`

```
__init__(out self)
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
bisect_left(self, v: T) -> Int
```

### `bisect_right`

```
bisect_right(self, v: T) -> Int
```

### `__getitem__`

```
__getitem__(self, i: Int) raises -> T
```

### `__contains__`

```
__contains__(self, v: T) raises -> Bool
```

### `add`

```
add(mut self, v: T) raises
```

### `remove`

```
remove(mut self, v: T) raises
```

### `discard`

```
discard(mut self, v: T) raises
```
