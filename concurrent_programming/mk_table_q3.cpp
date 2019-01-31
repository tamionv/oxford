#include <iostream>
using namespace std;

void write_for_config(int c){
    cout << "\\begin{tabular}{|ll|l|}" << endl;
    cout << "\\hline" << endl;
    cout << "Thread of p & Thread of q & Value of x after operation \\\\" << endl;
    cout << "\\hline" << endl;

    int x = 0;
    int step[2] = {0, 0}, stx[2] = {};

    for(int i = 0; i < 6; ++i){
        int which = (c >> i)&1;
        if(which == 0){
            if(step[0] == 0 || step[0] == 2){
                cout << "LD x & & " << x << " \\\\" << endl;
                stx[0] = x;
            }
            else{
                if(step[0] == 1) x = stx[0] + 1;
                else x = stx[0] + 2;
                cout << "ST x & & " << x << " \\\\" << endl;
            }
        }
        else{
            if(step[1] == 0){
                cout << "& LD x &" << x << " \\\\" << endl;
                stx[1] = x;
            }
            else{
                x = stx[1] + 4;
                cout << "& ST x & " << x << " \\\\" << endl;
            }
        }
        ++step[which];
        cout << "\\hline" << endl;
    }
    cout << "\\end{tabular}" << endl;
    cout << "\\\\" << endl;
}

int main(){
    for(int i = 0; (i>>6) == 0; ++i)
        if(__builtin_popcount(i) == 2)
            write_for_config(i);

    return 0;
}
