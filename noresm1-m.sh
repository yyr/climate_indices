#!/bin/bash
# Created: Wednesday, July 12 2017
THIS_FILE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_FILE_DIR/fun.bash

# exp=${1:-historical}
# exmts=(historical)
exmts=(historical historicalNat historicalGHG historicalMisc)

vars=(pr)
# vars=(pr tas tasmax tasmin)

model=NorESM1-M
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
            ;;
    esac

    cd $THIS_FILE_DIR/${dir}

    echo "Started processing ${exp} in ${dir} directory."

    for var in "${vars[@]}"
    do
        cdo -mergetime \
            ${var}_day_${model}_${exp}_${ens}_18500101-18991231.nc \
            ${var}_day_${model}_${exp}_${ens}_19000101-19491231.nc \
            ${var}_day_${model}_${exp}_${ens}_19500101-19991231.nc \
            ${var}_day_${model}_${exp}_${ens}_20000101-20051231.nc \
            ${var}_day_${model}_${exp}_${ens}_18500101-20051231.nc

        cdo -remapbil,r180x100 ${var}_day_${model}_${exp}_${ens}_18500101-20051231.nc \
            ${var}_day_${model}_${exp}_${ens}_19000101-20051231_r180x100.nc

        rm ${var}_day_${model}_${exp}_${ens}_18500101-20051231.nc
    done
done
