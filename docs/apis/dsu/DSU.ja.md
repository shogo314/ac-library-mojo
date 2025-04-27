[APIs](../index.md) > [dsu](./index.md) > [DSU.md]()

# DSU

```
struct DSU
```

素集合データ構造

## Methods

### `__init__`

```
__init__(out self, n: Int)
```

$`n`$ 頂点 $`0`$ 辺の無向グラフを作る。

**制約**

- $`0 \le n \le 10^8`$

**計算量**

- $`O(n)`$

### `merge`

```
merge(mut self, a: Int, b: Int) raises -> Int
```

辺 $`(a, b)`$ を足す。

$`a, b`$ が連結だった場合はその代表元、非連結だった場合は新たな代表元を返す。

**制約**

- $`0 \le a \lt n`$
- $`0 \le b \lt n`$

**計算量**

- 償却 $`O(\alpha(n))`$

### `same`

```
same(mut self, a: Int, b: Int) raises -> Bool
```

### `leader`

```
leader(mut self, a: Int) raises -> Int
```

### `size`

```
size(mut self, a: Int) raises -> Int
```

### `groups`

```
groups(mut self) raises -> List[List[Int]]
```
