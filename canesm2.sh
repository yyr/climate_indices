#!/bin/bash
# Created: Thursday, July 13 2017

exp=${1:-historicalNat}
model=CanESM2
ens=r1i1p1

case ${exp} in
    historicalNat )
        dir=/mota/DATA/cmip5/histNat
             ;;
    historicalMisc )
        dir=/mota/DATA/cmip5/histMisc
        ens=r1i1p4
        ;;
    historicalGHG )
        dir=/mota/DATA/cmip5/histGHG
        ;;
esac

cd ${dir}

echo "Started processing ${exp} in ${dir} directory."

if ls -U *${model}*${exp}*r180x100*.nc 1> /dev/null 2>&1; then
    echo Files seems already processed.
    exit
fi

cdo -remapbil,r180x100 -selyear,1900/2005 \
    tas_day_${model}_${exp}_${ens}_18500101-20121231.nc \
    tas_day_${model}_${exp}_${ens}_19000101-20051231_r180x100.nc

cdo -remapbil,r180x100 -selyear,1900/2005 \
    tasmax_day_${model}_${exp}_${ens}_18500101-20121231.nc \
    tasmax_day_${model}_${exp}_${ens}_19000101-20051231_r180x100.nc

cdo -remapbil,r180x100 -selyear,1900/2005 \
    tasmin_day_${model}_${exp}_${ens}_18500101-20121231.nc \
    tasmin_day_${model}_${exp}_${ens}_19000101-20051231_r180x100.nc
