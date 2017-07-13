#!/bin/bash
# Created: Wednesday, July 12 2017
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
    tasmax_day_GFDL-CM3_${exp}_r1i1p1_19000101-19041231.nc \
    tasmax_day_GFDL-CM3_${exp}_r1i1p1_19050101-19091231.nc \
    tasmax_day_GFDL-CM3_${exp}_r1i1p1_19100101-19141231.nc \
    tasmax_day_GFDL-CM3_${exp}_r1i1p1_19150101-19191231.nc \
    tasmax_day_GFDL-CM3_${exp}_r1i1p1_19200101-19241231.nc \
    tasmax_day_GFDL-CM3_${exp}_r1i1p1_19250101-19291231.nc \
    tasmax_day_GFDL-CM3_${exp}_r1i1p1_19300101-19341231.nc \
    tasmax_day_GFDL-CM3_${exp}_r1i1p1_19350101-19391231.nc \
    tasmax_day_GFDL-CM3_${exp}_r1i1p1_19400101-19441231.nc \
    tasmax_day_GFDL-CM3_${exp}_r1i1p1_19450101-19491231.nc \
    tasmax_day_GFDL-CM3_${exp}_r1i1p1_19500101-19541231.nc \
    tasmax_day_GFDL-CM3_${exp}_r1i1p1_19550101-19591231.nc \
    tasmax_day_GFDL-CM3_${exp}_r1i1p1_19600101-19641231.nc \
    tasmax_day_GFDL-CM3_${exp}_r1i1p1_19650101-19691231.nc \
    tasmax_day_GFDL-CM3_${exp}_r1i1p1_19700101-19741231.nc \
    tasmax_day_GFDL-CM3_${exp}_r1i1p1_19750101-19791231.nc \
    tasmax_day_GFDL-CM3_${exp}_r1i1p1_19800101-19841231.nc \
    tasmax_day_GFDL-CM3_${exp}_r1i1p1_19850101-19891231.nc \
    tasmax_day_GFDL-CM3_${exp}_r1i1p1_19900101-19941231.nc \
    tasmax_day_GFDL-CM3_${exp}_r1i1p1_19950101-19991231.nc \
    tasmax_day_GFDL-CM3_${exp}_r1i1p1_20000101-20041231.nc \
    tasmax_day_GFDL-CM3_${exp}_r1i1p1_20050101-20051231.nc \
    tasmax_day_GFDL-CM3_${exp}_r1i1p1_19000101-20051231.nc

cdo -remapbil,r180x100 tasmax_day_GFDL-CM3_${exp}_r1i1p1_19000101-20051231.nc\
    tasmax_day_GFDL-CM3_${exp}_r1i1p1_19000101-20051231_r180x100.nc

rm tasmax_day_GFDL-CM3_${exp}_r1i1p1_19000101-20051231.nc

cdo -mergetime \
    tasmin_day_GFDL-CM3_${exp}_r1i1p1_19000101-19041231.nc \
    tasmin_day_GFDL-CM3_${exp}_r1i1p1_19050101-19091231.nc \
    tasmin_day_GFDL-CM3_${exp}_r1i1p1_19100101-19141231.nc \
    tasmin_day_GFDL-CM3_${exp}_r1i1p1_19150101-19191231.nc \
    tasmin_day_GFDL-CM3_${exp}_r1i1p1_19200101-19241231.nc \
    tasmin_day_GFDL-CM3_${exp}_r1i1p1_19250101-19291231.nc \
    tasmin_day_GFDL-CM3_${exp}_r1i1p1_19300101-19341231.nc \
    tasmin_day_GFDL-CM3_${exp}_r1i1p1_19350101-19391231.nc \
    tasmin_day_GFDL-CM3_${exp}_r1i1p1_19400101-19441231.nc \
    tasmin_day_GFDL-CM3_${exp}_r1i1p1_19450101-19491231.nc \
    tasmin_day_GFDL-CM3_${exp}_r1i1p1_19500101-19541231.nc \
    tasmin_day_GFDL-CM3_${exp}_r1i1p1_19550101-19591231.nc \
    tasmin_day_GFDL-CM3_${exp}_r1i1p1_19600101-19641231.nc \
    tasmin_day_GFDL-CM3_${exp}_r1i1p1_19650101-19691231.nc \
    tasmin_day_GFDL-CM3_${exp}_r1i1p1_19700101-19741231.nc \
    tasmin_day_GFDL-CM3_${exp}_r1i1p1_19750101-19791231.nc \
    tasmin_day_GFDL-CM3_${exp}_r1i1p1_19800101-19841231.nc \
    tasmin_day_GFDL-CM3_${exp}_r1i1p1_19850101-19891231.nc \
    tasmin_day_GFDL-CM3_${exp}_r1i1p1_19900101-19941231.nc \
    tasmin_day_GFDL-CM3_${exp}_r1i1p1_19950101-19991231.nc \
    tasmin_day_GFDL-CM3_${exp}_r1i1p1_20000101-20041231.nc \
    tasmin_day_GFDL-CM3_${exp}_r1i1p1_20050101-20051231.nc \
    tasmin_day_GFDL-CM3_${exp}_r1i1p1_19000101-20051231.nc

