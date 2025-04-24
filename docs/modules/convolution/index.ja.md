[モジュール](../index.md) > [convolution]()

# convolution

畳み込みを行う。数列 $`a_0, a_1, \dots, a_{N - 1}`$ と数列 $`a_0, a_1, \dots, a_{M - 1}`$ から、長さ $`N + M - 1`$ の数列

```math
c_i = \sum_{j=0}^{i} {a_j b_{i-j}}
```

を計算する。

## Functions

- [`convolution_mod`](./convolution_mod.md)
- [`convolution_int`](./convolution_int.md)
