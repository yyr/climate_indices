#!/bin/bash
# Created: Wednesday, July 12 2017
THIS_FILE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_FILE_DIR/fun.bash

# exp=${1:-historical}
# exmts=(historical)
exmts=(historical historicalNat historicalGHG historicalMisc)
vars=(pr tas tasmax tasmin)

model=GFDL-CM3
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
            ;;
        historicalGHG )
            dir=histGHG
            ;;
    esac

    for var in "${vars[@]}"
    do
        cd $THIS_FILE_DIR/${dir}

        cdo -mergetime \
            ${var}_day_${model}_${exp}_${ens}_19000101-19041231.nc \
            ${var}_day_${model}_${exp}_${ens}_19050101-19091231.nc \
            ${var}_day_${model}_${exp}_${ens}_19100101-19141231.nc \
            ${var}_day_${model}_${exp}_${ens}_19150101-19191231.nc \
            ${var}_day_${model}_${exp}_${ens}_19200101-19241231.nc \
            ${var}_day_${model}_${exp}_${ens}_19250101-19291231.nc \
            ${var}_day_${model}_${exp}_${ens}_19300101-19341231.nc \
            ${var}_day_${model}_${exp}_${ens}_19350101-19391231.nc \
            ${var}_day_${model}_${exp}_${ens}_19400101-19441231.nc \
            ${var}_day_${model}_${exp}_${ens}_19450101-19491231.nc \
            ${var}_day_${model}_${exp}_${ens}_19500101-19541231.nc \
            ${var}_day_${model}_${exp}_${ens}_19550101-19591231.nc \
            ${var}_day_${model}_${exp}_${ens}_19600101-19641231.nc \
            ${var}_day_${model}_${exp}_${ens}_19650101-19691231.nc \
            ${var}_day_${model}_${exp}_${ens}_19700101-19741231.nc \
            ${var}_day_${model}_${exp}_${ens}_19750101-19791231.nc \
            ${var}_day_${model}_${exp}_${ens}_19800101-19841231.nc \
            ${var}_day_${model}_${exp}_${ens}_19850101-19891231.nc \
            ${var}_day_${model}_${exp}_${ens}_19900101-19941231.nc \
            ${var}_day_${model}_${exp}_${ens}_19950101-19991231.nc \
            ${var}_day_${model}_${exp}_${ens}_20000101-20041231.nc \
            ${var}_day_${model}_${exp}_${ens}_20050101-20051231.nc \
            ${var}_day_${model}_${exp}_${ens}_19000101-20051231.nc

        cdo -remapbil,r180x100 \
            ${var}_day_${model}_${exp}_${ens}_19000101-20051231.nc\
            ${var}_day_${model}_${exp}_${ens}_19000101-20051231_r180x100.nc
    done
done
