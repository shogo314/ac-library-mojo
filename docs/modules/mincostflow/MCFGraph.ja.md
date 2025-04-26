[モジュール](../index.md) > [mincostflow](./index.md) > [MCFGraph]()

# MCFGraph

```
struct MCFGraph
```

## Methods

### `__init__`

```
__init__(out self, n: Int)
```

### `add_edge`

```
add_edge(mut self, src: Int, dst: Int, cap: Cap, cost: Cost) raises -> Int
```

### `get_edge`

```
get_edge(self, i: Int) raises -> Edge
```

### `edges`

```
edges(self) -> List[Edge]
```

### `flow`

```
flow(mut self, s: Int, t: Int, flow_limit: Cap) raises -> (Cap, Cost)
```

### `slope`

```
slope(mut self, s: Int, t: Int, flow_limit: Cap) raises -> List[(Cap, Cost)]
```
