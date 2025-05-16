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
| [read all](https://github.com/shogo314/ac-library-mojo/tree/0.4.0/verify/yosupo/sample/many_aplusb/io_all.test.mojo) | 2.214/1.725/3.513 | 149.77/149.02/150.48 |
| [read 16](https://github.com/shogo314/ac-library-mojo/tree/0.4.0/verify/yosupo/sample/many_aplusb/io_16.test.mojo) | 4.241/4.027/4.892 | 21.35/21.01/21.49 |
| [read 256](https://github.com/shogo314/ac-library-mojo/tree/0.4.0/verify/yosupo/sample/many_aplusb/io_256.test.mojo) | 1.822/1.755/2.112 | 21.21/20.52/21.66 |
| [read 4096](https://github.com/shogo314/ac-library-mojo/tree/0.4.0/verify/yosupo/sample/many_aplusb/io_4096.test.mojo) | 1.641/1.569/1.770 | 23.16/22.37/23.68 |
| [read 65536](https://github.com/shogo314/ac-library-mojo/tree/0.4.0/verify/yosupo/sample/many_aplusb/io_65536.test.mojo) | 1.600/1.545/1.707 | 23.64/23.20/25.03 |
| [read 1048576](https://github.com/shogo314/ac-library-mojo/tree/0.4.0/verify/yosupo/sample/many_aplusb/io_1048576.test.mojo) | 1.647/1.527/2.001 | 23.25/22.72/23.64 |
| [Mojo with Python input](https://github.com/shogo314/ac-library-mojo/tree/0.4.0/verify/yosupo/sample/many_aplusb/py.test.mojo) | 13.956/12.745/15.648 | 27.97/27.14/28.34 |
| [Python with input](https://github.com/shogo314/ac-library-mojo/tree/0.4.0/verify/yosupo/sample/many_aplusb/input.test.py) | 2.815/2.499/4.165 | 10.10/10.06/10.14 |
| [Python with sys.stdin.readline](https://github.com/shogo314/ac-library-mojo/tree/0.4.0/verify/yosupo/sample/many_aplusb/io.test.py) | 1.017/0.822/1.371 | 10.22/10.18/10.28 |
| [C++](https://github.com/shogo314/ac-library-mojo/tree/0.4.0/verify/yosupo/sample/many_aplusb/io.test.cpp) | 0.350/0.335/0.418 | 3.59/3.54/3.62 |

### [Double-Ended Priority Queue](https://judge.yosupo.jp/problem/double_ended_priority_queue)

| 機能 | 実行時間 avg/min/max (sec) | メモリ avg/min/max (MB) |
| :--- | :--- | :--- |
| [IntervalHeap](https://github.com/shogo314/ac-library-mojo/tree/0.4.0/verify/yosupo/data_structure/double_ended_priority_queue/interval_heap.test.mojo) | 0.712/0.687/0.740 | 35.27/34.42/36.02 |
| [BinaryTrie](https://github.com/shogo314/ac-library-mojo/tree/0.4.0/verify/yosupo/data_structure/double_ended_priority_queue/binarytrie.test.mojo) | 3.216/2.958/3.792 | 320.89/320.19/322.35 |
| [SegTree + Compress](https://github.com/shogo314/ac-library-mojo/tree/0.4.0/verify/yosupo/data_structure/double_ended_priority_queue/segtree.test.mojo) | 1.280/1.164/1.513 | 70.99/70.18/71.69 |

### [Point Add Range Sum](https://judge.yosupo.jp/problem/point_add_range_sum)

| 機能 | 実行時間 avg/min/max (sec) | メモリ avg/min/max (MB) |
| :--- | :--- | :--- |
| [FenwickTree](https://github.com/shogo314/ac-library-mojo/tree/0.4.0/verify/yosupo/data_structure/point_add_range_sum/fenwicktree.test.mojo) | 1.146/0.955/1.797 | 31.68/31.32/32.80 |
| [SegTree](https://github.com/shogo314/ac-library-mojo/tree/0.4.0/verify/yosupo/data_structure/point_add_range_sum/segtree.test.mojo) | 1.096/1.013/1.257 | 35.76/35.38/37.10 |
| [SegTree with Parameter](https://github.com/shogo314/ac-library-mojo/tree/0.4.0/verify/yosupo/data_structure/point_add_range_sum/segtree_with_parameter.test.mojo) | 1.073/0.972/1.472 | 35.57/35.05/35.89 |
| [LazySegTree](https://github.com/shogo314/ac-library-mojo/tree/0.4.0/verify/yosupo/data_structure/point_add_range_sum/lazysegtree.test.mojo) | 2.785/2.383/4.210 | 43.93/43.47/45.34 |

### [Point Set Range Composite](https://judge.yosupo.jp/problem/point_set_range_composite)

| 機能 | 実行時間 avg/min/max (sec) | メモリ avg/min/max (MB) |
| :--- | :--- | :--- |
| [SegTree](https://github.com/shogo314/ac-library-mojo/tree/0.4.0/verify/yosupo/data_structure/point_set_range_composite/segtree.test.mojo) | 1.972/1.758/2.387 | 47.70/47.45/47.90 |
| [SegTree with Parameter](https://github.com/shogo314/ac-library-mojo/tree/0.4.0/verify/yosupo/data_structure/point_set_range_composite/segtree_with_parameter.test.mojo) | 2.237/1.787/3.576 | 47.12/45.97/47.64 |

### [Range Affine Point Get](https://judge.yosupo.jp/problem/range_affine_point_get)

| 機能 | 実行時間 avg/min/max (sec) | メモリ avg/min/max (MB) |
| :--- | :--- | :--- |
| [DualSegTree](https://github.com/shogo314/ac-library-mojo/tree/0.4.0/verify/yosupo/data_structure/range_affine_point_get/dualsegtree.test.mojo) | 3.478/2.936/5.358 | 47.10/46.08/47.71 |
| [LazySegTree](https://github.com/shogo314/ac-library-mojo/tree/0.4.0/verify/yosupo/data_structure/range_affine_point_get/lazysegtree.test.mojo) | 4.649/3.556/6.838 | 51.07/46.93/53.25 |

### [Static Range Sum](https://judge.yosupo.jp/problem/static_range_sum)

| 機能 | 実行時間 avg/min/max (sec) | メモリ avg/min/max (MB) |
| :--- | :--- | :--- |
| [Cumulative Sum](https://github.com/shogo314/ac-library-mojo/tree/0.4.0/verify/yosupo/data_structure/static_range_sum/cumulative_sum.test.mojo) | 1.584/0.955/3.026 | 30.80/30.32/31.69 |
| [FenwickTree](https://github.com/shogo314/ac-library-mojo/tree/0.4.0/verify/yosupo/data_structure/static_range_sum/fenwicktree.test.mojo) | 1.007/0.951/1.165 | 31.36/30.38/33.06 |
| [SegTree](https://github.com/shogo314/ac-library-mojo/tree/0.4.0/verify/yosupo/data_structure/static_range_sum/segtree.test.mojo) | 1.048/0.946/1.215 | 34.93/34.40/35.64 |

### [Predecessor Problem](https://judge.yosupo.jp/problem/predecessor_problem)

| 機能 | 実行時間 avg/min/max (sec) | メモリ avg/min/max (MB) |
| :--- | :--- | :--- |
| [AVLTree](https://github.com/shogo314/ac-library-mojo/tree/0.4.0/verify/yosupo/data_structure/predecessor_problem/avltree.test.mojo) | 10.092/8.635/12.437 | 662.42/661.54/663.24 |
| [BinaryTrie](https://github.com/shogo314/ac-library-mojo/tree/0.4.0/verify/yosupo/data_structure/predecessor_problem/binarytrie.test.mojo) | 8.121/7.008/10.192 | 662.58/661.70/663.74 |
| [BinaryTrie with preallocate](https://github.com/shogo314/ac-library-mojo/tree/0.4.0/verify/yosupo/data_structure/predecessor_problem/binarytrie_preallocate.test.mojo) | 5.339/5.140/5.667 | 518.59/517.99/519.37 |
| [WordSizeTree](https://github.com/shogo314/ac-library-mojo/tree/0.4.0/verify/yosupo/data_structure/predecessor_problem/wordsizetree.test.mojo) | 1.663/1.466/2.349 | 50.02/49.86/50.35 |
| [SegTree](https://github.com/shogo314/ac-library-mojo/tree/0.4.0/verify/yosupo/data_structure/predecessor_problem/segtree.test.mojo) | 3.068/2.356/3.944 | 379.71/379.44/380.88 |

### [Ordered Set](https://judge.yosupo.jp/problem/ordered_set)

| 機能 | 実行時間 avg/min/max (sec) | メモリ avg/min/max (MB) |
| :--- | :--- | :--- |
| [AVLTree](https://github.com/shogo314/ac-library-mojo/tree/0.4.0/verify/yosupo/data_structure/ordered_set/avltree.test.mojo) | 1.973/1.831/2.230 | 63.76/62.78/64.43 |
| [BinaryTrie](https://github.com/shogo314/ac-library-mojo/tree/0.4.0/verify/yosupo/data_structure/ordered_set/binarytrie.test.mojo) | 2.087/2.014/2.177 | 275.41/273.93/276.15 |
| [BinaryTrie with preallocate](https://github.com/shogo314/ac-library-mojo/tree/0.4.0/verify/yosupo/data_structure/ordered_set/binarytrie_preallocate.test.mojo) | 1.963/1.833/2.115 | 215.43/214.37/216.00 |
| [SegTree + Compress](https://github.com/shogo314/ac-library-mojo/tree/0.4.0/verify/yosupo/data_structure/ordered_set/segtree.test.mojo) | 1.409/1.258/1.685 | 72.02/71.43/72.92 |
