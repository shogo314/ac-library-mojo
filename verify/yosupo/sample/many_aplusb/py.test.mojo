# verification-helper: PROBLEM https://judge.yosupo.jp/problem/many_aplusb


fn main() raises:
    from python import Python

    var py = Python.import_module("builtins")
    var T = Int(String(py.input()))
    for _ in range(T):
        var tmp = String(py.input()).split(" ")
        var A = Int(tmp[0])
        var B = Int(tmp[1])
        print(A + B)
