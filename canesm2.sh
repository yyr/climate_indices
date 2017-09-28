#!/bin/bash
# Created: Thursday, July 13 2017

THIS_FILE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_FILE_DIR/fun.bash

# exp=${1:-historical}
# exmts=(historical)
exmts=(historical historicalNat historicalMisc historicalGHG)

vars=(pr)
# vars=(pr tas tasmax tasmin)

model=CanESM2
ens=r1i1p1

for exp in ${exmts[@]}; do
    echo exp=$exp

    case ${exp} in
        historical )
            dir=hist
            ;;
        historicalNat )
            dir=histNat
            ;;
        historicalMisc )
            dir=histMisc
            ens=r1i1p4
            ;;
        historicalGHG )
            dir=histGHG
            ;;
    esac

    cd $THIS_FILE_DIR/${dir}
    echo "Started processing ${exp} in ${dir} directory."

    case ${exp} in
        historical )                # This is different times for historical exp.
            for var in "${vars[@]}"
            do
                cdo -remapbil,r180x100 -selyear,1900/2005 \
                    ${var}_day_${model}_${exp}_${ens}_18500101-20051231.nc \
                    ${var}_day_${model}_${exp}_${ens}_19000101-20051231_r180x100.nc
            done
            ;;
    esac

    for var in "${vars[@]}"
    do
        cdo -remapbil,r180x100 -selyear,1900/2005 \
            ${var}_day_${model}_${exp}_${ens}_18500101-20121231.nc \
            ${var}_day_${model}_${exp}_${ens}_19000101-20051231_r180x100.nc
    done
done
