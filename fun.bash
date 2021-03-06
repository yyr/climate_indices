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

    CREATED_FILE=${var}_${model}_${exp}_ydpctl10p.nc
    if [ -f $CREATED_FILE ] ; then
        red_echo 10th percentile $CREATED_FILE already exists. SKIPPING
        return
    else
        cdo -s -ydaypctl,10 \
            -selyear,1961/1990 \
            ${var}_day_${model}_${exp}_r*_19000101-20051231_r180x100.nc \
            -ydaymin -selyear,1961/1990 \
            ${var}_day_${model}_${exp}_r*_19000101-20051231_r180x100.nc \
            -ydaymax -selyear,1961/1990 \
            ${var}_day_${model}_${exp}_r*_19000101-20051231_r180x100.nc \
            ${var}_${model}_${exp}_ydpctl10p.nc
    fi

}

function y90pctl()
{
    echo "PWD:" `pwd`
    var=$1
    exp=$2
    model=$3

    CREATED_FILE=${var}_${model}_${exp}_ydpctl90p.nc
    if [ -f $CREATED_FILE ] ; then
        red_echo 90th percentile $CREATED_FILE already exists. SKIPPING
        return
    else
        cdo -s -ydaypctl,90 \
            -selyear,1961/1990 \
            ${var}_day_${model}_${exp}_r*_19000101-20051231_r180x100.nc \
            -ydaymin -selyear,1961/1990 \
            ${var}_day_${model}_${exp}_r*_19000101-20051231_r180x100.nc \
            -ydaymax -selyear,1961/1990 \
            ${var}_day_${model}_${exp}_r*_19000101-20051231_r180x100.nc \
            ${var}_${model}_${exp}_ydpctl90p.nc
    fi
}

function y95pctl()
{
    echo "PWD:" `pwd`
    var=$1
    exp=$2
    model=$3

    CREATED_FILE=${var}_${model}_${exp}_ydpctl95p.nc
    if [ -f $CREATED_FILE ] ; then
        red_echo 10th percentile $CREATED_FILE already exists. SKIPPING
        return
    else
        cdo -s -ydaypctl,95 \
            -selyear,1961/1990 \
            ${var}_day_${model}_${exp}_r*_19000101-20051231_r180x100.nc \
            -ydaymin -selyear,1961/1990 \
            ${var}_day_${model}_${exp}_r*_19000101-20051231_r180x100.nc \
            -ydaymax -selyear,1961/1990 \
            ${var}_day_${model}_${exp}_r*_19000101-20051231_r180x100.nc \
            ${var}_${model}_${exp}_ydpctl95p.nc
    fi
}


function ind_cn()
{
    var=$1
    exp=$2
    model=$3

    # Calculate indcices for each year.
    for i in $(seq 1900 2005); do
        cdo -s -eca_tn10p \
            -selyear,$i \
            ${var}_day_${model}_${exp}_r*_19000101-20051231_r180x100.nc \
            ${var}_${model}_${exp}_ydpctl10p.nc \
            ${model}_${exp}_CN_$i.nc
    done

    # merge time and convert to days.
    cdo -s -O mergetime \
        ${model}_${exp}_CN_????.nc \
        ${model}_${exp}_CN_1900-2005.nc

    cdo -s -mulc,3.65 \
        ${model}_${exp}_CN_1900-2005.nc \
        ${model}_${exp}_CND_1900-2005.nc
}

function ind_cd()
{
    var=$1
    exp=$2
    model=$3

    # Calculate indcices for each year.
    for i in $(seq 1900 2005); do
        cdo -s -eca_tg10p \
            -selyear,$i \
            ${var}_day_${model}_${exp}_r*_19000101-20051231_r180x100.nc \
            ${var}_${model}_${exp}_ydpctl10p.nc \
            ${model}_${exp}_CD_$i.nc
    done

    # merge time and convert to days.
    cdo -s -O mergetime \
        ${model}_${exp}_CD_????.nc \
        ${model}_${exp}_CD_1900-2005.nc

    cdo -s -mulc,3.65 \
        ${model}_${exp}_CD_1900-2005.nc \
        ${model}_${exp}_CDD_1900-2005.nc

    # rm ${model}_${exp}_CD_????.nc
}

function ind_csdi()
{
    var=$1
    exp=$2
    model=$3

    # Calculate indcices for each year.
    for i in $(seq 1900 2005); do
        cdo -s -eca_cwfi \
            -selyear,$i \
            ${var}_day_${model}_${exp}_r*_19000101-20051231_r180x100.nc \
            ${var}_${model}_${exp}_ydpctl10p.nc \
            ${model}_${exp}_CSDI_$i.nc
    done

    # merge time of indices
    cdo -s -O mergetime \
        ${model}_${exp}_CSDI_????.nc \
        ${model}_${exp}_CSDI_1900-2005.nc
}

function ind_wd()
{
    var=$1
    exp=$2
    model=$3

    # Calculate indcices for each year.
    for i in $(seq 1900 2005); do
        cdo -s -eca_tg90p \
            -selyear,$i \
            ${var}_day_${model}_${exp}_r*_19000101-20051231_r180x100.nc \
            ${var}_${model}_${exp}_ydpctl90p.nc \
            ${model}_${exp}_WD_$i.nc
    done

    # merge time and convert to days.
    cdo -s -O mergetime \
        ${model}_${exp}_WD_????.nc \
        ${model}_${exp}_WD_1900-2005.nc

    cdo -s -mulc,3.65 \
        ${model}_${exp}_WD_1900-2005.nc \
        ${model}_${exp}_WDD_1900-2005.nc

    # rm ${model}_${exp}_WD_????.nc
}

