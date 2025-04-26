[モジュール](../../index.md) > [ext](../index.md) > [dualsegtree](./index.md) > [DualSegTree]()

# DualSegTree

```
struct DualSegTree[S: CollectionElement, F: CollectionElement]
```

## Methods

### `__init__`

```
__init__(out self, n: Int, e: S, mapping: fn (F, S) -> S, composition: fn (F, F) -> F, id: F)
__init__(out self, v: List[S], mapping: fn (F, S) -> S, composition: fn (F, F) -> F, id: F)
```

### `set`

```
set(mut self, p: Int, x: S) raises
```

### `get`

```
get(mut self, p: Int) raises -> S
```

### `apply`

```
apply(mut self, p: Int, f: F) raises
apply(mut self, l: Int, r: Int, f: F) raises
```

### `all_apply`

```
all_apply(mut self, k: Int, f: F)
```

### `push`

```
push(mut self, k: Int)
```
