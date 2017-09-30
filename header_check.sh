#!/bin/bash
# Created: Friday, July 14 2017

for f in `ls $1/`; do
    echo $f
    cdo griddes $1/$f > tmp2
    diff tmp tmp2
    read n
done
