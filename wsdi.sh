#!/bin/bash
# Created: Thursday, July 27 2017

#
# Warm spell days index (WSDI)
# Warm spell days index w.r.t. 90th percentile of reference period
# a time series of the daily mean temperature
#

set -x
THIS_FILE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_FILE_DIR/fun.bash

var=tas
models=(NorESM1-M IPSL-CM5A-LR CCSM4 CanESM2 GFDL-CM3 GFDL-ESM2M)
exmts=(historical historicalNat historicalGHG historicalMisc)

for exp in ${exmts[@]};
do
    cd ${THIS_FILE_DIR}/${exp}
    for model in "${models[@]}"
    do

        # calculate day 90th percentile
        y90pctl ${var} ${exp} ${model}

        # Calculate wsdi for each year and merge them
        ind_wsdi ${var} ${exp} ${model}
    done

    ensmean WSDI ${exp} ${models[@]}

    # Calculate trend.
    cdo -trend \
        -selyear,1951/2005 \
        ${exp}_WSDI_1900_2005_ensmean.nc \
        ${exp}_WSDI_1951-2005_mean.nc \
        ${exp}_WSDI_1951-2005_trend.nc
done
