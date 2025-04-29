[APIs](../index.md) > [mincostflow](./index.md) > [MCFGraph.md]()

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
add_edge(mut self, src: Int, dst: Int, cap: Cap, cost: Cost) -> Int
```

### `get_edge`

```
get_edge(self, i: Int) -> Edge
```

### `edges`

```
edges(self) -> List[Edge]
```

### `flow`

```
flow(mut self, s: Int, t: Int, flow_limit: Cap) -> (Cap, Cost)
```

### `slope`

```
slope(mut self, s: Int, t: Int, flow_limit: Cap) -> List[(Cap, Cost)]
```
