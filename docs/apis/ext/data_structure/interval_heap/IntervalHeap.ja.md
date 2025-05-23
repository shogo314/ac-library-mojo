[APIs](../../../index.md) > [ext](../../index.md) > [data_structure](../index.md) > [interval_heap](./index.md) > [IntervalHeap]()

# IntervalHeap

```
struct IntervalHeap[S: LessThanComparable & Copyable & Movable]
```

## Methods

### `__init__`

```
__init__(out self)
__init__(out self, data: List[S])
```

### `min`

```
min(self) -> S
```

### `max`

```
max(self) -> S
```

### `pop_min`

```
pop_min(mut self) -> S
```

### `pop_max`

```
pop_max(mut self) -> S
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
