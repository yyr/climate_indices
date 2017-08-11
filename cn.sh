#!/bin/bash
# Created: Thursday, July 27 2017
set -x

for model in  GFDL-ESM2M CanESM2 CCSM4 NorESM1-M # GFDL-CM3
do
    for exp in historicalGHG # historicalMisc historicalNat
    do
        cd ${exp}

        # calculate day 10th percentile
        cdo -ydaypctl,10 -selyear,1961/1990 tasmin_day_${model}_${exp}_*_19000101-20051231_r180x100.nc \
            -ydaymin -selyear,1961/1990 tasmin_day_${model}_${exp}_*_19000101-20051231_r180x100.nc \
            -ydaymax -selyear,1961/1990 tasmin_day_${model}_${exp}_*_19000101-20051231_r180x100.nc \
            ${model}_${exp}_ydpctl10p.nc

        # Calculate indcices for each year.
        for i in $(seq 1900 2005);
        do
            cdo -eca_tn10p -selyear,$i tasmin_day_${model}_${exp}_*_19000101-20051231_r180x100.nc \
                ${model}_${exp}_ydpctl10p.nc ${model}_${exp}_CN_$i.nc
        done

        # merge time of indices and convert to days.
        cdo -mergetime ${model}_${exp}_CN_*.nc ${model}_${exp}_CN_1900-2005.nc
        cdo -mulc,3.65 ${model}_${exp}_CN_1900-2005.nc ${model}_${exp}_CND_1900-2005.nc

        # Mask Sea.
        cdo -div ${model}_${exp}_CND_1900-2005.nc ../landmask.nc ${model}_${exp}_CND_1900-2005.land.nc
        cdo -div ${model}_${exp}_CN_1900-2005.nc ../landmask.nc ${model}_${exp}_CN_1900-2005.land.nc

        # field mean for global trend over the years.
        cdo -fldmean ${model}_${exp}_CND_1900-2005.land.nc ${model}_${exp}_CND_1900-2005_glmean.nc
        cdo -fldmean ${model}_${exp}_CN_1900-2005.land.nc ${model}_${exp}_CN_1900-2005_glmean.nc

        # calculate anomolies.
        cdo -sub ${model}_${exp}_CN_1900-2005_glmean.nc -timmean -selyear,1961/1990 ${model}_${exp}_CN_1900-2005_glmean.nc ${model}_${exp}_CN_1900-2005_glanom.nc
        cdo -sub ${model}_${exp}_CND_1900-2005_glmean.nc -timmean -selyear,1961/1990 ${model}_${exp}_CND_1900-2005_glmean.nc ${model}_${exp}_CND_1900-2005_glanom.nc

        # TODO: calculate ensemble mean

        # Calculate trend.
        cdo -trend -selyear,1951/2005 ${model}_${exp}_CN_1900-2005.nc ${model}_${exp}_CN_1951-2005_mean.nc ${model}_${exp}_CN_1951-2005_trend.nc
        cdo -trend -selyear,1951/2005 ${model}_${exp}_CND_1900-2005.nc ${model}_${exp}_CND_1951-2005_mean.nc ${model}_${exp}_CND_1951-2005_trend.nc
    done
done
