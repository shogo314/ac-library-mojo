import argparse
from pathlib import Path
import sys
import os
from dependencies import search_file
from logging import getLogger

logger = getLogger(__name__)


def _list_dependencies(path: Path, include: list[Path]) -> list[Path]:
    logger.debug(f"get_dependencies_contents {path}")
    if not path.is_file():
        logger.warning(f"{path} is not a file.")
        return ([], "")
    dep = []
    with path.open("r") as f:
        lines = f.readlines()
    for line in lines:
        line = line.rstrip()
        if not (line.startswith("from ") or line.startswith("import ")):
            continue
        tokens = line.split()
        if len(tokens) < 2:
            logger.warning(f"Invalid import line: {line}")
            continue
        name = tokens[1]
        files = search_file(name, path, include)
        if not files:
            continue
        if len(files) > 1:
            logger.warning(f"Multiple matches for '{name}': {[str(f) for f in files]}")
        dep.append(files[0])
    logger.debug(f"{path} has dependencies: {dep}")
    return dep


def list_dependencies(path: Path, include: list[Path]) -> list[Path]:
    if not path.exists():
        print(f"{path} が存在しません", file=sys.stderr)
    s = {path}
    stk = [path]
    while stk:
        p = stk.pop()
        for q in _list_dependencies(p, include):
            if q not in s:
                s.add(q)
                stk.append(q)
    return list(s - {path})


def main(argv):
    parser = argparse.ArgumentParser(description="Mojoの依存関係を調べる")
    parser.add_argument("target", type=Path, help="対象となるファイルのパス")
    parser.add_argument(
        "-I",
        "--include",
        action="append",
        default=[],
        help="Additional include directories for resolving imports (can be specified multiple times)",
    )
    args = parser.parse_args()
    include = []
    for i in args.include:
        p = Path(i)
        if p.is_dir():
            include.append(p.resolve())
        else:
            logger.warning(f"{p} is not a directory.")
    res = list_dependencies(args.target, include)
    for p in res:
        print(p)


if __name__ == "__main__":
    main(sys.argv)
