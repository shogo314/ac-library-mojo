[APIs](../../../index.md) > [ext](../../index.md) > [data_structure](../index.md) > [potentialized_unionfind](./index.md) > [PotentializedUnionFind.md]()

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
leader(mut self, a: Int) raises -> Int
```

### `merge`

```
merge(mut self, a: Int, b: Int, w: S) raises -> Int
```

### `same`

```
same(mut self, a: Int, b: Int) raises -> Bool
```

### `diff`

```
diff(mut self, a: Int, b: Int) raises -> S
```

### `size`

```
size(mut self, a: Int) raises -> Int
```

### `weight`

```
weight(mut self, a: Int) raises -> S
```
