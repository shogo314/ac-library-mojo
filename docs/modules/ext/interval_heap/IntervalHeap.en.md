[Modules](../../index.md) > [ext](../index.md) > [interval_heap](./index.md) > [IntervalHeap]()

# IntervalHeap

```
struct IntervalHeap[S: HasLtCollectionElement]
```

## Methods

### `__init__`

```
__init__(out self)
__init__(out self, data: List[S])
```

### `min`

```
min(self) raises -> S
```

### `max`

```
max(self) raises -> S
```

### `pop_min`

```
pop_min(mut self) raises -> S
```

### `pop_max`

```
pop_max(mut self) raises -> S
```

### `push`

```
push(mut self, item: S)
```

### `__bool__`

```
__bool__(self) -> Bool
```

### `__len__`

```
__len__(self) -> Int
```

### `parent`

```
parent(k: Int) -> Int
```
