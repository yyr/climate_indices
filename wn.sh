#!/bin/bash
# Created: Thursday, July 27 2017

#
# Warm Nights (WN)
# Warm nights percent w.r.t. 90th percentile of reference period
# a time series of the daily minimum temperature should be used.,
#

set -x
THIS_FILE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_FILE_DIR/fun.bash

var=tasmin
models=(NorESM1-M IPSL-CM5A-LR CCSM4 CanESM2 GFDL-CM3 GFDL-ESM2M)
exmts=(historical historicalNat historicalGHG historicalMisc)

for exp in ${exmts[@]};
do
    cd ${THIS_FILE_DIR}/${exp}

    set +x
    for model in "${models[@]}"
    do
        y90pctl ${var} ${exp} ${model}

        # Calculate warm nights index for each year and merge them
        ind_wn ${var} ${exp} ${model}
    done
    set -x

    ensmean WN ${exp} ${models[@]}
    ensmean WND ${exp} ${models[@]}

    # Calculate trend.
    cdo -trend \
        -selyear,1951/2005 \
        ${exp}_WN_1900_2005_ensmean.nc \
        ${exp}_WN_1951-2005_mean.nc \
        ${exp}_WN_1951-2005_trend.nc
    cdo -trend \
        -selyear,1951/2005 \
        ${exp}_WND_1900_2005_ensmean.nc \
        ${exp}_WND_1951-2005_mean.nc \
        ${exp}_WND_1951-2005_trend.nc
done
