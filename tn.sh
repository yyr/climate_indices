#!/bin/bash
# Created: Thursday, July 27 2017

#
# Tropical Nights (TN)
# Tropical nights index per time period
# a time series of the daily minimum temperature
# input have to be given in units of Kelvin
#

# set -x
THIS_FILE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_FILE_DIR/fun.bash

var=tasmin
models=(NorESM1-M IPSL-CM5A-LR CCSM4 CanESM2 GFDL-CM3 GFDL-ESM2M)
exmts=(historical historicalNat historicalGHG historicalMisc)

for exp in ${exmts[@]};
do
    cd ${THIS_FILE_DIR}/${exp}
    for model in "${models[@]}"
    do
        # Calculate cold_nights indices merge time of indices
        ind_tn ${var} ${exp} ${model}
    done

    ensmean TN ${exp} ${models[@]}

    # Calculate trend.
    cdo -trend \
        -selyear,1951/2005 \
        ${exp}_TN_1900_2005_ensmean.nc \
        ${exp}_TN_1951-2005_mean.nc \
        ${exp}_TN_1951-2005_trend.nc
done
