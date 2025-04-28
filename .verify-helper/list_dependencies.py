import argparse
import pathlib
import sys
import os


def _list_dependencies(path: pathlib.Path) -> list[pathlib.Path]:
    res = []
    with open(path, "r") as f:
        for line in f.readlines():
            line = line.strip()
            if line.startswith("from ") or line.startswith("import "):
                pass
            else:
                continue
            line = line.split()
            assert len(line) >= 2
            x = line[1]
            f = x.replace(".", os.sep) + os.sep + "__init__.mojo"
            if os.path.isfile(f):
                res.append(pathlib.Path(f))
            f = x.replace(".", os.sep) + ".mojo"
            if os.path.isfile(f):
                res.append(pathlib.Path(f))
    return res


def list_dependencies(path: pathlib.Path) -> list[pathlib.Path]:
    if not path.exists():
        print(f"{path} が存在しません", file=sys.stderr)
    s = {path}
    stk = [path]
    while stk:
        p = stk.pop()
        for q in _list_dependencies(p):
            if q not in s:
                s.add(q)
                stk.append(q)
    return list(s - {path})


def main(argv):
    parser = argparse.ArgumentParser(description="Mojoの依存関係を調べる")
    parser.add_argument("target", type=pathlib.Path, help="対象となるファイルのパス")
    args = parser.parse_args()
    res = list_dependencies(args.target)
    for p in res:
        print(p)


if __name__ == "__main__":
    main(sys.argv)
