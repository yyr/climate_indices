#!/bin/bash
# Created: Thursday, July 27 2017
set -x

for exp in historical historicalMisc historicalGHG
do
    for model in NorESM1-M IPSL-CM5A-LR CCSM4 CanESM2 # GFDL-CM3 GFDL-ESM2M
    do
        cd ${exp}

        # calculate day 10th percentile
        cdo -ydaypctl,10 -selyear,1961/1990 tasmin_day_${model}_${exp}_r*_19000101-20051231_r180x100.nc \
            -ydaymin -selyear,1961/1990 tasmin_day_${model}_${exp}_r*_19000101-20051231_r180x100.nc \
            -ydaymax -selyear,1961/1990 tasmin_day_${model}_${exp}_r*_19000101-20051231_r180x100.nc \
            ${model}_${exp}_ydpctl10p.nc

        set +x
        echo "Individual year eca started"

        # Calculate indcices for each year.
        for i in $(seq 1900 2005);
        do
            cdo -eca_tn10p -selyear,$i tasmin_day_${model}_${exp}_r*_19000101-20051231_r180x100.nc \
                ${model}_${exp}_ydpctl10p.nc ${model}_${exp}_CN_$i.nc
        done
        set -x

        # # merge time of indices and convert to days.
        cdo mergetime ${model}_${exp}_CN_????.nc ${model}_${exp}_CN_1900-2005.nc
        cdo -mulc,3.65 ${model}_${exp}_CN_1900-2005.nc ${model}_${exp}_CND_1900-2005.nc
        # rm ${model}_${exp}_CN_????.nc
    done

    cdo ensmean \
        NorESM1-M_${exp}_CN_1900-2005.nc \
        IPSL-CM5A-LR_${exp}_CN_1900-2005.nc \
        CCSM4_${exp}_CN_1900-2005.nc \
        CanESM2_${exp}_CN_1900-2005.nc \
        ${exp}_CN_1900_2005_ensmean.nc
    # GFDL-CM3_${exp}_CN_1900-2005.nc \
        # GFDL-ESM2M_${exp}_CN_1900-2005.nc \

    cdo ensmean \
        NorESM1-M_${exp}_CND_1900-2005.nc \
        IPSL-CM5A-LR_${exp}_CND_1900-2005.nc \
        CCSM4_${exp}_CND_1900-2005.nc \
        CanESM2_${exp}_CND_1900-2005.nc \
        ${exp}_CND_1900_2005_ensmean.nc
    # GFDL-CM3_${exp}_CND_1900-2005.nc \
        # GFDL-ESM2M_${exp}_CND_1900-2005.nc \

    # # Calculate trend.
    cdo -trend -selyear,1951/2005 ${exp}_CN_1900_2005_ensmean.nc ${exp}_CN_1951-2005_mean.nc  ${exp}_CN_1951-2005_trend.nc
    cdo -trend -selyear,1951/2005 ${exp}_CND_1900_2005_ensmean.nc ${exp}_CND_1951-2005_mean.nc  ${exp}_CND_1951-2005_trend.nc
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
