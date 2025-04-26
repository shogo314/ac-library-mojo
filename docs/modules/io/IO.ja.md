[モジュール](../index.md) > [io](./index.md) > [IO]()

# IO

```
struct IO
```

コンストラクタ実行時に全ての入力を読み込みます。
つまりインタラクティブ問題に対応していません。

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
readline(mut self) raises -> String
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
