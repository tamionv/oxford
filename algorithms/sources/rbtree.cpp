#include <bits/stdc++.h>
using namespace std;

class rb_tree{
    enum color { red = 1, black = 0};

    struct node{
        node *l, *r, *f;
        int x;
        color c;
    };

    node *brother(node *x){
        assert(x->f != nullptr);

        if(x->f->l == x)
            return x->f->r;
        else
            return x->f->l;
    }

    node *uncle(node *x){
        assert(x->f != nullptr);
        return brother(x->f);
    }

    void set_son(node *n, node* node::*which, node *s){
        n->*which = s;
        s->f = n;
    }

    node *left_rotate(node *a, node *b){
        assert(a->r == b);

        node *alpha = a->l,
             *beta = b->l,
             *gamma = b->r;

        set_son(a, &node::l, alpha);
        set_son(a, &node::r, beta);
        set_son(b, &node::l, a);
        set_son(b, &node::r, gamma);

        return a;
    }

    node *right_rotate(node *a, node *b){
        assert(b->l == a);

        node *alpha = a->l,
             *beta = a->r,
             *gamma = b->r;

        set_son(a, &node::l, alpha);
        set_son(a, &node::r, b);
        set_son(b, &node::l, beta);
        set_son(b, &node::r, gamma);

        return b;
    }

    node *rotate_with_father(node *n){
        assert(n->f);
        return n->f->l == n
            ? right_rotate(n, n->f)
            : left_rotate(n->f, n);
    }

    void insert_fixup(node *n){
        assert(n->c == red);
        if(n->f == nullptr)
            n->c = black;
        else if(n->f->c == black);
        else if(n->f->c == red && uncle(n)->c == red){
            n->f->c = uncle(n)->c = black;
            n->f->f->c = red;
            insert_fixup(n->f->f);
        }
        else if(n->f->c == red && uncle(n)->c == black){
            if((n->f->f->l == n->f && n->f->r == n) ||
                (n->f->r == n->f && n->f->l == n))
                n = rotate_with_father(n);
            swap(n->f->f->c, n->f->c);
            rotate_with_father(n->f);
        }
    }

public:
    void insert(int x);
    void remove(int x);
};
