#!/bin/bash
sed '/(\*\[\[/,$d' $1 > tmp2
mv tmp2 $1
./ppc -O2 $1 > tmp
echo "(*[[" >> $1
cat tmp >> $1
echo "]]*)" >> $1
rm tmp
