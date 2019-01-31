#!/bin/bash

test_nr=100
test_size=100

echo "Input number of tests: "
read test_nr
if ! [[ "$test_nr" -gt 0 ]] ; then
    echo "Expected a positive integer; defaulting to 100"
    test_nr=100
fi

echo "Input test size: "
read test_size
if ! [[ "$test_size" -gt 0 ]] ; then
    echo "Expected a positive integer; defaulting to 100"
    test_size=100
fi

for i in {1..$test_nr}; do


done
