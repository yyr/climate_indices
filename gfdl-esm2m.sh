#!/bin/bash
# Created: Wednesday, July 12 2017
exp=${1:-historical}
model=GFDL-ESM2M
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
        ens=r1i1p5
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
    tasmax_day_${model}_${exp}_${ens}_18960101-19001231.nc \
    tasmax_day_${model}_${exp}_${ens}_19010101-19051231.nc \
    tasmax_day_${model}_${exp}_${ens}_19060101-19101231.nc \
    tasmax_day_${model}_${exp}_${ens}_19110101-19151231.nc \
    tasmax_day_${model}_${exp}_${ens}_19160101-19201231.nc \
    tasmax_day_${model}_${exp}_${ens}_19210101-19251231.nc \
    tasmax_day_${model}_${exp}_${ens}_19260101-19301231.nc \
    tasmax_day_${model}_${exp}_${ens}_19310101-19351231.nc \
    tasmax_day_${model}_${exp}_${ens}_19360101-19401231.nc \
    tasmax_day_${model}_${exp}_${ens}_19410101-19451231.nc \
    tasmax_day_${model}_${exp}_${ens}_19460101-19501231.nc \
    tasmax_day_${model}_${exp}_${ens}_19510101-19551231.nc \
    tasmax_day_${model}_${exp}_${ens}_19560101-19601231.nc \
    tasmax_day_${model}_${exp}_${ens}_19610101-19651231.nc \
    tasmax_day_${model}_${exp}_${ens}_19660101-19701231.nc \
    tasmax_day_${model}_${exp}_${ens}_19710101-19751231.nc \
    tasmax_day_${model}_${exp}_${ens}_19760101-19801231.nc \
    tasmax_day_${model}_${exp}_${ens}_19810101-19851231.nc \
    tasmax_day_${model}_${exp}_${ens}_19860101-19901231.nc \
    tasmax_day_${model}_${exp}_${ens}_19910101-19951231.nc \
    tasmax_day_${model}_${exp}_${ens}_19960101-20001231.nc \
    tasmax_day_${model}_${exp}_${ens}_20010101-20051231.nc \
    tasmax_day_${model}_${exp}_${ens}_18960101-20051231.nc

cdo -remapbil,r180x100 tasmax_day_${model}_${exp}_${ens}_18960101-20051231.nc\
    tasmax_day_${model}_${exp}_${ens}_19000101-20051231_r180x100.nc

rm tasmax_day_${model}_${exp}_${ens}_18960101-20051231.nc

cdo -mergetime \
    tasmin_day_${model}_${exp}_${ens}_18960101-19001231.nc \
    tasmin_day_${model}_${exp}_${ens}_19010101-19051231.nc \
    tasmin_day_${model}_${exp}_${ens}_19060101-19101231.nc \
    tasmin_day_${model}_${exp}_${ens}_19110101-19151231.nc \
    tasmin_day_${model}_${exp}_${ens}_19160101-19201231.nc \
    tasmin_day_${model}_${exp}_${ens}_19210101-19251231.nc \
    tasmin_day_${model}_${exp}_${ens}_19260101-19301231.nc \
    tasmin_day_${model}_${exp}_${ens}_19310101-19351231.nc \
    tasmin_day_${model}_${exp}_${ens}_19360101-19401231.nc \
    tasmin_day_${model}_${exp}_${ens}_19410101-19451231.nc \
    tasmin_day_${model}_${exp}_${ens}_19460101-19501231.nc \
    tasmin_day_${model}_${exp}_${ens}_19510101-19551231.nc \
    tasmin_day_${model}_${exp}_${ens}_19560101-19601231.nc \
    tasmin_day_${model}_${exp}_${ens}_19610101-19651231.nc \
    tasmin_day_${model}_${exp}_${ens}_19660101-19701231.nc \
    tasmin_day_${model}_${exp}_${ens}_19710101-19751231.nc \
    tasmin_day_${model}_${exp}_${ens}_19760101-19801231.nc \
    tasmin_day_${model}_${exp}_${ens}_19810101-19851231.nc \
    tasmin_day_${model}_${exp}_${ens}_19860101-19901231.nc \
    tasmin_day_${model}_${exp}_${ens}_19910101-19951231.nc \
    tasmin_day_${model}_${exp}_${ens}_19960101-20001231.nc \
    tasmin_day_${model}_${exp}_${ens}_20010101-20051231.nc \
    tasmin_day_${model}_${exp}_${ens}_18960101-20051231.nc

cdo -remapbil,r180x100 tasmin_day_${model}_${exp}_${ens}_18960101-20051231.nc\
    tasmin_day_${model}_${exp}_${ens}_19000101-20051231_r180x100.nc

rm tasmin_day_${model}_${exp}_${ens}_18960101-20051231.nc

cdo -mergetime \
    tas_day_${model}_${exp}_${ens}_18960101-19001231.nc \
    tas_day_${model}_${exp}_${ens}_19010101-19051231.nc \
    tas_day_${model}_${exp}_${ens}_19060101-19101231.nc \
    tas_day_${model}_${exp}_${ens}_19110101-19151231.nc \
    tas_day_${model}_${exp}_${ens}_19160101-19201231.nc \
    tas_day_${model}_${exp}_${ens}_19210101-19251231.nc \
    tas_day_${model}_${exp}_${ens}_19260101-19301231.nc \
    tas_day_${model}_${exp}_${ens}_19310101-19351231.nc \
    tas_day_${model}_${exp}_${ens}_19360101-19401231.nc \
    tas_day_${model}_${exp}_${ens}_19410101-19451231.nc \
    tas_day_${model}_${exp}_${ens}_19460101-19501231.nc \
    tas_day_${model}_${exp}_${ens}_19510101-19551231.nc \
    tas_day_${model}_${exp}_${ens}_19560101-19601231.nc \
    tas_day_${model}_${exp}_${ens}_19610101-19651231.nc \
    tas_day_${model}_${exp}_${ens}_19660101-19701231.nc \
    tas_day_${model}_${exp}_${ens}_19710101-19751231.nc \
    tas_day_${model}_${exp}_${ens}_19760101-19801231.nc \
    tas_day_${model}_${exp}_${ens}_19810101-19851231.nc \
    tas_day_${model}_${exp}_${ens}_19860101-19901231.nc \
    tas_day_${model}_${exp}_${ens}_19910101-19951231.nc \
    tas_day_${model}_${exp}_${ens}_19960101-20001231.nc \
    tas_day_${model}_${exp}_${ens}_20010101-20051231.nc \
    tas_day_${model}_${exp}_${ens}_18960101-20051231.nc

cdo -remapbil,r180x100 tas_day_${model}_${exp}_${ens}_18960101-20051231.nc\
    tas_day_${model}_${exp}_${ens}_19000101-20051231_r180x100.nc

rm tas_day_${model}_${exp}_${ens}_18960101-20051231.nc
