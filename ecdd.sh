#!/bin/bash
# Created: Saturday, June  2 2018

# ECACDD - Consecutive dry days index per time period
# eca_cdd[,R=1[,N=5]] infile outfile
# Description
# Let infile be a time series of the daily precipitation amount RR, then the
# largest number of consec- utive days where RR is less than R is counted. R
# is an optional parameter with default R = 1 mm. A further output variable is
# the number of dry periods of more than N days. The date information of a
# timestep in outfile is the date of the last contributing timestep in
# infile. The following variables are created:
# • consecutive dry days index per time period
# • number of cdd periods with more than <N>days per time period

set -x
THIS_FILE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_FILE_DIR/fun.bash
var=pr

models=(NorESM1-M IPSL-CM5A-LR CCSM4 CanESM2 GFDL-CM3 GFDL-ESM2M)
exmts=(historical historicalNat historicalGHG historicalMisc)

for exp in ${exmts[@]};
do
    cd ${THIS_FILE_DIR}/${exp}

    set +x
    for model in "${models[@]}"
    do
        ind_ecdd ${var} ${exp} ${model}
    done
    set -x

    ensmean ECDD ${exp} ${models[@]}
    cdo -trend \
        -selvar,onsecutive_dry_days_index_per_time_period \
        -selyear,1951/2005 \
        ${exp}_ECDD_1900_2005_ensmean.nc \
        ${exp}_ECDD_1951-2005_mean.nc \
        ${exp}_ECDD_1951-2005_trend.nc
done
