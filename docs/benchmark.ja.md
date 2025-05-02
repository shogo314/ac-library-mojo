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
| [read all](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/sample/many_aplusb/io_all.test.mojo) | 2.657/1.713/3.926 | 92.55/91.34/93.78 |
| [read 16](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/sample/many_aplusb/io_16.test.mojo) | 6.086/4.398/12.508 | 13.32/12.79/13.81 |
| [read 256](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/sample/many_aplusb/io_256.test.mojo) | 2.277/1.926/2.938 | 13.02/11.72/13.51 |
| [read 4096](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/sample/many_aplusb/io_4096.test.mojo) | 1.802/1.732/2.141 | 15.44/14.98/15.69 |
| [read 65536](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/sample/many_aplusb/io_65536.test.mojo) | 1.861/1.759/1.998 | 15.43/14.90/15.73 |
| [read 1048576](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/sample/many_aplusb/io_1048576.test.mojo) | 1.942/1.769/2.271 | 15.44/15.14/15.73 |
| [Python](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/sample/many_aplusb/io.test.py) | 0.998/0.933/1.128 | 10.11/10.06/10.19 |
| [C++](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/sample/many_aplusb/io.test.cpp) | 0.396/0.336/0.539 | 3.51/3.45/3.56 |

### [Double-Ended Priority Queue](https://judge.yosupo.jp/problem/double_ended_priority_queue)

| 機能 | 実行時間 avg/min/max (sec) | メモリ avg/min/max (MB) |
| :--- | :--- | :--- |
| [IntervalHeap](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/data_structure/double_ended_priority_queue/interval_heap.test.mojo) | 0.758/0.702/0.876 | 27.86/27.56/28.13 |
| [SegTree + Compress](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/data_structure/double_ended_priority_queue/segtree.test.mojo) | 1.230/1.091/1.683 | 64.45/63.99/64.95 |

### [Point Add Range Sum](https://judge.yosupo.jp/problem/point_add_range_sum)

| 機能 | 実行時間 avg/min/max (sec) | メモリ avg/min/max (MB) |
| :--- | :--- | :--- |
| [FenwickTree](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/data_structure/point_add_range_sum/fenwicktree.test.mojo) | 1.244/1.074/1.888 | 23.58/22.70/23.93 |
| [SegTree](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/data_structure/point_add_range_sum/segtree.test.mojo) | 1.174/1.111/1.312 | 27.81/27.46/28.08 |
| [SegTree with Parameter](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/data_structure/point_add_range_sum/segtree_with_parameter.test.mojo) | 1.151/1.097/1.291 | 28.13/27.64/29.98 |

### [Point Set Range Composite](https://judge.yosupo.jp/problem/point_set_range_composite)

| 機能 | 実行時間 avg/min/max (sec) | メモリ avg/min/max (MB) |
| :--- | :--- | :--- |
| [SegTree](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/data_structure/point_set_range_composite/segtree.test.mojo) | 2.142/1.928/2.847 | 40.08/39.42/42.08 |
| [SegTree with Parameter](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/data_structure/point_set_range_composite/segtree_with_parameter.test.mojo) | 2.126/1.904/2.548 | 40.08/39.62/42.08 |

### [Range Affine Point Get](https://judge.yosupo.jp/problem/range_affine_point_get)

| 機能 | 実行時間 avg/min/max (sec) | メモリ avg/min/max (MB) |
| :--- | :--- | :--- |
| [DualSegTree](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/data_structure/range_affine_point_get/dualsegtree.test.mojo) | 2.694/2.571/2.956 | 39.61/38.76/39.85 |
| [LazySegTree](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/data_structure/range_affine_point_get/lazysegtree.test.mojo) | 3.533/3.343/4.574 | 43.88/43.54/44.26 |

### [Static Range Sum](https://judge.yosupo.jp/problem/static_range_sum)

| 機能 | 実行時間 avg/min/max (sec) | メモリ avg/min/max (MB) |
| :--- | :--- | :--- |
| [Cumulative Sum](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/data_structure/static_range_sum/cumulative_sum.test.mojo) | 0.947/0.920/0.995 | 23.69/23.45/23.96 |
| [FenwickTree](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/data_structure/static_range_sum/fenwicktree.test.mojo) | 0.976/0.952/1.024 | 23.88/23.38/25.70 |
| [SegTree](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/data_structure/static_range_sum/segtree.test.mojo) | 1.027/0.986/1.108 | 27.77/27.02/28.06 |

### [Predecessor Problem](https://judge.yosupo.jp/problem/predecessor_problem)

| 機能 | 実行時間 avg/min/max (sec) | メモリ avg/min/max (MB) |
| :--- | :--- | :--- |
| [AVLTree](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/data_structure/predecessor_problem/avltree.test.mojo) | 13.637/12.796/15.604 | 618.69/585.49/624.92 |
| [BinaryTrie](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/data_structure/predecessor_problem/binarytrie.test.mojo) | 13.292/12.075/14.181 | 585.55/584.56/586.16 |
| [WordSizeTree](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/data_structure/predecessor_problem/wordsizetree.test.mojo) | 2.020/1.958/2.182 | 42.24/41.53/44.04 |
| [SegTree](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/data_structure/predecessor_problem/segtree.test.mojo) | 2.938/2.447/4.144 | 371.99/371.42/372.37 |

### [Ordered Set](https://judge.yosupo.jp/problem/ordered_set)

| 機能 | 実行時間 avg/min/max (sec) | メモリ avg/min/max (MB) |
| :--- | :--- | :--- |
| [AVLTree](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/data_structure/ordered_set/avltree.test.mojo) | 2.347/2.146/2.704 | 68.72/68.07/70.75 |
| [BinaryTrie](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/data_structure/ordered_set/binarytrie.test.mojo) | 2.645/2.394/3.357 | 174.69/173.61/175.78 |
| [SegTree + Compress](https://github.com/shogo314/ac-library-mojo/tree/main/verify/yosupo/data_structure/ordered_set/segtree.test.mojo) | 1.581/1.213/3.133 | 66.14/65.13/66.56 |
