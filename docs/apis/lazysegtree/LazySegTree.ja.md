[APIs](../index.md) > [lazysegtree](./index.md) > [LazySegTree]()

# LazySegTree

```
struct LazySegTree[S: Copyable & Movable, F: Copyable & Movable]
```

## Methods

### `__init__`

```
__init__(out self, n: Int, op: fn (S, S) -> S, e: S, mapping: fn (F, S) -> S, composition: fn (F, F) -> F, id: F)
__init__(out self, v: List[S], op: fn (S, S) -> S, e: S, mapping: fn (F, S) -> S, composition: fn (F, F) -> F, id: F)
__init__(out self, n: Int, op: fn (S, S) -> S, e: S, mapping: fn (F, S, Int) -> S, composition: fn (F, F) -> F, id: F)
__init__(out self, v: List[S], op: fn (S, S) -> S, e: S, mapping: fn (F, S, Int) -> S, composition: fn (F, F) -> F, id: F)
__init__(out self, n: Int, op: fn (S, S) -> S, e: S, mapping: fn (F, S, Int, Int) -> S, composition: fn (F, F) -> F, id: F)
__init__(out self, v: List[S], op: fn (S, S) -> S, e: S, mapping: fn (F, S, Int, Int) -> S, composition: fn (F, F) -> F, id: F)
__init__(out self, n: Int, op: fn (S, S) -> S, e: S, mapping: fn (F, S, Int, Int) escaping -> S, composition: fn (F, F) -> F, id: F)
__init__(out self, v: List[S], op: fn (S, S) -> S, e: S, mapping: fn (F, S, Int, Int) escaping -> S, composition: fn (F, F) -> F, id: F)
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
get(mut self, p: Int) -> S
```

### `__getitem__`

```
__getitem__(mut self, idx: Int) -> S
```

### `prod`

```
prod(mut self, l: Int, r: Int) -> S
```

### `all_prod`

```
all_prod(self) -> S
```

### `apply`

```
apply(mut self, p: Int, f: F)
apply(mut self, l: Int, r: Int, f: F)
```

### `max_right`

```
max_right[F: fn (S) -> Bool](mut self, l: Int) -> Int
```

### `min_left`

```
min_left[F: fn (S) -> Bool](mut self, r: Int) -> Int
```
