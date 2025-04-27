BENCHMARK_LIST = [
    {
        "name": "Double-Ended Priority Queue",
        "func": [
            {
                "name": "IntervalHeap",
                "path": "verify/yosupo/data_structure/double_ended_priority_queue/interval_heap.test.mojo",
            },
            {
                "name": "SegTree",
                "path": "verify/yosupo/data_structure/double_ended_priority_queue/segtree.test.mojo",
            },
        ],
        "path": "https://judge.yosupo.jp/problem/double_ended_priority_queue",
    },
    {
        "name": "Point Add Range Sum",
        "func": [
            {
                "name": "FenwickTree",
                "path": "verify/yosupo/data_structure/point_add_range_sum/fenwicktree.test.mojo",
            },
            {
                "name": "SegTree",
                "path": "verify/yosupo/data_structure/point_add_range_sum/segtree.test.mojo",
            },
        ],
        "path": "https://judge.yosupo.jp/problem/point_add_range_sum",
    },
    {
        "name": "Static Range Sum",
        "func": [
            {
                "name": "FenwickTree",
                "path": "verify/yosupo/data_structure/static_range_sum/fenwicktree.test.mojo",
            },
            {
                "name": "SegTree",
                "path": "verify/yosupo/data_structure/static_range_sum/segtree.test.mojo",
            },
        ],
        "path": "https://judge.yosupo.jp/problem/static_range_sum",
    },
    {
        "name": "Predecessor Problem",
        "func": [
            {
                "name": "AVLTree",
                "path": "verify/yosupo/data_structure/predecessor_problem/avltree.test.mojo",
            },
            {
                "name": "SegTree",
                "path": "verify/yosupo/data_structure/predecessor_problem/segtree.test.mojo",
            },
        ],
        "path": "https://judge.yosupo.jp/problem/predecessor_problem",
    },
]

TIMESTAMPS = ".verify-helper/timestamps.local.json"

TEST_COUNT = 10

import subprocess
from pathlib import Path


def delete_stamp(path: Path):
    tmp = ""
    with open(TIMESTAMPS, "r") as f:
        for l in f.readlines():
            if l.startswith('"' + str(path) + '"'):
                continue
            else:
                tmp += l.strip() + "\n"
    assert tmp.endswith("\n}\n")
    if tmp[-4] == ",":
        tmp[-4:] = "\n}\n"
    with open(TIMESTAMPS, "w") as f:
        f.write(tmp)


def func(path: Path) -> tuple[float, float]:
    delete_stamp(path)
    result = subprocess.run(["oj-verify", "run", path], stdout=subprocess.PIPE)
    stdout = result.stdout.decode().strip().split("\n")
    tm = stdout[-3].split()
    mm = stdout[-2].split()
    return (float(tm[2]), float(mm[3]))


def problem(pr: dict):
    print()
    print("### [" + pr["name"] + "](" + pr["path"] + ")")
    print()
    print("|", "機能", "|", "実行時間 avg/min/max (sec)", "|", "メモリ avg/min/max (MB)", "|")
    print("|", ":---", "|", ":---", "|", ":---", "|")
    for fn in pr["func"]:
        tm = []
        mm = []
        for i in range(TEST_COUNT):
            print(i, fn["path"])
            result = func(Path(fn["path"]))
            tm.append(result[0])
            mm.append(result[1])
        print(
            "|",
            "[" + fn["name"] + "](https://github.com/shogo314/ac-library-mojo/tree/main/" + fn["path"] + ")",
            "|",
            f"{(sum(tm) / TEST_COUNT):.04}/{min(tm):.04}/{max(tm):.04}",
            "|",
            f"{(sum(mm) / TEST_COUNT):.04}/{min(mm):.04}/{max(mm):.04}",
            "|",
        )


def main():
    assert not Path(TIMESTAMPS).is_dir()
    if not Path(TIMESTAMPS).is_file():
        with open(TIMESTAMPS, "w") as f:
            print("{", file=f)
            print("}", file=f)
    for pr in BENCHMARK_LIST:
        for fn in pr["func"]:
            assert Path(fn["path"]).is_file()
    for pr in BENCHMARK_LIST:
        problem(pr)


if __name__ == "__main__":
    main()
