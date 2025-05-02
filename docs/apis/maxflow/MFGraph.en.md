[APIs](../index.md) > [maxflow](./index.md) > [MFGraph]()

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
add_edge(mut self, src: Int, dst: Int, cap: Cap) -> Int
```

### `get_edge`

```
get_edge(self, i: Int) -> Edge[Cap]
```

### `edges`

```
edges(self) -> List[Edge[Cap]]
```

### `change_edge`

```
change_edge(mut self, i: Int, new_cap: Cap, new_flow: Cap)
```

### `flow`

```
flow(mut self, s: Int, t: Int, flow_limit: Cap) -> Cap
```
