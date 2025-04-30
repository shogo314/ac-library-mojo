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

### [Many A + B](https://judge.yosupo.jp/problem/many_aplusb)

| 機能 | 実行時間 avg/min/max (sec) | メモリ avg/min/max (MB) |
| :--- | :--- | :--- |
| [read all](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/sample/many_aplusb/io_all.test.mojo) | 2.044/1.828/2.375 | 90.79/89.24/92.30 |
| [read 16](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/sample/many_aplusb/io_16.test.mojo) | 4.432/4.215/5.475 | 13.34/12.89/13.55 |
| [read 256](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/sample/many_aplusb/io_256.test.mojo) | 2.130/1.956/2.626 | 12.64/10.27/13.73 |
| [read 4096](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/sample/many_aplusb/io_4096.test.mojo) | 1.913/1.787/2.478 | 15.09/14.55/15.45 |
| [read 65536](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/sample/many_aplusb/io_65536.test.mojo) | 2.100/1.836/2.712 | 15.09/14.59/15.76 |
| [read 1048576](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/sample/many_aplusb/io_1048576.test.mojo) | 1.916/1.759/2.389 | 15.67/13.90/17.74 |
| [Python](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/sample/many_aplusb/io.test.py) | 1.119/1.037/1.230 | 9.20/9.14/9.30 |
| [C++](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/sample/many_aplusb/io.test.cpp) | 0.349/0.332/0.385 | 3.54/3.50/3.59 |

### [Double-Ended Priority Queue](https://judge.yosupo.jp/problem/double_ended_priority_queue)

| 機能 | 実行時間 avg/min/max (sec) | メモリ avg/min/max (MB) |
| :--- | :--- | :--- |
| [IntervalHeap](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/data_structure/double_ended_priority_queue/interval_heap.test.mojo) | 1.296/1.197/2.017 | 35.76/34.77/38.05 |
| [SegTree + Compress](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/data_structure/double_ended_priority_queue/segtree.test.mojo) | 1.650/1.618/1.735 | 68.01/66.76/68.58 |

### [Point Add Range Sum](https://judge.yosupo.jp/problem/point_add_range_sum)

| 機能 | 実行時間 avg/min/max (sec) | メモリ avg/min/max (MB) |
| :--- | :--- | :--- |
| [FenwickTree](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/data_structure/point_add_range_sum/fenwicktree.test.mojo) | 1.952/1.880/2.173 | 41.56/40.58/43.73 |
| [SegTree](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/data_structure/point_add_range_sum/segtree.test.mojo) | 2.086/1.999/2.285 | 41.18/39.75/41.98 |
| [SegTree with Parameter](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/data_structure/point_add_range_sum/segtree_with_parameter.test.mojo) | 2.092/1.958/2.756 | 37.94/35.32/39.40 |

### [Point Set Range Composite](https://judge.yosupo.jp/problem/point_set_range_composite)

| 機能 | 実行時間 avg/min/max (sec) | メモリ avg/min/max (MB) |
| :--- | :--- | :--- |
| [SegTree](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/data_structure/point_set_range_composite/segtree.test.mojo) | 3.841/3.396/5.484 | 57.01/56.38/59.04 |
| [SegTree with Parameter](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/data_structure/point_set_range_composite/segtree_with_parameter.test.mojo) | 3.818/3.414/4.613 | 56.54/56.34/57.57 |

### [Static Range Sum](https://judge.yosupo.jp/problem/static_range_sum)

| 機能 | 実行時間 avg/min/max (sec) | メモリ avg/min/max (MB) |
| :--- | :--- | :--- |
| [Cumulative Sum](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/data_structure/static_range_sum/cumulative_sum.test.mojo) | 1.601/1.462/1.837 | 33.53/31.90/35.77 |
| [FenwickTree](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/data_structure/static_range_sum/fenwicktree.test.mojo) | 1.667/1.569/2.091 | 32.04/31.85/32.60 |
| [SegTree](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/data_structure/static_range_sum/segtree.test.mojo) | 1.640/1.612/1.691 | 35.09/32.99/36.52 |

### [Predecessor Problem](https://judge.yosupo.jp/problem/predecessor_problem)

| 機能 | 実行時間 avg/min/max (sec) | メモリ avg/min/max (MB) |
| :--- | :--- | :--- |
| [AVLTree](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/data_structure/predecessor_problem/avltree.test.mojo) | 22.015/21.004/23.261 | 711.33/710.00/712.09 |
| [BinaryTrie](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/data_structure/predecessor_problem/binarytrie.test.mojo) | 18.826/18.313/20.878 | 711.28/710.52/712.09 |
| [SegTree](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/data_structure/predecessor_problem/segtree.test.mojo) | 6.758/6.373/8.253 | 514.23/513.88/514.44 |

### [Ordered Set](https://judge.yosupo.jp/problem/ordered_set)

| 機能 | 実行時間 avg/min/max (sec) | メモリ avg/min/max (MB) |
| :--- | :--- | :--- |
| [AVLTree](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/data_structure/ordered_set/avltree.test.mojo) | 3.242/3.120/3.417 | 78.73/78.32/79.04 |
| [BinaryTrie](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/data_structure/ordered_set/binarytrie.test.mojo) | 3.679/3.253/4.964 | 186.92/185.98/187.72 |
| [SegTree + Compress](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/data_structure/ordered_set/segtree.test.mojo) | 1.771/1.689/1.988 | 68.98/68.55/70.83 |