cdo -remapbil,r180x100 tasmin_day_GFDL-CM3_${exp}_r1i1p1_19000101-20051231.nc\
    tasmin_day_GFDL-CM3_${exp}_r1i1p1_19000101-20051231_r180x100.nc

rm tasmin_day_GFDL-CM3_${exp}_r1i1p1_19000101-20051231.nc

cdo -mergetime \
    tas_day_GFDL-CM3_${exp}_r1i1p1_19000101-19041231.nc \
    tas_day_GFDL-CM3_${exp}_r1i1p1_19050101-19091231.nc \
    tas_day_GFDL-CM3_${exp}_r1i1p1_19100101-19141231.nc \
    tas_day_GFDL-CM3_${exp}_r1i1p1_19150101-19191231.nc \
    tas_day_GFDL-CM3_${exp}_r1i1p1_19200101-19241231.nc \
    tas_day_GFDL-CM3_${exp}_r1i1p1_19250101-19291231.nc \
    tas_day_GFDL-CM3_${exp}_r1i1p1_19300101-19341231.nc \
    tas_day_GFDL-CM3_${exp}_r1i1p1_19350101-19391231.nc \
    tas_day_GFDL-CM3_${exp}_r1i1p1_19400101-19441231.nc \
    tas_day_GFDL-CM3_${exp}_r1i1p1_19450101-19491231.nc \
    tas_day_GFDL-CM3_${exp}_r1i1p1_19500101-19541231.nc \
    tas_day_GFDL-CM3_${exp}_r1i1p1_19550101-19591231.nc \
    tas_day_GFDL-CM3_${exp}_r1i1p1_19600101-19641231.nc \
    tas_day_GFDL-CM3_${exp}_r1i1p1_19650101-19691231.nc \
    tas_day_GFDL-CM3_${exp}_r1i1p1_19700101-19741231.nc \
    tas_day_GFDL-CM3_${exp}_r1i1p1_19750101-19791231.nc \
    tas_day_GFDL-CM3_${exp}_r1i1p1_19800101-19841231.nc \
    tas_day_GFDL-CM3_${exp}_r1i1p1_19850101-19891231.nc \
    tas_day_GFDL-CM3_${exp}_r1i1p1_19900101-19941231.nc \
    tas_day_GFDL-CM3_${exp}_r1i1p1_19950101-19991231.nc \
    tas_day_GFDL-CM3_${exp}_r1i1p1_20000101-20041231.nc \
    tas_day_GFDL-CM3_${exp}_r1i1p1_20050101-20051231.nc \
    tas_day_GFDL-CM3_${exp}_r1i1p1_19000101-20051231.nc

cdo -remapbil,r180x100 tas_day_GFDL-CM3_${exp}_r1i1p1_19000101-20051231.nc\
    tas_day_GFDL-CM3_${exp}_r1i1p1_19000101-20051231_r180x100.nc

rm tas_day_GFDL-CM3_${exp}_r1i1p1_19000101-20051231.nc
