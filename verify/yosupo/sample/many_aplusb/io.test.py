# verification-helper: PROBLEM https://judge.yosupo.jp/problem/many_aplusb

import sys

def main():
    for _ in range(int(sys.stdin.readline())):
        a, b = map(int, sys.stdin.readline().split())
        print(a + b)


if __name__ == "__main__":
    main()
