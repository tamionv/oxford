#include <bits/stdc++.h>
using namespace std;

using ll = long long;
using cd = complex<double>;

int tt[20] = {}, rk[20] = {};

int find(int x){
    return tt[x] == x ? x : tt[x] = find(tt[x]);
}

void merge(int x, int y){
    x = find(x), y = find(y);
    if(x == y) return;
    if(rk[x] <= rk[y]) swap(x, y);
    tt[y] = x;
    if(rk[x] == rk[y]) ++rk[x];
}
    

int main(){
    ios_base::sync_with_stdio(false);
    cin.tie(nullptr);

    for(int i = 1; i <= 16; ++i)
        tt[i] = i;
    for(int i = 1; i <= 15; i += 2)
        merge(i, i+1);
    for(int i = 1; i <= 13; i += 4)
        merge(i, i+2);
    merge(1, 5);
    merge(11, 13);
    merge(1, 10);
    find(2);
    find(9);

    cout << "digraph{" << endl;
    cout << "\trankdir=\"BT\"" << endl;
    for(int i = 1; i <= 16; ++i)
        cout << "\tx" << i << " -> x" << tt[i] << endl;
    cout << "}" << endl;

    return 0;
}

