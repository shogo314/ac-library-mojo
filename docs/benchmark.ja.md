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
| [read all](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/sample/many_aplusb/io_all.test.mojo) | 2.288/1.710/4.991 | 92.71/90.00/95.17 |
| [read 16](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/sample/many_aplusb/io_16.test.mojo) | 4.065/3.866/4.310 | 13.28/12.55/13.69 |
| [read 256](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/sample/many_aplusb/io_256.test.mojo) | 1.826/1.777/1.909 | 13.40/12.94/13.76 |
| [read 4096](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/sample/many_aplusb/io_4096.test.mojo) | 1.708/1.668/1.753 | 15.49/15.14/15.74 |
| [read 65536](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/sample/many_aplusb/io_65536.test.mojo) | 1.709/1.680/1.747 | 15.69/15.15/17.62 |
| [read 1048576](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/sample/many_aplusb/io_1048576.test.mojo) | 1.821/1.634/2.550 | 15.68/15.01/17.50 |
| [Python](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/sample/many_aplusb/io.test.py) | 1.010/0.967/1.068 | 9.24/9.16/9.30 |
| [C++](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/sample/many_aplusb/io.test.cpp) | 0.321/0.307/0.358 | 3.52/3.42/3.58 |

### [Double-Ended Priority Queue](https://judge.yosupo.jp/problem/double_ended_priority_queue)

| 機能 | 実行時間 avg/min/max (sec) | メモリ avg/min/max (MB) |
| :--- | :--- | :--- |
| [IntervalHeap](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/data_structure/double_ended_priority_queue/interval_heap.test.mojo) | 0.777/0.734/0.897 | 27.94/26.76/29.96 |
| [SegTree + Compress](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/data_structure/double_ended_priority_queue/segtree.test.mojo) | 1.238/1.218/1.263 | 64.47/63.98/64.96 |

### [Point Add Range Sum](https://judge.yosupo.jp/problem/point_add_range_sum)

| 機能 | 実行時間 avg/min/max (sec) | メモリ avg/min/max (MB) |
| :--- | :--- | :--- |
| [FenwickTree](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/data_structure/point_add_range_sum/fenwicktree.test.mojo) | 1.131/1.084/1.193 | 23.92/23.19/25.90 |
| [SegTree](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/data_structure/point_add_range_sum/segtree.test.mojo) | 1.227/1.199/1.266 | 27.70/27.31/28.07 |
| [SegTree with Parameter](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/data_structure/point_add_range_sum/segtree_with_parameter.test.mojo) | 1.221/1.167/1.395 | 28.00/27.42/29.99 |

### [Point Set Range Composite](https://judge.yosupo.jp/problem/point_set_range_composite)

| 機能 | 実行時間 avg/min/max (sec) | メモリ avg/min/max (MB) |
| :--- | :--- | :--- |
| [SegTree](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/data_structure/point_set_range_composite/segtree.test.mojo) | 2.149/1.953/2.606 | 39.68/39.10/40.12 |
| [SegTree with Parameter](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/data_structure/point_set_range_composite/segtree_with_parameter.test.mojo) | 2.127/1.906/3.507 | 40.13/39.52/42.05 |

### [Range Affine Point Get](https://judge.yosupo.jp/problem/range_affine_point_get)

| 機能 | 実行時間 avg/min/max (sec) | メモリ avg/min/max (MB) |
| :--- | :--- | :--- |
| [DualSegTree](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/data_structure/range_affine_point_get/dualsegtree.test.mojo) | 2.838/2.744/2.930 | 39.66/38.88/41.91 |
| [LazySegTree](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/data_structure/range_affine_point_get/lazysegtree.test.mojo) | 3.840/3.693/4.392 | 43.99/43.14/46.13 |

### [Static Range Sum](https://judge.yosupo.jp/problem/static_range_sum)

| 機能 | 実行時間 avg/min/max (sec) | メモリ avg/min/max (MB) |
| :--- | :--- | :--- |
| [Cumulative Sum](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/data_structure/static_range_sum/cumulative_sum.test.mojo) | 1.023/0.923/1.566 | 23.20/22.64/23.74 |
| [FenwickTree](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/data_structure/static_range_sum/fenwicktree.test.mojo) | 1.017/0.991/1.066 | 23.55/23.07/23.96 |
| [SegTree](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/data_structure/static_range_sum/segtree.test.mojo) | 1.382/1.091/2.969 | 27.52/26.90/28.00 |

### [Predecessor Problem](https://judge.yosupo.jp/problem/predecessor_problem)

| 機能 | 実行時間 avg/min/max (sec) | メモリ avg/min/max (MB) |
| :--- | :--- | :--- |
| [AVLTree](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/data_structure/predecessor_problem/avltree.test.mojo) | 22.320/18.334/32.671 | 580.47/571.28/585.98 |
| [BinaryTrie](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/data_structure/predecessor_problem/binarytrie.test.mojo) | 16.770/14.623/25.552 | 584.52/580.38/586.17 |
| [WordSizeTree](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/data_structure/predecessor_problem/wordsizetree.test.mojo) | 2.261/2.033/3.338 | 42.16/41.69/42.39 |
| [SegTree](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/data_structure/predecessor_problem/segtree.test.mojo) | 2.951/2.692/3.731 | 372.47/371.89/374.25 |

### [Ordered Set](https://judge.yosupo.jp/problem/ordered_set)

| 機能 | 実行時間 avg/min/max (sec) | メモリ avg/min/max (MB) |
| :--- | :--- | :--- |
| [AVLTree](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/data_structure/ordered_set/avltree.test.mojo) | 2.424/2.379/2.498 | 68.53/68.16/68.87 |
| [BinaryTrie](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/data_structure/ordered_set/binarytrie.test.mojo) | 2.463/2.421/2.521 | 176.85/175.87/177.66 |
| [SegTree + Compress](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/data_structure/ordered_set/segtree.test.mojo) | 1.319/1.226/1.667 | 66.38/65.93/66.74 |
