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
| [IntervalHeap](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/data_structure/double_ended_priority_queue/interval_heap.test.mojo) | 2.615/2.345/3.602 | 35.91/35.62/36.12 |
| [SegTree + Compress](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/data_structure/double_ended_priority_queue/segtree.test.mojo) | 2.589/2.286/2.713 | 68.06/67.56/68.40 |

### [Point Add Range Sum](https://judge.yosupo.jp/problem/point_add_range_sum)

| 機能 | 実行時間 avg/min/max (sec) | メモリ avg/min/max (MB) |
| :--- | :--- | :--- |
| [FenwickTree](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/data_structure/point_add_range_sum/fenwicktree.test.mojo) | 4.248/3.985/4.627 | 41.64/40.56/43.67 |
| [SegTree](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/data_structure/point_add_range_sum/segtree.test.mojo) | 3.978/3.913/4.091 | 41.61/41.08/41.96 |
| [SegTree with Parameter](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/data_structure/point_add_range_sum/segtree_with_parameter.test.mojo) | 4.083/3.916/4.337 | 41.44/40.97/41.97 |

### [Point Set Range Composite](https://judge.yosupo.jp/problem/point_set_range_composite)

| 機能 | 実行時間 avg/min/max (sec) | メモリ avg/min/max (MB) |
| :--- | :--- | :--- |
| [SegTree](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/data_structure/point_set_range_composite/segtree.test.mojo) | 6.778/6.484/7.550 | 61.02/60.33/62.71 |
| [SegTree with Parameter](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/data_structure/point_set_range_composite/segtree_with_parameter.test.mojo) | 6.637/6.448/7.156 | 61.84/60.46/62.60 |

### [Static Range Sum](https://judge.yosupo.jp/problem/static_range_sum)

| 機能 | 実行時間 avg/min/max (sec) | メモリ avg/min/max (MB) |
| :--- | :--- | :--- |
| [FenwickTree](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/data_structure/static_range_sum/fenwicktree.test.mojo) | 3.167/2.899/3.924 | 36.87/34.60/37.95 |
| [SegTree](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/data_structure/static_range_sum/segtree.test.mojo) | 3.032/2.949/3.287 | 37.66/36.15/38.21 |

### [Predecessor Problem](https://judge.yosupo.jp/problem/predecessor_problem)

| 機能 | 実行時間 avg/min/max (sec) | メモリ avg/min/max (MB) |
| :--- | :--- | :--- |
| [AVLTree](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/data_structure/predecessor_problem/avltree.test.mojo) | 18.690/17.863/21.966 | 838.10/837.10/839.18 |
| [SegTree](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/data_structure/predecessor_problem/segtree.test.mojo) | 8.742/8.552/9.148 | 514.45/514.03/514.68 |

### [Ordered Set](https://judge.yosupo.jp/problem/ordered_set)

| 機能 | 実行時間 avg/min/max (sec) | メモリ avg/min/max (MB) |
| :--- | :--- | :--- |
| [AVLTree](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/data_structure/ordered_set/avltree.test.mojo) | 4.765/4.473/5.605 | 76.95/73.18/79.19 |
| [SegTree + Compress](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/data_structure/ordered_set/segtree.test.mojo) | 2.911/2.797/3.130 | 68.45/67.70/68.93 |
