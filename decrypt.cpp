#include <bits/stdc++.h>
using namespace std;

/* backtrack through the first 6 characters of the message,
 * only setting a particular character if it would lead
 * to all characters encrypted with that key being valid (i.e. [a-zA-Z ])
 */
void backtrack(char cyphertext[36], int curr = 0){
    static bool is_good[256] = {}, done_preprocessing = false;
    static vector<char> good_chars;
    if(!done_preprocessing){
        char lhs[3] = {' ', 'a', 'A'},
             rhs[3] = {' ', 'z', 'Z'};
        for(int i = 0; i < 3; ++i)
            for(char ch = lhs[i]; ch <= rhs[i]; ++ch)
                is_good[(unsigned int)ch] = true,
                good_chars.push_back(ch);
        done_preprocessing = true;
    }

    static char message[37] = {};
    if(curr == 6) cout << message << '\n';
    else for(auto x : good_chars){
        message[curr] = x;
        bool good = true;
        for(int i = curr + 6; i < 36 && good; i += 6)
            message[i] = (cyphertext[i] ^ cyphertext[curr] ^ message[curr]),
            good = (good && is_good[(unsigned int)message[i]]);
        if(good) backtrack(cyphertext, curr + 1);
    }
}

int main(){
    ifstream f("a.txt");
    char cyphertext[36] = {};

    for(int i = 0, x; i < 36; ++i)
        f >> hex >> x,
        cyphertext[i] = x;

    backtrack(cyphertext);
    return 0;
}
