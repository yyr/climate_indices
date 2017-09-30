# Error number
ecode_fatal=2
ecode_warning=64

# coloring
RESET='\e[0m'
RED="\e[31m"
BLUE="\e[34m"
GREEN='\e[32m'

function red_echo()
{
    printf "${RED}$@${RESET}\n"
}

function green_echo()
{
    printf "${GREEN}$@${RESET}\n"
}

function blue_echo()
{
    printf "${BLUE}$@${RESET}\n"
}

function y10pctl()
{
    echo "PWD:" `pwd`
    var=$1
    exp=$2
    model=$3
    cdo -ydaypctl,10 \
        -selyear,1961/1990 \
        ${var}_day_${model}_${exp}_r*_19000101-20051231_r180x100.nc \
        -ydaymin -selyear,1961/1990 \
        ${var}_day_${model}_${exp}_r*_19000101-20051231_r180x100.nc \
        -ydaymax -selyear,1961/1990 \
        ${var}_day_${model}_${exp}_r*_19000101-20051231_r180x100.nc \
        ${var}_${model}_${exp}_ydpctl10p.nc
}

function y90pctl()
{
    echo "PWD:" `pwd`
    var=$1
    exp=$2
    model=$3
    cdo -ydaypctl,90 \
        -selyear,1961/1990 \
        ${var}_day_${model}_${exp}_r*_19000101-20051231_r180x100.nc \
        -ydaymin -selyear,1961/1990 \
        ${var}_day_${model}_${exp}_r*_19000101-20051231_r180x100.nc \
        -ydaymax -selyear,1961/1990 \
        ${var}_day_${model}_${exp}_r*_19000101-20051231_r180x100.nc \
        ${var}_${model}_${exp}_ydpctl90p.nc

    if [ $? != 0 ]; then
        exit
    fi
}

function ind_cn()
{
    var=$1
    exp=$2
    model=$3

    # Calculate indcices for each year.
    for i in $(seq 1900 2005); do
        cdo -eca_tn10p \
            -selyear,$i \
            ${var}_day_${model}_${exp}_r*_19000101-20051231_r180x100.nc \
            ${var}_${model}_${exp}_ydpctl10p.nc \
            ${model}_${exp}_CN_$i.nc
    done

    # merge time of indices and convert to days.
    cdo -O mergetime \
        ${model}_${exp}_CN_????.nc \
        ${model}_${exp}_CN_1900-2005.nc

    cdo -mulc,3.65 \
        ${model}_${exp}_CN_1900-2005.nc \
        ${model}_${exp}_CND_1900-2005.nc
}

function ind_wd()
{
    var=$1
    exp=$2
    model=$3

    # Calculate indcices for each year.
    for i in $(seq 1900 2005); do
        cdo -eca_tn90p \
            -selyear,$i \
            ${var}_day_${model}_${exp}_r*_19000101-20051231_r180x100.nc \
            ${var}_${model}_${exp}_ydpctl90p.nc \
            ${model}_${exp}_WD_$i.nc
    done

    # merge time of indices and convert to days.
    cdo -O mergetime \
        ${model}_${exp}_WD_????.nc \
        ${model}_${exp}_WD_1900-2005.nc

    cdo -mulc,3.65 \
        ${model}_${exp}_WD_1900-2005.nc \
        ${model}_${exp}_WDD_1900-2005.nc
}


function ensmean()
{
    ind="${1}"
    shift
    exp=${1}
    shift
    models=("${@}")
    echo $models

    str=" "

    for model in "${models[@]}"; do
        str="${str}  ${model}_${exp}_${ind}_1900-2005.nc "
    done

    cdo -O ensmean \
         ${str} \
         ${exp}_${ind}_1900_2005_ensmean.nc
}
