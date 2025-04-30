#define PROBLEM "https://judge.yosupo.jp/problem/many_aplusb"

#include <iostream>

int main() {
    std::ios_base::sync_with_stdio(false);
    std::cin.tie(0);
    int T;
    std::cin >> T;
    for (int i = 0; i < T; i++) {
        long long A, B;
        std::cin >> A >> B;
        std::cout << A + B << '\n';
    }
}
