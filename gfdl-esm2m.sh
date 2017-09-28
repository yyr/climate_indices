#!/bin/bash
# Created: Wednesday, July 12 2017
THIS_FILE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_FILE_DIR/fun.bash

# exp=${1:-historical}
# exmts=(historical)
exmts=(historical historicalNat historicalGHG historicalMisc)

vars=(pr)
# vars=(pr tas tasmax tasmin)

model=GFDL-ESM2M
ens=r1i1p1

for exp in ${exmts[@]}; do
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

    for var in "${vars[@]}"
    do
        cd $THIS_FILE_DIR/${dir}

        cdo -mergetime \
            ${var}_day_${model}_${exp}_${ens}_18960101-19001231.nc \
            ${var}_day_${model}_${exp}_${ens}_19010101-19051231.nc \
            ${var}_day_${model}_${exp}_${ens}_19060101-19101231.nc \
            ${var}_day_${model}_${exp}_${ens}_19110101-19151231.nc \
            ${var}_day_${model}_${exp}_${ens}_19160101-19201231.nc \
            ${var}_day_${model}_${exp}_${ens}_19210101-19251231.nc \
            ${var}_day_${model}_${exp}_${ens}_19260101-19301231.nc \
            ${var}_day_${model}_${exp}_${ens}_19310101-19351231.nc \
            ${var}_day_${model}_${exp}_${ens}_19360101-19401231.nc \
            ${var}_day_${model}_${exp}_${ens}_19410101-19451231.nc \
            ${var}_day_${model}_${exp}_${ens}_19460101-19501231.nc \
            ${var}_day_${model}_${exp}_${ens}_19510101-19551231.nc \
            ${var}_day_${model}_${exp}_${ens}_19560101-19601231.nc \
            ${var}_day_${model}_${exp}_${ens}_19610101-19651231.nc \
            ${var}_day_${model}_${exp}_${ens}_19660101-19701231.nc \
            ${var}_day_${model}_${exp}_${ens}_19710101-19751231.nc \
            ${var}_day_${model}_${exp}_${ens}_19760101-19801231.nc \
            ${var}_day_${model}_${exp}_${ens}_19810101-19851231.nc \
            ${var}_day_${model}_${exp}_${ens}_19860101-19901231.nc \
            ${var}_day_${model}_${exp}_${ens}_19910101-19951231.nc \
            ${var}_day_${model}_${exp}_${ens}_19960101-20001231.nc \
            ${var}_day_${model}_${exp}_${ens}_20010101-20051231.nc \
            ${var}_day_${model}_${exp}_${ens}_18960101-20051231.nc

        cdo -remapbil,r180x100 ${var}_day_${model}_${exp}_${ens}_18960101-20051231.nc\
            ${var}_day_${model}_${exp}_${ens}_19000101-20051231_r180x100.nc

        rm ${var}_day_${model}_${exp}_${ens}_18960101-20051231.nc
    done
done
