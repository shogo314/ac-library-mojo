[APIs](../index.md) > [io](./index.md) > [IO]()

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
next[T: HasInitStringRaising & Copyable & Movable](mut self) raises -> T
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
nextList(mut self, n: Int) raises -> List[String]
nextList[T: HasInitStringRaising & Copyable & Movable](mut self, n: Int) raises -> List[T]
```

### `print`

```
print[S: Writable & Copyable & Movable](v: List[S])
```
