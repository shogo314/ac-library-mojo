# ac-library-mojo Docs

---

## 📦 概要

**ac-library-mojo** は AtCoder の [ac-library](https://github.com/atcoder/ac-library) を Mojo 言語に移植したもので、競技プログラミング向けに設計された高性能なアルゴリズムライブラリです。

---

## 🚀 使い方

ac-library-mojo を使って、[Union Find](https://judge.yosupo.jp/problem/unionfind) の問題を解く例です。

```
from atcoder.io import IO
from atcoder.dsu import DSU

fn main() raises:
    var io = IO()
    var N = io.nextInt()
    var Q = io.nextInt()
    var dsu = DSU(N)

    for _ in range(Q):
        var t = io.nextInt()
        var u = io.nextInt()
        var v = io.nextInt()
        if t == 0:
            _ = dsu.merge(u, v)
        else:
            if dsu.same(u, v):
                print(1)
            else:
                print(0)
```

---

## 🤝 コントリビュート
貢献していただける方は、以下のガイドをご参照ください：

日本語ガイド 👉 [コントリビュート](contribute.md)

簡単な修正・Issueの提案・新機能の追加など、どんな貢献も歓迎します！

## 📄 License

このプロジェクトは `CC0-1.0` または `Apache-2.0` のデュアルライセンスです。どちらか一方を選んでご利用いただけます。

## 📬 Contact

ご質問・提案・雑談など、気軽にご連絡ください！

- 💬 Discord: [Join our Discord server](https://discord.gg/wGWCT3Tp7h)
