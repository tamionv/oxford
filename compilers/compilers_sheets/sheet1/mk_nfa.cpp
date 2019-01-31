#include <bits/stdc++.h>
using namespace std;

int main()
{
    ofstream g("nfa.dot");

    vector<string> strings =
    {
        "while",
        "do",
        "if",
        "then",
        "else",
        "end"
    };

    g << "digraph NFA {" << endl;

    int current_state = 1;
    g << "\t0[label=\"\" shape=\"point\"];" << endl;

    for(auto str : strings)
    {
        int father = 0, target_state = current_state + str.size() - 1;
        for(auto x : str)
        {
            if(current_state != target_state)
                g << "\t" << current_state << "[label=\"\" shape=\"point\"];" << endl;
            else
                g << "\t" << current_state << "[label=\"" << str << "\" shape=\"doublecircle\"];" << endl;
            g << "\t" << father << " -> " << current_state << " [label=\"" << x << "\"];" << endl;
            father = current_state++;
        }
    }

    g << "\t" << current_state << "[label=\"Identifier\" shape=\"doublecircle\"];" << endl;
    g << "\t0 -> " << current_state << " [label=\"a-zA-Z\"];";
    g << "\t" << current_state <<  " -> " << current_state << " [label=\"a-zA-Z\"];";
    g << "}" << endl;
    return 0;
}
