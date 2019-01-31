#include <bits/stdc++.h>
using namespace std;

int main()
{
    ofstream g("dfa.dot");

    vector<string> strings =
    {
        "while",
        "do",
        "if",
        "then",
        "else",
        "end"
    };

    g << "digraph DFA {" << endl;

    map<string, int> states;
    int current_state = 2;
    states[""] = current_state;
    g << "\t" << current_state++ << "[label=\"\" shape=\"point\"];" << endl;

    g << "\t0[label=\"dustbin\" shape=\"circle\"];" << endl;
    g << "\t1[label=\"Identifier\" shape=\"circle\"];" << endl;

    for(auto str : strings)
    {
        string str_;
        for(auto x : str)
        {
            str_.push_back(x);
            if(states.find(str_) == end(states))
            {
                states[str_] = current_state;
                if(str != str_)
                    g << "\t" << current_state << "[label=\"\" shape=\"point\"];" << endl;
                else
                    g << "\t" << current_state << "[label=\"" << str << "\" shape=\"doublecircle\"];" << endl;
                current_state++;
            }
        }
    }
    map<int, map<int, string>> edges;
    for(auto pref_pair : states)
    {
        auto pref = pref_pair.first;
        for(auto ch = 'a'; ch <= 'z'; ++ch)
        {
            pref.push_back(ch);
            if(states.find(pref) != end(states))
                edges[pref_pair.second][states[pref]].push_back(ch);
            else
                edges[pref_pair.second][1].push_back(ch);
            pref.pop_back();
        }
    }

    for(auto x : edges)
    {
        for(auto y : x.second)
        {
            bool rev = false;
            if(y.second.size() > 13){
                rev = true;
                string str_;
                sort(begin(y.second), end(y.second));
                for(char ch = 'a'; ch <= 'z'; ++ch)
                    if(!binary_search(begin(y.second), end(y.second), ch))
                        str_.push_back(ch);
                y.second = str_;
            }

            string interspersed;
            if(y.second.empty())
                interspersed = "a-zA-Z", rev = false;
            else{
                interspersed.push_back(y.second[0]);
                for(int i = 1; i < y.second.size(); ++i)
                {
                    interspersed.push_back(',');
                    interspersed.push_back(y.second[i]);
                }
            }
            g << "\t" << x.first << " -> " << y.first << " [label=\"" << (rev ?  "[^" : "") << interspersed << (rev ? "]" : "") << "\"];" << endl;
        }
    }



    g << "\t1 -> 1 [label=\"a-zA-Z\"];" << endl;
    g << "}" << endl;
    return 0;
}
