[モジュール](../index.md) > [fenwicktree](./index.md) > [FenwickTree]()

# FenwickTree

```
struct FenwickTree[T: AddGroup]
```

## Methods

### `__init__`

```
__init__(out self, n: Int)
__init__(out self, v: List[T])
```

### `add`

```
add(mut self, p: Int, x: T) raises
```

### `sum`

```
sum(self, left: Int, right: Int) raises -> T
```
