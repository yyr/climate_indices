; Copyright (C) Yagnesh Raghava Yakkala. http://yagnesh.org
; Created: Thursday, September 22 2016

; This is shoulder script for remap_landmask.sh

begin
  finname = "landmask.dirty.nc"
  foutname = "landmask.nc"

  f = addfile( finname, "r")
  fout = addfile(foutname, "c")

;  print(getfilevarnames(f))

  lm = f->LAND_GDS4_SFC_51
  lm = where(lm.lt.0.5,0,1)

  fout->LAND_GDS4_SFC_51 = lm
end
