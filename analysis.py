from pathlib import Path
from operator import attrgetter


def trim(s: str) -> str:
    tmp = ""
    for c in s:
        if "0" <= c <= "9" or "a" <= c <= "z" or "A" <= c <= "Z" or c == "_":
            tmp += c
        else:
            break
    return tmp


class Fn:
    def __init__(self, name: str):
        self.name = name
        self.data: list[str] = []

    def __repr__(self) -> str:
        return f"Fn({repr(self.name)}, {repr(self.data)})"

    def to_primitive(self) -> dict:
        return {"name": self.name, "data": self.data}


class Module:
    def __init__(self, name):
        self.name = name
        self.aliases: list[Alias] = []
        self.structs: list[Struct] = []
        self.traits: list[Trait] = []
        self.functions: list[Fn] = []

    def to_primitive(self) -> dict:
        return {
            "name": self.name,
            "aliases": [a.to_primitive() for a in self.aliases],
            "structs": [a.to_primitive() for a in self.structs],
            "traits": [a.to_primitive() for a in self.traits],
            "functions": [a.to_primitive() for a in self.functions],
        }


def find_methods(l: list[str]) -> list[Fn]:
    assert not l[0].startswith(" ")
    res: list[Fn] = []
    for a in l[1:]:
        assert a.startswith("    ")
        if a.startswith("    fn "):
            name = trim(a[len("    fn ") :])
            for i in range(len(res)):
                if res[i].name == name:
                    break
            else:
                i = len(res)
                res.append(Fn(name))
            res[i].data.append(a[len("    fn ") : -1])
    res = [a for a in res if a.name.startswith("__") or not a.name.startswith("_")]
    return res


class Struct:
    def __init__(self, name: str, l: list[str]):
        self.name = name
        self.data: str = l[0][:-1]
        self.methods: list[Fn] = find_methods(l)

    def __repr__(self) -> str:
        return f"Struct({self.name}, {self.data}, {self.methods})"

    def to_primitive(self) -> dict:
        return {"name": self.name, "data": self.data, "methods": [a.to_primitive() for a in self.methods]}


class Trait:
    def __init__(self, name: str, l: list[str]):
        self.name = name
        self.data: str = l[0][:-1]
        self.methods: list[Fn] = find_methods(l)

    def __repr__(self) -> str:
        return f"Trait({self.name}, {self.data}, {self.methods})"

    def to_primitive(self) -> dict:
        return {"name": self.name, "data": self.data, "methods": [a.to_primitive() for a in self.methods]}


class Alias:
    def __init__(self, name: str, l: list[str]):
        self.name = name
        assert len(l) == 1
        self.data: str = l[0][6:]

    def __repr__(self) -> str:
        return f"Alias({self.name}, {self.data})"

    def to_primitive(self) -> dict:
        return {"name": self.name, "data": self.data}


def to_oneline(lines: list[str]):
    br = {"}": "{", "]": "[", ")": "("}
    br_cnt = {"{": 0, "[": 0, "(": 0}
    res = [""]
    for l in lines:
        for c in l:
            if c in br_cnt:
                br_cnt[c] += 1
            if c in br:
                br_cnt[br[c]] -= 1
        if res[-1]:
            if res[-1].endswith(","):
                if l.strip().startswith(")") or l.strip().startswith("]"):
                    res[-1] = res[-1][:-1]
                else:
                    res[-1] = res[-1] + " "
            res[-1] += l.strip()
        else:
            res[-1] = l
        if sum(br_cnt.values()) == 0:
            res.append("")
    if res[-1] == "":
        res.pop()
    return res


ddd = set()


def read(path: Path) -> Module:
    res = Module(path.name[:-5])
    with open(path, "r") as f:
        lines = []
        for l in f.readlines():
            if l.rstrip():
                lines.append(l.rstrip())
    lines = to_oneline(lines)
    lines = [l for l in lines if not l.startswith("from ")]
    lines = [l for l in lines if not "@" in l]
    any_list: list[tuple[str, str, list[str]]] = []
    for l in lines:
        if l.startswith(" "):
            any_list[-1][2].append(l)
        else:
            any_list.append((l.split()[0], trim(l.split()[1]), [l]))
    any_list = [a for a in any_list if not a[1].startswith("_")]
    for ty, name, l in any_list:
        if ty == "alias":
            res.aliases.append(Alias(name, l))
        elif ty == "struct":
            res.structs.append(Struct(name, l))
        elif ty == "trait":
            res.traits.append(Trait(name, l))
        elif ty == "fn":
            for i in range(len(res.functions)):
                if res.functions[i].name == name:
                    break
            else:
                i = len(res.functions)
                res.functions.append(Fn(name))
            res.functions[i].data.append(l[0][3:-1])
    res.aliases.sort(key=attrgetter("name"))
    res.structs.sort(key=attrgetter("name"))
    res.traits.sort(key=attrgetter("name"))
    res.functions.sort(key=attrgetter("name"))
    return res


class Package:
    def __init__(self, name: str):
        self.name = name
        self.packages: list["Package"] = []
        self.modules: list[Module] = []

    def to_primitive(self) -> dict:
        return {
            "name": self.name,
            "packages": [a.to_primitive() for a in self.packages],
            "modules": [a.to_primitive() for a in self.modules],
        }


def read_pkg(src: Path) -> Package:
    res = Package(src.name)
    for i in src.iterdir():
        if i.name.startswith("_"):
            continue
        if i.is_dir():
            res.packages.append(read_pkg(i))
        else:
            assert i.name.endswith(".mojo")
            res.modules.append(read(i))
    res.packages.sort(key=attrgetter("name"))
    res.modules.sort(key=attrgetter("name"))
    return res


def main():
    import json

    x = read_pkg(Path("atcoder"))
    with open("tmp.json", "w") as f:
        json.dump(x.to_primitive(), f, indent=2)


if __name__ == "__main__":
    main()
