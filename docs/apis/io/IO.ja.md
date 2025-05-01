[APIs](../index.md) > [io](./index.md) > [IO.md]()

# IO

```
struct IO[BUFF_SIZE: Int = 65536]
```

## Methods

### `__init__`

```
__init__(out self) raises
```

### `next`

```
next(mut self) raises -> String
```

### `readline`

```
readline(mut self) -> String
```

### `nextInt`

```
nextInt(mut self) raises -> Int
```

### `nextListInt`

```
nextListInt(mut self, n: Int) raises -> List[Int]
```

### `nextList`

```
nextList[T: HasInitStringRaisingCollectionElement](mut self, n: Int) raises -> List[T]
```

### `print`

```
print[S: WritableCollectionElement](v: List[S])
```
