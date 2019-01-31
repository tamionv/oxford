#include <bits/stdc++.h>
using namespace std;

// an enum that represents a direction.
enum class direction : char
    { left = 'L' , right = 'R' };

// a type that represents a state
using state =
    tuple <int, int, int, int, direction>;

// a type that represents an action
using action = pair<int, int>;

// a type that represents a path.
using path = pair<list<state>, list<action>>;

// the initial state
constexpr state initial_state =
    { 3 , 0 , 3 , 0 , direction::left };

// this pure function checks if a state is a goal
bool is_goal_state(state s){
    int x, y, z, t;
    direction d;
    tie(x, y, z, t, d) = s;

    return x == 0 && z == 0;
}

// this checks if a state is valid
// (i.e. respects the properties in the problem
// specification)
bool is_valid_state(state s){
    int x, y, z, t;
    direction d;
    tie(x, y, z, t, d) = s;

    return x + y == 3
        && z + t == 3
        && x >= 0
        && y >= 0
        && z >= 0
        && t >= 0
        && (x >= z || x == 0)
        && (y >= t || y == 0);
}

// this applies an action to a state
state result(state s, action act){
    int x, y, z, t;
    direction d;
    tie(x, y, z, t, d) = s;

    int a, b;
    tie(a, b) = act;

    if(d == direction::left)
        return make_tuple(x - a, y + a, z - b, t + b,
                    direction::right);
    else
        return make_tuple(x + a, y - a, z + b, t - b,
                    direction::left);
}


// thie function returns, for a given state,
// a list of applicable actions
list<action> actions(state s){
    int x, y, z, t;
    direction d;
    tie(x, y, z, t, d) = s;

    list<action> ret;

    for(int a = 0; a <= 2; ++a)
        for(int b = 0; b <= 2; ++b)
            if(0 < a + b && a + b <= 2
                && (a >= b || a == 0)
                && is_valid_state(result(s,
                            make_pair(a, b))))
                ret.emplace_back(a, b);
    return ret;
}

// this function finds, using bfs, the optimal path
// from the initial state to any goal state,
// returning it.
path bfs(){
    // the states we have visited so far
    set<state> visited_states;

    // a mapping from any visited state to the
    // state that comes before it in our bfs,
    // and the action used to get to it.
    map<state, pair<state, action>> previous_state;

    // the states we need to expand.
    queue<state> states_to_expand;

    // we initialise these with the initial state,
    // as this should automatically be visited:
    states_to_expand.push(initial_state);
    visited_states.insert(initial_state);

    // this will hold the goal state that we find
    state actual_goal;

    while(true){
        // s is the state we currently expand
        auto s = states_to_expand.front();
        states_to_expand.pop();

        if(is_goal_state(s)){
            actual_goal = s;
            break;
        }

        for(auto act : actions(s)){
            // s_ is the state which we now visit
            auto s_ = result(s, act);

            // do nothing if it is already visited
            if(visited_states.find(s_)
                    != end(visited_states))
                continue;

            // update the state to reflect
            // that we have visited s_
            visited_states.insert(s_);
            states_to_expand.push(s_);
            previous_state[s_] = make_pair(s, act);
        }
    }

    // now, to find the actual path
    path ret;

    // we start from the goal we found
    auto current_state = actual_goal;
    ret.first.push_back(actual_goal);

    // and repeatedly move backwards
    // until we reach the initial state
    while(current_state != initial_state){
        state prev;
        action act;

        tie(prev, act) = previous_state[current_state];

        // we the actions used, and the states visited
        // to the result path
        ret.first.push_front(prev);
        ret.second.push_front(act);

        current_state = prev;
    }

    return ret;
}

// this pretty-prints a state.
void print_state(state s){
    int x, y, z, t;
    direction d;
    tie(x, y, z, t, d) = s;

    for(int i = 0; i < 3; ++i)
        cout << (i < x ? 'M' : ' ');
    for(int i = 0; i < 3; ++i)
        cout << (i < z ? 'C' : ' ');

    if(d == direction::left)
        cout << ".|____|...................";
    else
        cout << "...................|____|.";

    for(int i = 0; i < 3; ++i)
        cout << (i < y ? 'M' : ' ');
    for(int i = 0; i < 3; ++i)
        cout << (i < t ? 'C' : ' ');

    cout << endl << endl;
}

// this pretty-prints an action
void print_action(state s, action a){
    int x, y, z, t;
    direction d;
    tie(x, y, z, t, d) = s;

    if(d == direction::left)
        x -= a.first,
        z -= a.second;
    else
        y -= a.first,
        t -= a.second;

    string canoestring;

    if(a.first == 1 && a.second == 0)
        canoestring = "|_M__|";
    if(a.first == 0 && a.second == 1)
        canoestring = "|_C__|";

    if(a.first == 2 && a.second == 0)
        canoestring = "|_MM_|";

    if(a.first == 1 && a.second == 1)
        canoestring = "|_MC_|";

    if(a.first == 0 && a.second == 2)
        canoestring = "|_CC_|";

    auto print_left_bank = [&](){
        for(int i = 0; i < 3; ++i)
            cout << (i < x ? 'M' : ' ');
        for(int i = 0; i < 3; ++i)
            cout << (i < z ? 'C' : ' ');
    };

    auto print_right_bank = [&](){
        for(int i = 0; i < 3; ++i)
            cout << (i < y ? 'M' : ' ');
        for(int i = 0; i < 3; ++i)
            cout << (i < t ? 'C' : ' ');
    };

    auto print_left_canoe = [&](){
        cout << "." << canoestring << "...................";
    };

    auto print_mid_canoe = [&](){
        cout << ".........." << canoestring << "..........";
    };

    auto print_right_canoe = [&](){
        cout << "..................." << canoestring << ".";
    };


    print_left_bank();

    if(d == direction::left)
        print_left_canoe();
    else
        print_right_canoe();

    print_right_bank();

    cout << endl;
    cout << endl;

    print_left_bank();
    print_mid_canoe();
    print_right_bank();

    cout << endl;
    cout << endl;

    print_left_bank();


    if(d == direction::left)
        print_right_canoe();
    else
        print_left_canoe();

    print_right_bank();
    cout << endl;
    cout << endl;
}

int main(){
    auto p = bfs();

    auto it1 = begin(p.first);
    auto it2 = begin(p.second);

    print_state(*it1);
    auto prev_state = *it1++;

    while(it1 != end(p.first)){
        print_action(prev_state, *it2++);
        print_state(prev_state = *it1++);
    }

    return 0;
}

