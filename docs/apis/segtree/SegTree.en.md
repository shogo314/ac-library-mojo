[APIs](../index.md) > [segtree](./index.md) > [SegTree]()

# SegTree

```
struct SegTree[S: Copyable & Movable]
```

## Methods

### `__init__`

```
__init__(out self, n: Int, op: fn (S, S) -> S, e: S)
__init__(out self, v: List[S], op: fn (S, S) -> S, e: S)
```

### `set`

```
set(mut self, p: Int, x: S)
```

### `__setitem__`

```
__setitem__(mut self, idx: Int, x: S)
```

### `get`

```
get(self, p: Int) -> S
```

### `__getitem__`

```
__getitem__(self, idx: Int) -> S
```

### `prod`

```
prod(self, l: Int, r: Int) -> S
```

### `all_prod`

```
all_prod(self) -> S
```

### `max_right`

```
max_right[F: fn (S) -> Bool](self, l: Int) -> Int
```

### `min_left`

```
min_left[F: fn (S) -> Bool](self, r: Int) -> Int
```
