#!/bin/bash
# Created: Thursday, July 27 2017

# Cold Days (CD)
# Cold days percent w.r.t. 10th percentile of reference period.
# daily mean Temperature.
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
        # calculate day 10th percentile
        y10pctl ${var} ${exp} ${model}

        # Calculate cold days index and merge time
        ind_cd ${var} ${exp} ${model}
    done

    ensmean CD ${exp} ${models[@]}
    ensmean CDD ${exp} ${models[@]}

    # Calculate trend.
    cdo -trend \
        -selyear,1951/2005 \
        ${exp}_CD_1900_2005_ensmean.nc \
        ${exp}_CD_1951-2005_mean.nc \
        ${exp}_CD_1951-2005_trend.nc

    cdo -trend -selyear,1951/2005 \
        ${exp}_CDD_1900_2005_ensmean.nc \
        ${exp}_CDD_1951-2005_mean.nc \
        ${exp}_CDD_1951-2005_trend.nc
done
