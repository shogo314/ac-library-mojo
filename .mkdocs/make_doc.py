from pathlib import Path
from class_impl import Fn, Alias, Struct, Trait, Module, Package
import sys
from io import TextIOWrapper

LANGUAGE_LIST = ["ja", "en"]
CONSTRAINTS = {"ja": "制約"}
COMPLEXITY = {"ja": "計算量"}


def get_same_name(d: list[dict] | None, name: str) -> dict | None:
    if d is None:
        return None
    for i in range(len(d)):
        if d[i]["name"] == name:
            return d[i]
    else:
        return None


def load(t: type, x: dict, dc: dict | None = None):
    assert dc is None or x["name"] == dc["name"]
    if t is Package:
        res = Package(x["name"])
        for a in x["packages"]:
            if type(dc) is dict:
                d = get_same_name(dc.get("packages"), a["name"])
            else:
                d = None
            res.packages.append(load(Package, a, d))
        for a in x["modules"]:
            if type(dc) is dict:
                d = get_same_name(dc.get("modules"), a["name"])
            else:
                d = None
            res.modules.append(load(Module, a, d))
        return res
    elif t is Module:
        res = Module(x["name"])
        if type(dc) is dict:
            res.description = dc.get("description", {})
        for a in x["aliases"]:
            if type(dc) is dict:
                d = get_same_name(dc.get("aliases"), a["name"])
            else:
                d = None
            res.aliases.append(load(Alias, a, d))
        for a in x["structs"]:
            if type(dc) is dict:
                d = get_same_name(dc.get("structs"), a["name"])
            else:
                d = None
            res.structs.append(load(Struct, a, d))
        for a in x["traits"]:
            if type(dc) is dict:
                d = get_same_name(dc.get("traits"), a["name"])
            else:
                d = None
            res.traits.append(load(Trait, a, d))
        for a in x["functions"]:
            if type(dc) is dict:
                d = get_same_name(dc.get("functions"), a["name"])
            else:
                d = None
            res.functions.append(load(Fn, a, d))
        return res
    elif t is Alias:
        return Alias(x["name"], x["data"])
    elif t is Fn:
        res = Fn(x["name"], x["data"])
        if type(dc) is dict:
            res.description = dc.get("description", {})
            res.constraints = dc.get("constraints", {})
            res.complexity = dc.get("complexity", {})
        return res
    elif t is Struct:
        res = Struct(x["name"], x["data"], [])
        if type(dc) is dict:
            res.description = dc.get("description", {})
        for a in x["methods"]:
            if type(dc) is dict:
                d = get_same_name(dc.get("methods"), a["name"])
            else:
                d = None
            res.methods.append(load(Fn, a, d))
        return res
    elif t is Trait:
        res = Trait(x["name"], x["data"], [])
        if type(dc) is dict:
            res.description = dc.get("description", {})
        for a in x["methods"]:
            if type(dc) is dict:
                d = get_same_name(dc.get("methods"), a["name"])
            else:
                d = None
            res.methods.append(load(Fn, a, d))
        return res
    else:
        assert False


def breadcrumbs_list(path: Path) -> str:
    name_list = str(path).split("/")
    if name_list[-1].endswith(".md"):
        name_list[-1] = name_list[-1][:-3]
    path_list = ["", "./index.md"]
    for i in range(2, len(name_list)):
        path_list.append("../" * (i - 1) + "index.md")
    path_list.reverse()
    if name_list[-1] == "index":
        name_list.pop()
        path_list.pop()
        path_list[-1] = ""
    name_list[0] = "APIs"
    return " > ".join(f"[{n}]({p})" for n, p in zip(name_list, path_list))


def output(path: Path, s: str):
    s = breadcrumbs_list(path) + "\n\n" + s
    ja_path = path.parent.joinpath(path.name[:-2] + "ja.md")
    en_path = path.parent.joinpath(path.name[:-2] + "en.md")
    with ja_path.open("w") as f:
        f.write(s)
    with en_path.open("w") as f:
        f.write(s)


def open_files(path: Path) -> list[TextIOWrapper]:
    res = [open(path.parent.joinpath(path.name[:-2] + l + ".md"), "w") for l in LANGUAGE_LIST]
    for a in res:
        a.write(breadcrumbs_list(path) + "\n\n")
    return res


