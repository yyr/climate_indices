#!/bin/bash
# Created: Thursday, May 31 2018

THIS_FILE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_FILE_DIR/fun.bash

vars=(tas tasmin)
models=(NorESM1-M IPSL-CM5A-LR CCSM4 CanESM2 GFDL-CM3 GFDL-ESM2M)
exmts=(historical historicalNat historicalGHG historicalMisc)


for var in ${vars[@]};
do
    echo $var
    for exp in ${exmts[@]};
    do
        cd ${THIS_FILE_DIR}/${exp}
        for model in "${models[@]}";
        do
            y90pctl ${var} ${exp} ${model}
        done
    done
done
