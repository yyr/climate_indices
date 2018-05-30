#!/bin/bash
# Created: Thursday, July 27 2017

set -x
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
        # calculate day 10th percentile
        y10pctl ${var} ${exp} ${model}

        # Calculate cold_nights indices merge time of indices
        ind_cn ${var} ${exp} ${model}
    done

    ensmean CN ${exp} ${models[@]}
    ensmean CND ${exp} ${models[@]}

    # Calculate trend.
    cdo -trend \
        -selyear,1951/2005 \
        ${exp}_CN_1900_2005_ensmean.nc \
        ${exp}_CN_1951-2005_mean.nc \
        ${exp}_CN_1951-2005_trend.nc

    cdo -trend -selyear,1951/2005 \
        ${exp}_CND_1900_2005_ensmean.nc \
        ${exp}_CND_1951-2005_mean.nc \
        ${exp}_CND_1951-2005_trend.nc
done

#
# # Mask Sea.
# cdo -div ${model}_${exp}_CND_1900-2005.nc ../landmask.nc ${model}_${exp}_CND_1900-2005.land.nc
# cdo -div ${model}_${exp}_CN_1900-2005.nc ../landmask.nc ${model}_${exp}_CN_1900-2005.land.nc

# # field mean for global trend over the years.
# cdo -fldmean ${model}_${exp}_CND_1900-2005.land.nc ${model}_${exp}_CND_1900-2005_glmean.nc
# cdo -fldmean ${model}_${exp}_CN_1900-2005.land.nc ${model}_${exp}_CN_1900-2005_glmean.nc

# # calculate anomolies.
# cdo -sub ${model}_${exp}_CN_1900-2005_glmean.nc -timmean -selyear,1961/1990 ${model}_${exp}_CN_1900-2005_glmean.nc ${model}_${exp}_CN_1900-2005_glanom.nc
# cdo -sub ${model}_${exp}_CND_1900-2005_glmean.nc -timmean -selyear,1961/1990 ${model}_${exp}_CND_1900-2005_glmean.nc ${model}_${exp}_CND_1900-2005_glanom.nc
