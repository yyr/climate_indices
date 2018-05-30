#!/bin/bash
# Created: Thursday, July 27 2017

#
# Cold-spell days index (CSDI)
# Cold-spell days index w.r.t. 10th percentile of reference period
# Time series of the daily mean temperature TG
#

# set -x
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

        # Calculate cold_nights indices merge time of indices
        ind_csdi ${var} ${exp} ${model}
    done

    ensmean CSDI ${exp} ${models[@]}

    # Calculate trend.
    cdo -trend \
        -selyear,1951/2005 \
        ${exp}_CSDI_1900_2005_ensmean.nc \
        ${exp}_CSDI_1951-2005_mean.nc \
        ${exp}_CSDI_1951-2005_trend.nc
done
