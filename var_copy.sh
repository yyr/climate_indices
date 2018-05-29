#!/bin/bash
# Created: Wednesday, July 12 2017
# This script copies data from each cmip file to itself to ensure the file
# holds only single variable (some have a dummy variable or some sorts)


THIS_FILE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_FILE_DIR/fun.bash

exmts=(historical historicalNat historicalGHG historicalMisc)

for exp in ${exmts[@]}; do
    cd $THIS_FILE_DIR/${exp}
    pwd
    for f in `ls *r180*.nc` ; do
        var=`echo $f | cut -f1 -d"_" `
        echo cdo -selvar,$var $f tmp.nc
        cdo -selvar,$var $f tmp.nc
        echo mv tmp.nc $f
        mv tmp.nc $f
    done
done
