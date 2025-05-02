[APIs](../../../index.md) > [ext](../../index.md) > [data_structure](../index.md) > [potentialized_unionfind](./index.md) > [PotentializedUnionFind]()

# PotentializedUnionFind

```
struct PotentializedUnionFind[S: CollectionElement]
```

## Methods

### `__init__`

```
__init__(out self, n: Int, op: fn (S, S) -> S, e: S, inv: fn (S) -> S)
```

### `leader`

```
leader(mut self, a: Int) -> Int
```

### `merge`

```
merge(mut self, a: Int, b: Int, w: S) -> Int
```

### `same`

```
same(mut self, a: Int, b: Int) -> Bool
```

### `diff`

```
diff(mut self, a: Int, b: Int) -> S
```

### `size`

```
size(mut self, a: Int) -> Int
```

### `weight`

```
weight(mut self, a: Int) -> S
```
