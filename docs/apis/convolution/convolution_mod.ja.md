[APIs](../index.md) > [convolution](./index.md) > [convolution_mod]()

# convolution_mod

```
convolution_mod[M: Int](a: List[StaticModint[M]], b: List[StaticModint[M]]) -> List[StaticModint[M]]
```

畳み込みを mod $`m`$ で計算する。$`a, b`$ の少なくとも一方が空配列の場合は空配列を返す。

**制約**

- $`2 \le m \le 2 \times 10^9`$
- $`m`$ は素数
- $`2^c | (m - 1)`$ かつ $`|a| + |b| - 1 \le 2^c`$ なる $`c`$ が存在する。

**計算量**

$`n = |a| + |b|`$ として

- $`O(n \log n + \log m)`$
