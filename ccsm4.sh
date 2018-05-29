#!/bin/bash
# Created: Thursday, July 13 2017

THIS_FILE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_FILE_DIR/fun.bash

# exp=${1:-historical}
# exmts=(historical)
exmts=(historical historicalNat historicalGHG historicalMisc)
vars=(pr tas tasmax tasmin)

model=CCSM4
ens=r1i1p1

for exp in ${exmts[@]}; do
    case ${exp} in
        historical )
            dir=hist
            ;;
        historicalNat )
            dir=histNat
            ;;
        historicalGHG )
            dir=histGHG
            ;;
        historicalMisc )
            dir=histMisc
            ens=r1i1p10
            ;;
    esac

    cd $THIS_FILE_DIR/${dir}

    for var in "${vars[@]}"
    do
        cdo -mergetime \
            ${var}_day_${model}_${exp}_${ens}_18850101-19191231.nc \
            ${var}_day_${model}_${exp}_${ens}_19200101-19541231.nc \
            ${var}_day_${model}_${exp}_${ens}_19550101-19891231.nc \
            ${var}_day_${model}_${exp}_${ens}_19900101-20051231.nc \
            ${var}_day_${model}_${exp}_${ens}_18850101-20051231.nc

        cdo -remapbil,r180x100 -selyear,1900/2005 \
            ${var}_day_${model}_${exp}_${ens}_18850101-20051231.nc \
            ${var}_day_${model}_${exp}_${ens}_19000101-20051231_r180x100.nc

        rm ${var}_day_${model}_${exp}_${ens}_18850101-20051231.nc
    done
done
