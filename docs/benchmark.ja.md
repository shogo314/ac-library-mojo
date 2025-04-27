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

を 10 回ずつ実行しています。

## 実行結果

### [Double-Ended Priority Queue](https://judge.yosupo.jp/problem/double_ended_priority_queue)

| 機能 | 実行時間 avg/min/max (sec) | メモリ avg/min/max (MB) |
| :--- | :--- | :--- |
| [IntervalHeap](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/data_structure/double_ended_priority_queue/interval_heap.test.mojo) | 2.803/2.524/4.033 | 32.38/31.75/33.52 |
| [SegTree](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/data_structure/double_ended_priority_queue/segtree.test.mojo) | 3.249/2.748/6.447 | 64.61/63.19/65.69 |

### [Point Add Range Sum](https://judge.yosupo.jp/problem/point_add_range_sum)

| 機能 | 実行時間 avg/min/max (sec) | メモリ avg/min/max (MB) |
| :--- | :--- | :--- |
| [FenwickTree](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/data_structure/point_add_range_sum/fenwicktree.test.mojo) | 4.393/4.126/5.184 | 38.83/37.4/39.89 |
| [SegTree](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/data_structure/point_add_range_sum/segtree.test.mojo) | 4.186/4.094/4.286 | 39.21/38.26/40.72 |

### [Static Range Sum](https://judge.yosupo.jp/problem/static_range_sum)

| 機能 | 実行時間 avg/min/max (sec) | メモリ avg/min/max (MB) |
| :--- | :--- | :--- |
| [FenwickTree](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/data_structure/static_range_sum/fenwicktree.test.mojo) | 3.394/3.033/5.796 | 35.98/34.78/37.04 |
| [SegTree](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/data_structure/static_range_sum/segtree.test.mojo) | 3.3/3.088/3.686 | 36.67/34.76/39.94 |

### [Predecessor Problem](https://judge.yosupo.jp/problem/predecessor_problem)

| 機能 | 実行時間 avg/min/max (sec) | メモリ avg/min/max (MB) |
| :--- | :--- | :--- |
| [AVLTree](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/data_structure/predecessor_problem/avltree.test.mojo) | 40.32/36.8/46.74 | 608.3/604.3/615.1 |
| [SegTree](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/data_structure/predecessor_problem/segtree.test.mojo) | 12.04/10.81/15.23 | 514.3/513.9/514.5 |
