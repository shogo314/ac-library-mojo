[モジュール](../index.md) > [segtree](./index.md) > [SegTree]()

# SegTree

```
struct SegTree[S: CollectionElement]
```

## Methods

### `__init__`

```
__init__(out self, n: Int, op: fn (S, S) -> S, e: S)
__init__(out self, v: List[S], op: fn (S, S) -> S, e: S)
```

### `set`

```
set(mut self, p: Int, x: S) raises -> None
```

### `get`

```
get(mut self, p: Int) raises -> S
```

### `prod`

```
prod(self, l: Int, r: Int) raises -> S
```

### `all_prod`

```
all_prod(self) -> S
```
