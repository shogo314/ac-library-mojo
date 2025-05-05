[APIs](../index.md) > [modint](./index.md) > [StaticModint]()

# StaticModint

```
struct StaticModint[M: Int]
```

## Methods

### `__init__`

```
__init__(out self)
__init__[T: Intable](out self, v: T)
__init__(out self, v: UInt64)
__init__(out self, v: String) raises
```

### `val`

```
val(self) -> Int
```

### `valu64`

```
valu64(self) -> UInt64
```

### `__iadd__`

```
__iadd__(mut self, rhs: Self)
__iadd__(mut self, rhs: Int)
```

### `__isub__`

```
__isub__(mut self, rhs: Self)
__isub__(mut self, rhs: Int)
```

### `__imul__`

```
__imul__(mut self, rhs: Self)
__imul__(mut self, rhs: Int)
```

### `__itruediv__`

```
__itruediv__(mut self, rhs: Self)
__itruediv__(mut self, rhs: Int)
```

### `__pos__`

```
__pos__(self) -> Self
```

### `__neg__`

```
__neg__(self) -> Self
```

### `pow`

```
pow(self, n: Int) -> Self
```

### `__pow__`

```
__pow__(self, n: Int) -> Self
```

### `inv`

```
inv(self) -> Self
```

### `__add__`

```
__add__(self, o: Self) -> Self
__add__(self, o: Int) -> Self
```

### `__sub__`

```
__sub__(self, o: Self) -> Self
__sub__(self, o: Int) -> Self
```

### `__mul__`

```
__mul__(self, o: Self) -> Self
__mul__(self, o: Int) -> Self
```

### `__truediv__`

```
__truediv__(self, o: Self) -> Self
__truediv__(self, o: Int) -> Self
```

### `__eq__`

```
__eq__(self, rhs: Self) -> Bool
__eq__(self, rhs: Int) -> Bool
```

### `__ne__`

```
__ne__(self, rhs: Self) -> Bool
__ne__(self, rhs: Int) -> Bool
```

### `write_to`

```
write_to[W: Writer](self, mut writer: W)
```

### `__int__`

```
__int__(self) -> Int
```

### `mod`

```
mod() -> Int
```

### `modu64`

```
modu64() -> UInt64
```