function ind_wsdi()
{
    var=$1
    exp=$2
    model=$3

    # Calculate indcices for each year.
    for i in $(seq 1900 2005); do
        cdo -s -eca_hwfi \
            -selyear,$i \
            ${var}_day_${model}_${exp}_r*_19000101-20051231_r180x100.nc \
            ${var}_${model}_${exp}_ydpctl90p.nc \
            ${model}_${exp}_WSDI_$i.nc
    done

    cdo -s -O mergetime \
        ${model}_${exp}_WSDI_????.nc \
        ${model}_${exp}_WSDI_1900-2005.nc
}

function ind_wn()
{
    var=$1
    exp=$2
    model=$3

    # Calculate indcices for each year.
    for i in $(seq 1900 2005); do
        cdo -s -eca_tn90p \
            -selyear,$i \
            ${var}_day_${model}_${exp}_r*_19000101-20051231_r180x100.nc \
            ${var}_${model}_${exp}_ydpctl90p.nc \
            ${model}_${exp}_WN_$i.nc
    done

    # merge time and convert to days.
    cdo -s -O mergetime \
        ${model}_${exp}_WN_????.nc \
        ${model}_${exp}_WN_1900-2005.nc

    cdo -s -mulc,3.65 \
        ${model}_${exp}_WN_1900-2005.nc \
        ${model}_${exp}_WND_1900-2005.nc
}

function ind_fd()
{
    var=$1
    exp=$2
    model=$3

    # Calculate indcices for each year.
    for i in $(seq 1900 2005); do
        cdo -s -eca_fd \
            -selyear,$i \
            ${var}_day_${model}_${exp}_r*_19000101-20051231_r180x100.nc \
            ${model}_${exp}_FD_$i.nc
    done

    cdo -s -O mergetime \
        ${model}_${exp}_FD_????.nc \
        ${model}_${exp}_FD_1900-2005.nc
}

function ind_tn()
{
    var=$1
    exp=$2
    model=$3

    # Calculate indcices for each year.
    for i in $(seq 1900 2005); do
        cdo -s -eca_tr \
            -selyear,$i \
            ${var}_day_${model}_${exp}_r*_19000101-20051231_r180x100.nc \
            ${model}_${exp}_TN_$i.nc
    done

    cdo -s -O mergetime \
        ${model}_${exp}_TN_????.nc \
        ${model}_${exp}_TN_1900-2005.nc
}


function ensmean()
{
    ind="${1}"
    shift
    exp=${1}
    shift
    models=("${@}")
    str=" "

    for model in "${models[@]}"; do
        str="${str}  ${model}_${exp}_${ind}_1900-2005.nc "
    done
    cdo -s -O ensmean \
        ${str} \
        ${exp}_${ind}_1900_2005_ensmean.nc
}


function ind_ecdd()
{
    var=$1
    exp=$2
    model=$3

    # Calculate indcices for each year.
    for i in $(seq 1900 2005); do
        cdo -s -eca_cdd \
            -selyear,$i \
            ${var}_day_${model}_${exp}_r*_19000101-20051231_r180x100.nc \
            ${model}_${exp}_ECDD_$i.nc
    done
    cdo -s -O mergetime \
        ${model}_${exp}_ECDD_????.nc \
        ${model}_${exp}_ECDD_1900-2005.nc
}


function ind_ecwd()
{
    var=$1
    exp=$2
    model=$3

    # Calculate indcices for each year.
    for i in $(seq 1900 2005); do
        cdo -s -eca_cwd \
            -selyear,$i \
            ${var}_day_${model}_${exp}_r*_19000101-20051231_r180x100.nc \
            ${model}_${exp}_ECWD_$i.nc
    done
    cdo -s -O mergetime \
        ${model}_${exp}_ECWD_????.nc \
        ${model}_${exp}_ECWD_1900-2005.nc
}

function ind_vwd()
{
    var=$1
    exp=$2
    model=$3

    # Calculate indcices for each year.
    for i in $(seq 1900 2005); do
        cdo -s -eca_r95p \
            -selyear,$i \
            ${var}_day_${model}_${exp}_r*_19000101-20051231_r180x100.nc \
            ${var}_${model}_${exp}_ydpctl95p.nc \
            ${model}_${exp}_VWD_$i.nc
    done

    # merge time of indices
    cdo -s -O mergetime \
        ${model}_${exp}_VWD_????.nc \
        ${model}_${exp}_VWD_1900-2005.nc
}


function ind_ptot()
{
    var=$1
    exp=$2
    model=$3

    # Calculate indcices for each year.
    for i in $(seq 1900 2005); do
        cdo -s -eca_r95ptot \
            -selyear,$i \
            ${var}_day_${model}_${exp}_r*_19000101-20051231_r180x100.nc \
            ${var}_${model}_${exp}_ydpctl95p.nc \
            ${model}_${exp}_PTOT_$i.nc
    done

    # merge time of indices
    cdo -s -O mergetime \
        ${model}_${exp}_PTOT_????.nc \
        ${model}_${exp}_PTOT_1900-2005.nc
}
