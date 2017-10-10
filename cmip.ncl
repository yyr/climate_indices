; Copyright (C) Yagnesh Raghava Yakkala. http://yagnesh.org
; Created: Saturday, September 30 2017
load "~/git/ncl_junk/ncl-lib/resources.ncl"
load "~/git/ncl_junk/ncl-lib/plot.ncl"

;_____________________________________________________________________________
; Function: load_landmask
; Doc:
;_____________________________________________________________________________
undef("load_landmask")
function load_landmask()
local f, dir, finname

begin
  dir = "../remapped/"
  finname = "landmask.nc"
  f = addfile(dir + finname, "r")
  return(f->LAND_GDS4_SFC_51)
end

;_____________________________________________________________________________
; procedure: seamask
; Doc:
;_____________________________________________________________________________
undef("seamask")
procedure seamask(var:numeric)
local lm

begin
  lm = load_landmask()
  if ( rank_of(var) .eq. 2 ) then
    var(:,:) = where(lm.eq.0, lm@_FillValue,var(:,:))
    else if ( rank_of(var) .eq. 3 ) then
      do it = 0, dim_len0(var) - 1, 1    ; doc
        var(it,:,:) = where(lm.eq.0, lm@_FillValue,var(it,:,:))
      end do
    end if
  end if
  var@_FillValue = lm@_FillValue
  return
end
