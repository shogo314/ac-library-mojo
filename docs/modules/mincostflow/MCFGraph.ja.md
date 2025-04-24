[モジュール](../index.md) > [mincostflow](./index.md) > [MCFGraph]()

# MCFGraph

## Methods

### `__init__`

```
__init__(out self, n: Int)
```

### `add_edge`

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
