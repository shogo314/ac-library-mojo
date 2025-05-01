class Fn:
    def __init__(self, name: str, data: list[str]):
        self.name = name
        self.data = data
        self.description = {}
        self.constraints = {}
        self.complexity = {}

    def __repr__(self) -> str:
        return f"Fn({repr(self.name)}, {repr(self.data)})"

    def to_primitive(self) -> dict:
        return {"name": self.name, "data": self.data}


class Struct:
    def __init__(self, name: str, data: str, methods: list[Fn]):
        self.name = name
        self.data = data
        self.description = {}
        self.methods = methods

    def __repr__(self) -> str:
        return f"Struct({self.name}, {self.data}, {self.methods})"

    def to_primitive(self) -> dict:
        return {"name": self.name, "data": self.data, "methods": [a.to_primitive() for a in self.methods]}


class Trait:
    def __init__(self, name: str, data: str, methods: list[Fn]):
        self.name = name
        self.data = data
        self.description = {}
        self.methods = methods

    def __repr__(self) -> str:
        return f"Trait({self.name}, {self.data}, {self.methods})"

    def to_primitive(self) -> dict:
        return {"name": self.name, "data": self.data, "methods": [a.to_primitive() for a in self.methods]}


class Alias:
    def __init__(self, name: str, data: str):
        self.name = name
        self.data = data

    def __repr__(self) -> str:
        return f"Alias({self.name}, {self.data})"

    def to_primitive(self) -> dict:
        return {"name": self.name, "data": self.data}


class Module:
    def __init__(self, name):
        self.name = name
        self.description = {}
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


class Package:
    def __init__(self, name: str):
        self.name = name
        self.description = {}
        self.packages: list["Package"] = []
        self.modules: list[Module] = []

    def to_primitive(self) -> dict:
        return {
            "name": self.name,
            "packages": [a.to_primitive() for a in self.packages],
            "modules": [a.to_primitive() for a in self.modules],
        }
