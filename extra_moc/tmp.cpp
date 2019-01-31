#include <bits/stdc++.h>
using namespace std;

using ll = long long;
using cd = complex<double>;

double term = 0, all = 0;

void run_experiment(int n){
    mt19937 mt{random_device()()};

    int x = 0, y = 1;
    while(true){
        if(bernoulli_distribution(1.0/n)(mt)){
            ++all;
            return;
        }
        if(bernoulli_distribution((n-x-1.0)/(n-1.0))(mt)){
            ++x, ++y;
        }
        else if(y == 1){
            ++term, ++all;
            return;
        }
        else{
            --y;
        }
    }
}

int main(){
    ios_base::sync_with_stdio(false);
    cin.tie(nullptr);


    while(true){
        run_experiment(1000);
        cout << term << "\t\t" << all << "\t\t" << term / all << endl;
    }
    return 0;
}