def struct(path: Path, st: Struct, indent):
    print(" " * indent + "- " + path.stem + ": " + str(path))
    # print("Struct(", st.name, ",", st.description, ")", file=sys.stderr)
    f = open_files(path)
    for a, lg in zip(f, LANGUAGE_LIST):
        a.write("# " + st.name + "\n")
        a.write("\n```\n")
        a.write(st.data)
        a.write("\n```\n")
        if lg in st.description:
            a.write("\n" + st.description[lg].strip() + "\n")
        if st.methods:
            a.write("\n## Methods\n")
            for m in st.methods:
                a.write("\n### `" + m.name + "`\n")
                a.write("\n```\n")
                for l in m.data:
                    a.write(l + "\n")
                a.write("```\n")
                if lg in m.description:
                    a.write("\n" + m.description[lg].strip() + "\n")
                if lg in m.constraints:
                    a.write("\n**" + CONSTRAINTS[lg] + "**\n")
                    a.write("\n" + m.constraints[lg].strip() + "\n")
                if lg in m.complexity:
                    a.write("\n**" + COMPLEXITY[lg] + "**\n")
                    a.write("\n" + m.complexity[lg].strip() + "\n")
        a.close()


def trait(path: Path, tr: Trait, indent):
    print(" " * indent + "- " + path.stem + ": " + str(path))
    f = open_files(path)
    for a, lg in zip(f, LANGUAGE_LIST):
        a.write("# " + tr.name + "\n")
        a.write("\n```\n")
        a.write(tr.data)
        a.write("\n```\n")
        if tr.methods:
            a.write("\n## Methods\n")
            for m in tr.methods:
                a.write("\n### `" + m.name + "`\n")
                a.write("\n```\n")
                for l in m.data:
                    a.write(l + "\n")
                a.write("```\n")
        a.close()


def func(path: Path, fn: Fn, indent):
    print(" " * indent + "- " + path.stem + ": " + str(path))
    # print("Fn(", fn.name, ",", fn.description, ",", fn.constraints, ",", fn.complexity, ")", file=sys.stderr)
    f = open_files(path)
    for a, lg in zip(f, LANGUAGE_LIST):
        a.write("# " + fn.name + "\n\n```\n")
        for x in fn.data:
            a.write(x + "\n")
        a.write("```\n")
        if lg in fn.description:
            a.write("\n" + fn.description[lg].strip() + "\n")
        if lg in fn.constraints:
            a.write("\n**" + CONSTRAINTS[lg] + "**\n")
            a.write("\n" + fn.constraints[lg].strip() + "\n")
        if lg in fn.complexity:
            a.write("\n**" + COMPLEXITY[lg] + "**\n")
            a.write("\n" + fn.complexity[lg].strip() + "\n")
        a.close()


def module(path: Path, md: Module, indent):
    path.mkdir()
    print(" " * indent + "- " + path.name + ":")
    print(" " * (indent + 2) + "- " + str(path.joinpath("index.md")))
    if md.structs:
        for st in md.structs:
            struct(path.joinpath(st.name + ".md"), st, indent + 2)
    if md.traits:
        for tr in md.traits:
            trait(path.joinpath(tr.name + ".md"), tr, indent + 2)
    if md.functions:
        for fn in md.functions:
            func(path.joinpath(fn.name + ".md"), fn, indent + 2)
    f = open_files(path.joinpath("index.md"))
    for a, lg in zip(f, LANGUAGE_LIST):
        a.write("# " + md.name + "\n")
        if lg in md.description:
            a.write("\n" + md.description[lg].strip() + "\n")
        if md.aliases:
            a.write("\n## Aliases\n\n")
            for al in md.aliases:
                a.write("- `" + al.data + "`\n")
        if md.structs:
            a.write("\n## Structs\n\n")
            for st in md.structs:
                a.write(f"- [`{st.name}`](./{st.name}.md)\n")
        if md.traits:
            a.write("\n## Traits\n\n")
            for tr in md.traits:
                a.write(f"- [`{tr.name}`](./{tr.name}.md)\n")
        if md.functions:
            a.write("\n## Functions\n\n")
            for fn in md.functions:
                a.write(f"- [`{fn.name}`](./{fn.name}.md)\n")
        a.close()


def package(path: Path, pk: Package, indent=0):
    path.mkdir()
    print(" " * indent + "- " + path.name + ":")
    print(" " * (indent + 2) + "- " + str(path.joinpath("index.md")))
    s = "# " + pk.name + "\n"
    if pk.packages:
        s += "\n## Packages\n\n"
        for p in pk.packages:
            name = p.name
            package(path.joinpath(name), p, indent + 2)
            s += f"- [{name}](./{name}/index.md)\n"
    if pk.modules:
        s += "\n## Modules\n\n"
        for m in pk.modules:
            name = m.name
            module(path.joinpath(name), m, indent + 2)
            s += f"- [{name}](./{name}/index.md)\n"
    output(path.joinpath("index.md"), s)


def main():
    import json
    import shutil

    with open(".mkdocs/docs.py", "r") as f:
        dc = eval(f.read())
    with open(".mkdocs/tmp.json", "r") as f:
        pk = load(Package, json.load(f), dc)

    # assert not Path("apis").exists()
    if Path("apis").exists():
        shutil.rmtree("apis")
    package(Path("apis"), pk)


if __name__ == "__main__":
    main()
