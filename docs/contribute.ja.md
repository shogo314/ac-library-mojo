# コントリビュート

このページは開発中です。

## ライブラリ

[online-judge-tools/verification-helper](https://github.com/online-judge-tools/verification-helper) を使ってテストしています。

### インストール

```
pip3 install online-judge-verify-helper
```

### 準備

`.verify-helper/config.toml` というファイルを作って、内容を以下のようにしてください。

```
[languages.mojo]
compile = "magic run mojo build -o a.out {path} -I {basedir}"
execute = "./a.out"
bundle = "false"
list_dependencies = "python list_dependencies.py {path}"
verification_file_suffix = ".test.mojo"
```

### 実行

```
oj-verify run
```

初回は時間がかかります。

## ドキュメント

[MkDocs](https://www.mkdocs.org/) を使っています。
GitHub Actionsで自動化しているので `docs` を編集するだけでよいです。
