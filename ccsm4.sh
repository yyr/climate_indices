#!/bin/bash
# Created: Thursday, July 13 2017

exp=${1:-historicalNat}

case ${exp} in
    historicalNat )
        dir=/mota/DATA/cmip5/histNat
             ;;
    historicalMisc )
        dir=/mota/DATA/cmip5/histMisc
        ;;
    historicalGHG )
        dir=/mota/DATA/cmip5/histGHG
        ;;
esac

cd ${dir}

echo "Started processing ${exp} in ${dir} directory."

if ls -U *${exp}*r180x100* 1> /dev/null 2>&1; then
    echo Files seems already processed.
    exit
fi

cdo -mergetime \
    tas_day_CCSM4_${exp}_r1i1p1_18850101-19191231.nc \
    tas_day_CCSM4_${exp}_r1i1p1_19200101-19541231.nc \
    tas_day_CCSM4_${exp}_r1i1p1_19550101-19891231.nc \
    tas_day_CCSM4_${exp}_r1i1p1_19900101-20051231.nc \
    tas_day_CCSM4_${exp}_r1i1p1_18850101-20051231.nc

cdo -remapbil,r180x100 -selyear,1900/2005 tas_day_CCSM4_${exp}_r1i1p1_18850101-20051231.nc \
    tas_day_CCSM4_${exp}_r1i1p1_19000101-20051231_r180x100.nc

rm tas_day_CCSM4_${exp}_r1i1p1_18850101-20051231.nc

cdo -mergetime \
    tasmin_day_CCSM4_${exp}_r1i1p1_18850101-19191231.nc \
    tasmin_day_CCSM4_${exp}_r1i1p1_19200101-19541231.nc \
    tasmin_day_CCSM4_${exp}_r1i1p1_19550101-19891231.nc \
    tasmin_day_CCSM4_${exp}_r1i1p1_19900101-20051231.nc \
    tasmin_day_CCSM4_${exp}_r1i1p1_18850101-20051231.nc

cdo -remapbil,r180x100 -selyear,1900/2005 tasmin_day_CCSM4_${exp}_r1i1p1_18850101-20051231.nc \
    tasmin_day_CCSM4_${exp}_r1i1p1_19000101-20051231_r180x100.nc

rm tasmin_day_CCSM4_${exp}_r1i1p1_18850101-20051231.nc

cdo -mergetime \
    tasmax_day_CCSM4_${exp}_r1i1p1_18850101-19191231.nc \
    tasmax_day_CCSM4_${exp}_r1i1p1_19200101-19541231.nc \
    tasmax_day_CCSM4_${exp}_r1i1p1_19550101-19891231.nc \
    tasmax_day_CCSM4_${exp}_r1i1p1_19900101-20051231.nc \
    tasmax_day_CCSM4_${exp}_r1i1p1_18850101-20051231.nc

cdo -remapbil,r180x100 -selyear,1900/2005 tasmax_day_CCSM4_${exp}_r1i1p1_18850101-20051231.nc \
    tasmax_day_CCSM4_${exp}_r1i1p1_19000101-20051231_r180x100.nc

rm tasmax_day_CCSM4_${exp}_r1i1p1_18850101-20051231.nc
