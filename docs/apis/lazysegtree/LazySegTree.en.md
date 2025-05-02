[APIs](../index.md) > [lazysegtree](./index.md) > [LazySegTree.md]()

# LazySegTree

```
struct LazySegTree[S: CollectionElement, F: CollectionElement]
```

## Methods

### `__init__`

```
__init__(out self, n: Int, op: fn (S, S) -> S, e: S, mapping: fn (F, S) -> S, composition: fn (F, F) -> F, id: F)
__init__(out self, v: List[S], op: fn (S, S) -> S, e: S, mapping: fn (F, S) -> S, composition: fn (F, F) -> F, id: F)
__init__(out self, n: Int, op: fn (S, S) -> S, e: S, mapping: fn (F, S, Int) -> S, composition: fn (F, F) -> F, id: F)
__init__(out self, v: List[S], op: fn (S, S) -> S, e: S, mapping: fn (F, S, Int) -> S, composition: fn (F, F) -> F, id: F)
```

### `set`

```
set(mut self, p: Int, x: S)
```

### `get`

```
get(mut self, p: Int) -> S
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
