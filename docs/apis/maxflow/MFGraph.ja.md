[APIs](../index.md) > [maxflow](./index.md) > [MFGraph.md]()

# MFGraph

```
struct MFGraph[Cap: Capable]
```

## Methods

### `__init__`

```
__init__(out self, n: Int)
```

### `add_edge`

```
add_edge(mut self, src: Int, dst: Int, cap: Cap) raises -> Int
```

### `get_edge`

```
get_edge(self, i: Int) raises -> Edge[Cap]
```

### `edges`

```
edges(self) raises -> List[Edge[Cap]]
```

### `change_edge`

```
change_edge(mut self, i: Int, new_cap: Cap, new_flow: Cap) raises
```

### `flow`

```
flow(mut self, s: Int, t: Int, flow_limit: Cap) raises -> Cap
```
