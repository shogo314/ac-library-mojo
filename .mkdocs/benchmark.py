VERSION = "0.4.0"
BENCHMARK_JSON = ".mkdocs/benchmark.json"
TIMESTAMPS = ".verify-helper/timestamps.local.json"
TEST_COUNT = 10

import subprocess
from pathlib import Path
import json
import sys


class Function:
    def __init__(self, d: dict):
        self.name = d["name"]
        self.path = Path(d["path"])
        self.time: list[float] | None = None
        self.memory: list[float] | None = None
        assert ("time" in d) == ("memory" in d)
        if "time" in d:
            self.time = d["time"]
            if self.time is not None:
                assert len(self.time) == TEST_COUNT
        if "memory" in d:
            self.memory = d["memory"]
            if self.memory is not None:
                assert len(self.memory) == TEST_COUNT
        assert self.path.is_file()

    def to_primitive(self) -> dict:
        return {
            "name": self.name,
            "path": str(self.path),
            "time": self.time,
            "memory": self.memory,
        }


class Problem:
    def __init__(self, d: dict):
        self.name = d["name"]
        self.fn = [Function(fn) for fn in d["fn"]]
        self.url = d["url"]

    def to_primitive(self) -> dict:
        return {
            "name": self.name,
            "fn": [fn.to_primitive() for fn in self.fn],
            "url": self.url,
        }


class Benchmark:
    def __init__(self, path: str | Path):
        self.json_path = Path(path)
        self.problem_list: list[Problem] = []
        with self.json_path.open() as f:
            tmp = json.load(f)
            for pr in tmp:
                self.problem_list.append(Problem(pr))

    def output(self):
        with self.json_path.open("w") as f:
            json.dump(
                [pr.to_primitive() for pr in self.problem_list],
                f,
                indent=2,
            )


BENCHMARK = Benchmark(BENCHMARK_JSON)


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
        tmp = tmp[:-4] + "\n}\n"
    with open(TIMESTAMPS, "w") as f:
        f.write(tmp)


def func(path: Path) -> tuple[float, float]:
    delete_stamp(path)
    result = subprocess.run(["oj-verify", "run", path], stdout=subprocess.PIPE)
    stdout = result.stdout.decode().strip().split("\n")
    tm = stdout[-3].split()
    mm = stdout[-2].split()
    return (float(tm[2]), float(mm[3]))


def problem(pr: Problem):
    print()
    print("### [" + pr.name + "](" + pr.url + ")")
    print()
    print("|", "機能", "|", "実行時間 avg/min/max (sec)", "|", "メモリ avg/min/max (MB)", "|")
    print("|", ":---", "|", ":---", "|", ":---", "|")
    for fn in pr.fn:
        if fn.time is None:
            tm = []
            mm = []
            for i in range(TEST_COUNT + 1):
                print(i, fn.path, file=sys.stderr)
                result = func(Path(fn.path))
                if i == 0:
                    continue
                tm.append(result[0])
                mm.append(result[1])
            fn.time = tm
            fn.memory = mm
        BENCHMARK.output()
        print(
            "|",
            "[" + fn.name + "](https://github.com/shogo314/ac-library-mojo/tree/" + VERSION + "/" + str(fn.path) + ")",
            "|",
            f"{(sum(fn.time) / TEST_COUNT):.3f}/{min(fn.time):.3f}/{max(fn.time):.3f}",
            "|",
            f"{(sum(fn.memory) / TEST_COUNT):.2f}/{min(fn.memory):.2f}/{max(fn.memory):.2f}",
            "|",
        )


def main():
    assert not Path(TIMESTAMPS).is_dir()

    if not Path(TIMESTAMPS).is_file():
        with open(TIMESTAMPS, "w") as f:
            print("{", file=f)
            print("}", file=f)
    for pr in BENCHMARK.problem_list:
        problem(pr)


if __name__ == "__main__":
    main()
