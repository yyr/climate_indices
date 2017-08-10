cat <<- EOF > /tmp/cmipgrid
gridtype  = lonlat
xname     = lon
xlongname = longitude
xunits    = degrees_east
yname     = lat
ylongname = latitude
yunits    = degrees_north
xsize     = 180
ysize     = 100
xfirst    = 0
xinc      = 2
yfirst    = -89.1
yinc      = 1.8
EOF

#
mkdir -p remapped
for file in $@; do
    echo cdo remapbil,/tmp/cmipgrid $file orig/$file
    cdo remapbil,/tmp/cmipgrid $file remapped/$file
done
