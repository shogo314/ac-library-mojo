# ベンチマーク

## 実行環境

- **ホストOS**: Windows 11 Home 24H2
- **WSLバージョン**: WSL2
- **Linuxディストリビューション**: Ubuntu 22.04
- **CPU**: AMD Ryzen 5 7520U
- **メモリ**: 8GB (WSLが使えるのはもっと少ないはず)

```
oj-verify run {path}
```

を実行しています。

## 実行結果

### Point Add Range Sum

| ライブラリ機能 | 実行時間 (sec) | メモリ (MB) |
|:--------------|:-------------|:-------|
| [FenwickTree](https://github.com/shogo314/ac-library-mojo/tree/main/benchmark/point_add_range_sum/fenwicktree.mojo) | 4.103 | 35.32 |
| [SegTree](https://github.com/shogo314/ac-library-mojo/tree/main/benchmark/point_add_range_sum/segtree.mojo) | 4.807 | 35.36 |

### Static Range Sum

| ライブラリ機能 | 実行時間 (sec) | メモリ (MB) |
|:--------------|:-------------|:-------|
| [FenwickTree](https://github.com/shogo314/ac-library-mojo/tree/main/benchmark/static_range_sum/fenwicktree.mojo) | 3.279 | 37.48 |
| [SegTree](https://github.com/shogo314/ac-library-mojo/tree/main/benchmark/static_range_sum/segtree.mojo) | 4.854 | 37.42 |
