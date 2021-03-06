#!/bin/bash
# Created: Thursday, July 27 2017

# ECAR95PTOT - Precipitation percent due to R95p days
# eca_r95ptot infile1 infile2 outfile

# Description
# Let infile1 be a time series RR of the daily precipitation amount at wet
# days (precipitation >= 1 mm) and infile2 be the 95th percentile RRn95 of the
# daily precipitation amount at wet days for any period used as
# reference. Then the ratio of the precipitation sum at wet days with RR >
# RRn95 to the total precipitation sum is calculated. RRn95 is calculated as
# the 95th percentile of all wet days of a given climate reference
# period. Usually infile2 is generated by the operator ydaypctl,95. The date
# information of a timestep in outfile is the date of the last contributing
# timestep in infile1.  The following variables are created:
# • precipitation percent due to R95p days

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
        y95pctl ${var} ${exp} ${model}

        ind_ptot ${var} ${exp} ${model}
    done
    set -x

    ensmean PTOT ${exp} ${models[@]}
    cdo -trend \
        -selyear,1951/2005 \
        ${exp}_PTOT_1900_2005_ensmean.nc \
        ${exp}_PTOT_1951-2005_mean.nc \
        ${exp}_PTOT_1951-2005_trend.nc
done
