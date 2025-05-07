# TIPs

## このライブラリについて
このライブラリはAtCoderで使うためのライブラリです。そのためAtCoderにインストールされているバージョンに合わせて作成されます。現在 `25.3.0` に合わせて作成されています。AtCoderの言語設定に関する情報は以下の通りです。

### インストールスクリプト

```sh
# install magic
sudo apt install -y zlib1g-dev libncurses-dev
curl -ssL https://magic.modular.com/05e5251c-9cee-4d3a-92cd-030ee29845fb | bash

# install mojo
cat > mojoproject.toml << EOF
[project]
channels = ["conda-forge", "https://conda.modular.com/max", "https://repo.prefix.dev/modular-community"]
name = "mojo"
platforms = ["linux-64"]

[dependencies]
max = "=25.3.0"
EOF

export PATH="$PATH:$HOME/.modular/bin"
magic install

# install library
ACLIB_VERSION="0.4.0"
cd /tmp
wget https://github.com/shogo314/ac-library-mojo/archive/refs/tags/${ACLIB_VERSION}.tar.gz
tar -xvf ${ACLIB_VERSION}.tar.gz
mkdir -p $HOME/.local/lib/mojo
cp -r -f ac-library-mojo-${ACLIB_VERSION}/atcoder $HOME/.local/lib/mojo
```

このライブラリもインストールしているので、インストールされているバージョンはAtCoder上で利用できます。AtCoderにインストールされているものより新しいバージョンを利用したい方は `expander.py` をご活用ください。

### コンパイルスクリプト

```
export PATH="$PATH:$HOME/.modular/bin"
magic run mojo build Main.mojo -o a.out -I $HOME/.local/lib/mojo -D ATCODER -D ONLINE_JUDGE
```

1行目は大抵インストール時に `$HOME/.bashrc` などに書き込まれているので、不要である場合が多いです。

## コンパイル時定義の利用

AtCoder上のコンパイルコマンドでは `-D ATCODER` が付いており、これは以下のコードで確認できます。

```
import sys


fn main():
    print(sys.is_defined["ATCODER"]()) # True
```

AtCoderのサーバーでは環境変数が設定されており

```
import os


fn main():
    print(os.getenv("ATCODER")) # 1
```
