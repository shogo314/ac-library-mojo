from pathlib import Path
from logging import getLogger
import os

logger = getLogger(__name__)


def search_file(name: str, path: Path, include: list[Path]) -> list[Path]:
    if name.startswith("."):
        name = name[1:]
        include = []
    name = name.replace(".", os.sep)
    res = []
    for i in [path.parent] + include:
        p = i.joinpath(f"{name}.mojo").resolve()
        if p.is_file():
            res.append(p)

        p = i.joinpath(name).joinpath("__init__.mojo").resolve()
        if p.is_file():
            res.append(p)
    return sorted(list(set(res)))


def get_dependencies_contents(path: Path, include: list[Path]) -> tuple[list[Path], str]:
    logger.debug(f"get_dependencies_contents {path}")
    if not path.is_file():
        logger.warning(f"{path} is not a file.")
        return ([], "")
    dep = []
    body = []
    with path.open("r") as f:
        lines = f.readlines()
    i = 0
    while i < len(lines):
        line = lines[i].rstrip()
        if not line.startswith("from "):
            body.append(line)
            i += 1
            continue
        tokens = line.split()
        if len(tokens) < 2:
            logger.warning(f"Invalid import line: {line}")
            body.append(line)
            i += 1
            continue
        name = tokens[1]
        files = search_file(name, path, include)
        if not files:
            body.append(line)
            i += 1
            continue
        if len(files) > 1:
            logger.warning(f"Multiple matches for '{name}': {[str(f) for f in files]}")
        dep.append(files[0])
        k = 0
        while i < len(lines):
            for c in lines[i]:
                if c == "(":
                    k += 1
                elif c == ")":
                    k -= 1
            i += 1
            if k == 0:
                break
    logger.debug(f"{path} has dependencies: {dep}")
    return (sorted(list(set(dep))), "\n".join(body).strip())
