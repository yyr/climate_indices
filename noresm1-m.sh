#!/bin/bash
# Created: Wednesday, July 12 2017
exp=${1:-historical}
model=NorESM1-M
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
    tas_day_${model}_${exp}_${ens}_18500101-18991231.nc \
    tas_day_${model}_${exp}_${ens}_19000101-19491231.nc \
    tas_day_${model}_${exp}_${ens}_19500101-19991231.nc \
    tas_day_${model}_${exp}_${ens}_20000101-20051231.nc \
    tas_day_${model}_${exp}_${ens}_18500101-20051231.nc

cdo -remapbil,r180x100 tas_day_${model}_${exp}_${ens}_18500101-20051231.nc \
    tas_day_${model}_${exp}_${ens}_19000101-20051231_r180x100.nc

rm tas_day_${model}_${exp}_${ens}_18500101-20051231.nc

cdo -mergetime \
    tasmin_day_${model}_${exp}_${ens}_18500101-18991231.nc \
    tasmin_day_${model}_${exp}_${ens}_19000101-19491231.nc \
    tasmin_day_${model}_${exp}_${ens}_19500101-19991231.nc \
    tasmin_day_${model}_${exp}_${ens}_20000101-20051231.nc \
    tasmin_day_${model}_${exp}_${ens}_18500101-20051231.nc

cdo -remapbil,r180x100 tasmin_day_${model}_${exp}_${ens}_18500101-20051231.nc \
    tasmin_day_${model}_${exp}_${ens}_19000101-20051231_r180x100.nc

rm tasmin_day_${model}_${exp}_${ens}_18500101-20051231.nc

cdo -mergetime \
    tasmax_day_${model}_${exp}_${ens}_18500101-18991231.nc \
    tasmax_day_${model}_${exp}_${ens}_19000101-19491231.nc \
    tasmax_day_${model}_${exp}_${ens}_19500101-19991231.nc \
    tasmax_day_${model}_${exp}_${ens}_20000101-20051231.nc \
    tasmax_day_${model}_${exp}_${ens}_18500101-20051231.nc

cdo -remapbil,r180x100 tasmax_day_${model}_${exp}_${ens}_18500101-20051231.nc \
    tasmax_day_${model}_${exp}_${ens}_19000101-20051231_r180x100.nc

rm tasmax_day_${model}_${exp}_${ens}_18500101-20051231.nc
