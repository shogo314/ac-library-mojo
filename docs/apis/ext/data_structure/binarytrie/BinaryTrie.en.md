[APIs](../../../index.md) > [ext](../../index.md) > [data_structure](../index.md) > [binarytrie](./index.md) > [BinaryTrie]()

# BinaryTrie

```
struct BinaryTrie[D: Int = 64, PreAllocate: Bool = False]
```

## Methods

### `__init__`

```
__init__(out self)
__init__(out self, allocate_size: Int)
```

### `__len__`

```
__len__(self) -> Int
```

### `__bool__`

```
__bool__(self) -> Bool
```

### `clear`

```
clear(mut self)
```

### `__getitem__`

```
__getitem__(self, idx: Int) -> UInt
```

### `count`

```
count(self, x: UInt) -> Int
```

### `__contains__`

```
__contains__(self, x: UInt) -> Bool
```

### `add`

```
add(mut self, x: UInt, cnt: Int = 1)
```

### `remove`

```
remove(mut self, x: UInt, cnt: Int = 1)
```

### `bisect_left`

```
bisect_left(self, x: UInt) -> Int
```

### `bisect_right`

```
bisect_right(self, x: UInt) -> Int
```
