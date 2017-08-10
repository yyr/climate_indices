#!/bin/bash
# Created: Thursday, July 13 2017

exp=${1:-historical}
model=CCSM4
ens=r1i1p1

case ${exp} in
    historical )
        dir=hist
        ;;
    historicalNat )
        dir=histNat
        ;;
    historicalMisc )
        dir=histMisc
        ens=r1i1p10
        ;;
    historicalGHG )
        dir=histGHG
        ;;
esac

cd ${dir}

echo "Started processing ${exp} in ${dir} directory."

if ls -U *${model}*${exp}*r180x100* 1> /dev/null 2>&1; then
    echo Files seems already processed.
    exit
fi

cdo -mergetime \
    tas_day_${model}_${exp}_${ens}_18850101-19191231.nc \
    tas_day_${model}_${exp}_${ens}_19200101-19541231.nc \
    tas_day_${model}_${exp}_${ens}_19550101-19891231.nc \
    tas_day_${model}_${exp}_${ens}_19900101-20051231.nc \
    tas_day_${model}_${exp}_${ens}_18850101-20051231.nc

cdo -remapbil,r180x100 -selyear,1900/2005 tas_day_${model}_${exp}_${ens}_18850101-20051231.nc \
    tas_day_${model}_${exp}_${ens}_19000101-20051231_r180x100.nc

rm tas_day_${model}_${exp}_${ens}_18850101-20051231.nc

cdo -mergetime \
    tasmin_day_${model}_${exp}_${ens}_18850101-19191231.nc \
    tasmin_day_${model}_${exp}_${ens}_19200101-19541231.nc \
    tasmin_day_${model}_${exp}_${ens}_19550101-19891231.nc \
    tasmin_day_${model}_${exp}_${ens}_19900101-20051231.nc \
    tasmin_day_${model}_${exp}_${ens}_18850101-20051231.nc

cdo -remapbil,r180x100 -selyear,1900/2005 tasmin_day_${model}_${exp}_${ens}_18850101-20051231.nc \
    tasmin_day_${model}_${exp}_${ens}_19000101-20051231_r180x100.nc

rm tasmin_day_${model}_${exp}_${ens}_18850101-20051231.nc

cdo -mergetime \
    tasmax_day_${model}_${exp}_${ens}_18850101-19191231.nc \
    tasmax_day_${model}_${exp}_${ens}_19200101-19541231.nc \
    tasmax_day_${model}_${exp}_${ens}_19550101-19891231.nc \
    tasmax_day_${model}_${exp}_${ens}_19900101-20051231.nc \
    tasmax_day_${model}_${exp}_${ens}_18850101-20051231.nc

cdo -remapbil,r180x100 -selyear,1900/2005 tasmax_day_${model}_${exp}_${ens}_18850101-20051231.nc \
    tasmax_day_${model}_${exp}_${ens}_19000101-20051231_r180x100.nc

rm tasmax_day_${model}_${exp}_${ens}_18850101-20051231.nc

cdo -mergetime \
    pr_day_${model}_${exp}_${ens}_18850101-19191231.nc \
    pr_day_${model}_${exp}_${ens}_19200101-19541231.nc \
    pr_day_${model}_${exp}_${ens}_19550101-19891231.nc \
    pr_day_${model}_${exp}_${ens}_19900101-20051231.nc \
    pr_day_${model}_${exp}_${ens}_18850101-20051231.nc

cdo -remapbil,r180x100 -selyear,1900/2005 pr_day_${model}_${exp}_${ens}_18850101-20051231.nc \
    pr_day_${model}_${exp}_${ens}_19000101-20051231_r180x100.nc

rm pr_day_${model}_${exp}_${ens}_18850101-20051231.nc
