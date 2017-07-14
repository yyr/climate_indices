#!/bin/bash
# Created: Thursday, July 13 2017

exp=${1:-historicalNat}
model=IPSL-CM5A-LR
ens=r1i1p1

case ${exp} in
    historicalNat )
        dir=/mota/DATA/cmip5/histNat

        cd ${dir}
        echo "Started processing ${exp} in ${dir} directory."

        cdo -remapbil,r180x100 -selyear,1900/2005 \
            tas_day_${model}_${exp}_${ens}_18500101-20121231.nc \
            tas_day_${model}_${exp}_${ens}_19000101-20051231_r180x100.nc

        cdo -remapbil,r180x100 -selyear,1900/2005 \
            tasmin_day_${model}_${exp}_${ens}_18500101-20121231.nc \
            tasmin_day_${model}_${exp}_${ens}_19000101-20051231_r180x100.nc

        cdo -remapbil,r180x100 -selyear,1900/2005 \
            tasmax_day_${model}_${exp}_${ens}_18500101-20121231.nc \
            tasmax_day_${model}_${exp}_${ens}_19000101-20051231_r180x100.nc
        ;;

    historicalMisc )
        dir=/mota/DATA/cmip5/histMisc
        ens=r1i1p3

        cd ${dir}
        echo "Started processing ${exp} in ${dir} directory."

        cdo -remapbil,r180x100 -selyear,1900/2005 \
            tas_day_${model}_${exp}_${ens}_18500101-20051231.nc \
            tas_day_${model}_${exp}_${ens}_19000101-20051231_r180x100.nc

        cdo -remapbil,r180x100 -selyear,1900/2005 \
            tasmin_day_${model}_${exp}_${ens}_18500101-20051231.nc \
            tasmin_day_${model}_${exp}_${ens}_19000101-20051231_r180x100.nc

        cdo -remapbil,r180x100 -selyear,1900/2005 \
            tasmax_day_${model}_${exp}_${ens}_18500101-20051231.nc \
            tasmax_day_${model}_${exp}_${ens}_19000101-20051231_r180x100.nc
        ;;

    historicalGHG )
        dir=/mota/DATA/cmip5/histGHG
        cd ${dir}
        echo "Started processing ${exp} in ${dir} directory."
        cdo -mergetime \
            tas_day_${model}_${exp}_${ens}_18500101-18991231.nc  \
            tas_day_${model}_${exp}_${ens}_19000101-19491231.nc \
            tas_day_${model}_${exp}_${ens}_19500101-19991231.nc \
            tas_day_${model}_${exp}_${ens}_20000101-20121231.nc \
            tas_day_${model}_${exp}_${ens}_18500101-20121231.nc

        cdo -remapbil,r180x100 -selyear,1900/2005 \
            tas_day_${model}_${exp}_${ens}_18500101-20121231.nc \
            tas_day_${model}_${exp}_${ens}_19000101-20051231_r180x100.nc

        rm tas_day_${model}_${exp}_${ens}_18500101-20121231.nc


        cdo -mergetime \
            tasmin_day_${model}_${exp}_${ens}_18500101-18991231.nc  \
            tasmin_day_${model}_${exp}_${ens}_19000101-19491231.nc \
            tasmin_day_${model}_${exp}_${ens}_19500101-19991231.nc \
            tasmin_day_${model}_${exp}_${ens}_20000101-20121231.nc \
            tasmin_day_${model}_${exp}_${ens}_18500101-20121231.nc

        cdo -remapbil,r180x100 -selyear,1900/2005 \
            tasmin_day_${model}_${exp}_${ens}_18500101-20121231.nc \
            tasmin_day_${model}_${exp}_${ens}_19000101-20051231_r180x100.nc

        rm tasmin_day_${model}_${exp}_${ens}_18500101-20121231.nc


        cdo -mergetime \
            tasmax_day_${model}_${exp}_${ens}_18500101-18991231.nc  \
            tasmax_day_${model}_${exp}_${ens}_19000101-19491231.nc \
            tasmax_day_${model}_${exp}_${ens}_19500101-19991231.nc \
            tasmax_day_${model}_${exp}_${ens}_20000101-20121231.nc \
            tasmax_day_${model}_${exp}_${ens}_18500101-20121231.nc

        cdo -remapbil,r180x100 -selyear,1900/2005 \
            tasmax_day_${model}_${exp}_${ens}_18500101-20121231.nc \
            tasmax_day_${model}_${exp}_${ens}_19000101-20051231_r180x100.nc

        rm tasmax_day_${model}_${exp}_${ens}_18500101-20121231.nc

        exit
        ;;
esac
