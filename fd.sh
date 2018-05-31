#!/bin/bash
# Created: Thursday, July 27 2017

#
# Frost days index per time period
# daily minimum temperature
# tasmin should be in Kelvin
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
        # Calculate Frost Days index and merge time of indices
        ind_fd ${var} ${exp} ${model}
    done
    set -x

    ensmean FD ${exp} ${models[@]}

    # Calculate trend.
    cdo -trend \
        -selyear,1951/2005 \
        ${exp}_FD_1900_2005_ensmean.nc \
        ${exp}_FD_1951-2005_mean.nc \
        ${exp}_FD_1951-2005_trend.nc
done
