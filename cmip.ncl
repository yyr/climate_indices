; Copyright (C) Yagnesh Raghava Yakkala. http://yagnesh.org
; Created: Saturday, September 30 2017
load "$nsc/resources.ncl"
load "$nsc/plot.ncl"

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

;_____________________________________________________________________________
; procedure: set_cmip_common_mp_res
; Doc:
;_____________________________________________________________________________
undef("set_cmip_common_mp_res")
function set_cmip_common_mp_res(mpres)
local mpres

begin
  mpres@gsnLeftString = ""
  mpres@gsnRightString = ""

  mpres = set_res_cn(mpres)
  mpres@cnFillOn = True
  mpres@gsnSpreadColors=True
  mpres@cnLinesOn = False
  mpres@cnLineLabelsOn = False

  mpres = set_res_no_frame(mpres)
  mpres@cnFillDrawOrder = "Predraw"
  mpres@cnLineDrawOrder = "Predraw"
  mpres@lbLabelBarOn = False

  mpres@mpGeophysicalLineThicknessF = 1.0
  mpres@mpGeophysicalLineColor = "Black"

  mpres@mpSpecifiedFillColors = (/"white","white"/)
  fill_specs = (/"water","land"/)
  mask_specs = (/ "land" /)

  mpres@mpFillAreaSpecifiers  = fill_specs
  mpres@mpMaskAreaSpecifiers  = mask_specs

  mpres = set_res_no_margin(mpres)
  mpres@mpProjection = "Robinson"
  mpres@mpGridAndLimbOn      = True           ; turn on limb and grid lines
  ; mpres@mpGridLineColor      = -1             ; ...but don't draw grid lines...
  mpres@mpGridLineDashPattern = 2
  mpres@mpPerimOn            = False          ; turn off map perimeter
  mpres@mpFillDrawOrder      = "PostDraw"     ; draw map fill last
  mpres@mpGridSpacingF   = 40

  return(mpres)
end
