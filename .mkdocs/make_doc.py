from pathlib import Path


def breadcrumbs_list(path: Path) -> str:
    name_list = str(path).split("/")
    path_list = ["", "./index.md"]
    for i in range(2, len(name_list)):
        path_list.append("../" * (i - 1) + "index.md")
    path_list.reverse()
    if name_list[-1] == "index.md":
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


def struct(path: Path, st: dict, indent):
    print(" " * indent + "- " + path.stem + ": " + str(path))
    s = "# " + st["name"] + "\n"
    s += "\n```\n"
    s += st["data"]
    s += "\n```\n"
    if st["methods"]:
        s += "\n## Methods\n"
        for m in st["methods"]:
            s += "\n### `" + m["name"] + "`\n"
            s += "\n```\n"
            for l in m["data"]:
                s += l + "\n"
            s += "```\n"
    output(path, s)


def trait(path: Path, tr: dict, indent):
    print(" " * indent + "- " + path.stem + ": " + str(path))
    s = "# " + tr["name"] + "\n"
    s += "\n```\n"
    s += tr["data"]
    s += "\n```\n"
    if tr["methods"]:
        s += "\n## Methods\n"
        for m in tr["methods"]:
            s += "\n### `" + m["name"] + "`\n"
            s += "\n```\n"
            for l in m["data"]:
                s += l + "\n"
            s += "```\n"
    output(path, s)


def func(path: Path, fn: dict, indent):
    print(" " * indent + "- " + path.stem + ": " + str(path))
    s = "# " + fn["name"] + "\n"
    s += "\n```\n"
    for l in fn["data"]:
        s += l + "\n"
    s += "```\n"
    output(path, s)


def module(path: Path, md: dict, indent):
    path.mkdir()
    print(" " * indent + "- " + path.name + ":")
    print(" " * (indent + 2) + "- " + str(path.joinpath("index.md")))
    s = "# " + md["name"] + "\n"
    if md["aliases"]:
        s += "\n## Aliases\n\n"
        for al in md["aliases"]:
            s += "- `" + al["data"] + "`\n"
    if md["structs"]:
        s += "\n## Structs\n\n"
        for st in md["structs"]:
            name = st["name"]
            struct(path.joinpath(name + ".md"), st, indent + 2)
            s += f"- [`{name}`](./{name}.md)\n"
    if md["traits"]:
        s += "\n## Traits\n\n"
        for tr in md["traits"]:
            name = tr["name"]
            trait(path.joinpath(name + ".md"), tr, indent + 2)
            s += f"- [`{name}`](./{name}.md)\n"
    if md["functions"]:
        s += "\n## Functions\n\n"
        for fn in md["functions"]:
            name = fn["name"]
            func(path.joinpath(name + ".md"), fn, indent + 2)
            s += f"- [`{name}`](./{name}.md)\n"
    output(path.joinpath("index.md"), s)


def package(path: Path, pk: dict, indent=0):
    path.mkdir()
    print(" " * indent + "- " + path.name + ":")
    print(" " * (indent + 2) + "- " + str(path.joinpath("index.md")))
    s = "# " + pk["name"] + "\n"
    if pk["packages"]:
        s += "\n## Packages\n\n"
        for p in pk["packages"]:
            name = p["name"]
            package(path.joinpath(name), p, indent + 2)
            s += f"- [{name}](./{name}/index.md)\n"
    if pk["modules"]:
        s += "\n## Modules\n\n"
        for m in pk["modules"]:
            name = m["name"]
            module(path.joinpath(name), m, indent + 2)
            s += f"- [{name}](./{name}/index.md)\n"
    output(path.joinpath("index.md"), s)


def main():
    import json
    import shutil

    with open(".mkdocs/tmp.json", "r") as f:
        pk = json.load(f)

    assert not Path("apis").exists()
    # if Path("apis").exists():
    #     shutil.rmtree("apis")
    package(Path("apis"), pk)


if __name__ == "__main__":
    main()
