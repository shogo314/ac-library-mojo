# コントリビュート

このページは開発中です。

## ライブラリ

[online-judge-tools/verification-helper](https://github.com/online-judge-tools/verification-helper) を使ってテストしています。

### インストール

```
pip3 install online-judge-verify-helper
```

### 実行

```
oj-verify run
```

初回は時間がかかります。

## ドキュメント

[MkDocs](https://www.mkdocs.org/) を使っています。
GitHub Actionsで自動化しているので `docs` を編集するだけでよいです。

手元でページを見たい場合は以下を参考にしてください。

### インストール

```
pip3 install mkdocs mkdocs-material mkdocs-static-i18n markdown-katex pymdown-extensions mike
```

### 実行

```
mkdocs serve
```
