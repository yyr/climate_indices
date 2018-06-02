#!/bin/bash
# Created: Monday, May 28 2018

# set -x
THIS_FILE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_FILE_DIR/fun.bash

var=tasmin
# models=(NorESM1-M IPSL-CM5A-LR CCSM4 CanESM2 GFDL-CM3 GFDL-ESM2M) #
models=(GFDL-ESM2M) #
model=GFDL-ESM2M #
exmts=(historical historicalNat historicalGHG historicalMisc)
exp=historical

# ensmean CD historical ${models[@]}
y10pctl ${var} ${exp} ${model}
