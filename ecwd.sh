#!/bin/bash
# Created: Saturday, June  2 2018

# ECACWD - Consecutive wet days index per time period
# eca_cwd,[R=1[,N=5]] infile outfile
# Description:
# Let infile be a time series of the daily precipitation amount RR, then the
# largest number of consec- utive days where RR is at least R is counted. R is
# an optional parameter with default R = 1 mm. A further output variable is
# the number of wet periods of more than N days. The date information of a
# timestep in outfile is the date of the last contributing timestep in
# infile. The following variables are created:
# • consecutive wet days index per time period
# • number of cwd periods with more than <N>days per time period

set -x
THIS_FILE_DIR="$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
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
        ind_ecwd ${var} ${exp} ${model}
    done
    set -x

    ensmean ECWD ${exp} ${models[@]}
    cdo -trend \
        -selyear,1951/2005 \
        ${exp}_ECWD_1900_2005_ensmean.nc \
        ${exp}_ECWD_1951-2005_mean.nc \
        ${exp}_ECWD_1951-2005_trend.nc
done
