#!/bin/bash
# Created: Thursday, July 13 2017

THIS_FILE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_FILE_DIR/fun.bash

# exp=${1:-historical}
exmts=(historical historicalNat historicalGHG historicalMisc)
vars=(pr tas tasmax tasmin)

model=IPSL-CM5A-LR
ens=r1i1p1

for exp in ${exmts[@]}; do
    for var in "${vars[@]}"
    do
        case ${exp} in
            historical )
                dir=hist

                cd $THIS_FILE_DIR/${dir}
                echo "Started processing ${exp} in ${dir} directory."

                cdo -mergetime \
                    ${var}_day_${model}_${exp}_${ens}_18500101-19491231.nc \
                    ${var}_day_${model}_${exp}_${ens}_19500101-20051231.nc \
                    ${var}_day_${model}_${exp}_${ens}_18500101-20051231.nc

                cdo -remapbil,r180x100 -selyear,1900/2005 \
                    ${var}_day_${model}_${exp}_${ens}_18500101-20051231.nc \
                    ${var}_day_${model}_${exp}_${ens}_19000101-20051231_r180x100.nc
                ;;

            historicalNat )
                dir=histNat

                cd $THIS_FILE_DIR/${dir}
                echo "Started processing ${exp} in ${dir} directory."

                cdo -mergetime \
                    ${var}_day_${model}_${exp}_${ens}_18500101-18991231.nc  \
                    ${var}_day_${model}_${exp}_${ens}_19000101-19491231.nc \
                    ${var}_day_${model}_${exp}_${ens}_19500101-19991231.nc \
                    ${var}_day_${model}_${exp}_${ens}_20000101-20121231.nc \
                    ${var}_day_${model}_${exp}_${ens}_18500101-20121231.nc

                cdo -remapbil,r180x100 -selyear,1900/2005 \
                    ${var}_day_${model}_${exp}_${ens}_18500101-20121231.nc \
                    ${var}_day_${model}_${exp}_${ens}_19000101-20051231_r180x100.nc

                ;;

            historicalMisc )
                dir=histMisc
                ens=r1i1p3

                cd $THIS_FILE_DIR/${dir}
                echo "Started processing ${exp} in ${dir} directory."

                cdo -remapbil,r180x100 -selyear,1900/2005 \
                    ${var}_day_${model}_${exp}_${ens}_18500101-20051231.nc \
                    ${var}_day_${model}_${exp}_${ens}_19000101-20051231_r180x100.nc

                ;;

            historicalGHG )
                dir=histGHG
                cd $THIS_FILE_DIR/${dir}
                echo "Started processing ${exp} in ${dir} directory."

                cdo -mergetime \
                    ${var}_day_${model}_${exp}_${ens}_18500101-18991231.nc  \
                    ${var}_day_${model}_${exp}_${ens}_19000101-19491231.nc \
                    ${var}_day_${model}_${exp}_${ens}_19500101-19991231.nc \
                    ${var}_day_${model}_${exp}_${ens}_20000101-20121231.nc \
                    ${var}_day_${model}_${exp}_${ens}_18500101-20121231.nc

                cdo -remapbil,r180x100 -selyear,1900/2005 \
                    ${var}_day_${model}_${exp}_${ens}_18500101-20121231.nc \
                    ${var}_day_${model}_${exp}_${ens}_19000101-20051231_r180x100.nc

                rm ${var}_day_${model}_${exp}_${ens}_18500101-20121231.nc
                ;;
        esac
    done
done
