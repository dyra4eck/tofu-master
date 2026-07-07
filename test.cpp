#include <iostream>
#include <vector>

using namespace std;

int main() {
    int n;
    cin >> n;
    vector<long long> a(n);
    for (int i = 0; i < n; ++i) {
        cin >> a[i];
    }

    long long buy1, buy2, sell1, sell2;
    buy1 = -1 * __LONG_LONG_MAX__;
    buy2 = -1 * __LONG_LONG_MAX__;
    sell1 = 0;
    sell2 = 0;
    for (int i = 0; i < n; ++i) {
        buy1 = max(buy1, -a[i]);
        sell1 = max(sell1, buy1 + a[i]);
        buy2 = max(buy2, sell1 - a[i]);
        sell2 = max(sell2, buy2 + a[i]);
    }

    cout << sell2 << endl;
}