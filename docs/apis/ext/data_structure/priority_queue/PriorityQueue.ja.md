[APIs](../../../index.md) > [ext](../../index.md) > [data_structure](../index.md) > [priority_queue](./index.md) > [PriorityQueue.md]()

# PriorityQueue

```
struct PriorityQueue[S: CollectionElement]
```

## Methods

### `__init__`

```
__init__(out self, comp: fn (S, S) -> Bool)
__init__(out self, data: List[S], comp: fn (S, S) -> Bool)
```

### `top`

```
top(self) -> S
```

### `push`

```
push(mut self, item: S)
```

### `pop`

```
pop(mut self) -> S
```

### `clear`

```
clear(mut self)
```

### `__bool__`

```
__bool__(self) -> Bool
```

### `__len__`

```
__len__(self) -> Int
```
