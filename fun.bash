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
