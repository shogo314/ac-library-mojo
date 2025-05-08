{
    "name": "atcoder",
    "packages": [
        {
            "name": "cpp",
            "description": {
                "ja": """
C++の標準ライブラリにある便利な機能を実装する。
"""
            },
        },
        {
            "name": "py",
            "description": {
                "ja": """
Python 3の標準ライブラリにある便利な機能を実装する。
"""
            },
        },
    ],
    "modules": [
        {
            "name": "convolution",
            "description": {
                "ja": """
畳み込みを行う。数列 $`a_0, a_1, \dots, a_{N - 1}`$ と数列 $`a_0, a_1, \dots, a_{M - 1}`$ から、長さ $`N + M - 1`$ の数列

```math
c_i = \sum_{j=0}^{i} {a_j b_{i-j}}
```

を計算する。
"""
            },
            "functions": [
                {
                    "name": "convolution_int",
                    "description": {
                        "ja": """
畳み込みを計算する。$`a, b`$ の少なくとも一方が空配列の場合は空配列を返す。
"""
                    },
                    "constraints": {
                        "ja": """
- $`|a| + |b| - 1 \le 2^{24}`$
- 畳み込んだ後の配列の要素が全て `Int` に収まる
"""
                    },
                    "complexity": {
                        "ja": """
$`n = |a| + |b|`$ として

- $`O(n \log n)`$
"""
                    },
                },
                {
                    "name": "convolution_mod",
                    "description": {
                        "ja": """
畳み込みを mod $`m`$ で計算する。$`a, b`$ の少なくとも一方が空配列の場合は空配列を返す。
"""
                    },
                    "constraints": {
                        "ja": """
- $`2 \le m \le 2 \\times 10^9`$
- $`m`$ は素数
- $`2^c | (m - 1)`$ かつ $`|a| + |b| - 1 \le 2^c`$ なる $`c`$ が存在する。
"""
                    },
                    "complexity": {
                        "ja": """
$`n = |a| + |b|`$ として

- $`O(n \log n + \log m)`$
"""
                    },
                },
            ],
        },
        {
            "name": "dsu",
            "structs": [
                {
                    "name": "DSU",
                    "description": {
                        "ja": """
素集合データ構造
"""
                    },
                    "methods": [
                        {
                            "name": "__init__",
                            "description": {
                                "ja": """
$`n`$ 頂点 $`0`$ 辺の無向グラフを作る。
"""
                            },
                            "constraints": {
                                "ja": """
- $`0 \le n \le 10^8`$
"""
                            },
                            "complexity": {
                                "ja": """
- $`O(n)`$
"""
                            },
                        },
                        {
                            "name": "merge",
                            "description": {
                                "ja": """
辺 $`(a, b)`$ を足す。

$`a, b`$ が連結だった場合はその代表元、非連結だった場合は新たな代表元を返す。
"""
                            },
                            "constraints": {
                                "ja": """
- $`0 \le a \lt n`$
- $`0 \le b \lt n`$
"""
                            },
                            "complexity": {
                                "ja": """
- 償却 $`O(\\alpha(n))`$
"""
                            },
                        },
                    ],
                }
            ],
        },
    ],
}
