畳み込みを行う。数列 $`a_0, a_1, \dots, a_{N - 1}`$ と数列 $`a_0, a_1, \dots, a_{M - 1}`$ から、長さ $`N + M - 1`$ の数列

```math
c_i = \sum_{j=0}^{i} {a_j b_{i-j}}
```

を計算する。

**Functions**

- `convolution_mod`
- `convolution_int`

---

## `convolution_mod`

```
fn convolution_mod[M: Int](a: List[StaticModint[M]], b: List[StaticModint[M]]) raises -> List[StaticModint[M]]
```

畳み込みを mod $`m`$ で計算する。$`a, b`$ の少なくとも一方が空配列の場合は空配列を返す。

**制約**

- $`2 \le m \le 2 \times 10^9`$
- $`m`$ は素数
- $`2^c | (m - 1)`$ かつ $`|a| + |b| - 1 \le 2^c`$ なる $`c`$ が存在する

**計算量**

$`n = |a| + |b|`$ として

- $`O(n \log n + \log m)`$

---

## `convolution_int`

```
fn convolution_int(a: List[Int], b: List[Int]) raises -> List[Int]
```

畳み込みを計算する。$`a, b`$ の少なくとも一方が空配列の場合は空配列を返す。

**制約**

- $`|a| + |b| - 1 \le 2^{24}`$
- 畳み込んだ後の配列の要素が全て `Int` に収まる

**計算量**

$`n = |a| + |b|`$ として

- $`O(n \log n)`$
