; Copyright (C) Yagnesh Raghava Yakkala. http://yagnesh.org
; Created: Friday, July 21 2017
load "~/git/ncl_junk/ncl-lib/resources.ncl"

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

begin

  fin = "cnb.nc"
  f = addfile(fin, "r")
  d = f->cold_nights_percent_wrt_10th_percentile_of_reference_period

  d = d * 55
  printMinMax(d, 0)

  seamask(d)

  wks = gsn_open_wks("pdf","cn")
  gsn_define_colormap(wks,"BlueRed") ; select color map
  gsn_reverse_colormap(wks)

  res = True ; options desired
  res@gsnLeftString = ""
  res@gsnRightString = ""
  res@tiMainString = "Trend"

  res@cnFillOn = True
  res@gsnSpreadColors=True
  res@cnLinesOn = False
  res@cnLineLabelsOn = False

  res = set_res_cn(res)

  res@cnLevelSelectionMode = "ManualLevels"
  res@cnMinLevelValF = -70.
  res@cnMaxLevelValF =  10.
  res@cnLevelSpacingF = 2.5

  ;; lablebar
  res@lbOrientation = "vertical"
  res@lbLabelStride = 2

  ;; res@lbLabelStrings =  (/0., 100., 200., 400., 800., 1600., 3200., 4000. /)

  mpres  = res  ; Map resources
  ; mpres@mpDataBaseVersion    = "HighRes"
  mpres@mpGeophysicalLineThicknessF = 2.0
  mpres@mpGeophysicalLineColor = "Black"
  plot = gsn_csm_contour_map(wks,d(0,:,:),mpres)
end
