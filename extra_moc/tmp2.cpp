#include <bits/stdc++.h>
using namespace std;

using ll = long long;
using cd = complex<double>;

bool bfs(int n){
    default_random_engine mt{random_device()()};

    vector<int> viz(n, false);
    stack<int, vector<int>> de_viz;
    de_viz.push(0);
    viz[0] = 1;

    while(!de_viz.empty()){
        const auto tmp = de_viz.top();
        de_viz.pop();
        if(tmp == 1) return false;
        for(int i = 0; i < 2; ++i){
            auto next = uniform_int_distribution<int>(0, n-1)(mt);
            if(viz[next]) continue;
            viz[next] = true;
            de_viz.push(next);
        }
    }
    return true;
}

int main(){
    ios_base::sync_with_stdio(false);
    cin.tie(nullptr);

    double all = 0, term = 0;

    while(true){
        if(bfs(1000000)) ++term;
        ++all;
        cout << term << "\t\t" << all << "\t\t" << term / all << endl;
    }

    return 0;
}

