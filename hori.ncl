; Copyright (C) Yagnesh Raghava Yakkala. http://yagnesh.org
; Created: Friday, July 21 2017
load "./cmip.ncl"

begin
  fin = "./trends/historical_WDD_1951-2005_trend.nc"
  f = addfile(fin, "r")
  d = f->warm_days_percent_wrt_90th_percentile_of_reference_period

  d = d * 55
  printMinMax(d, 0)

  ; seamask(d)

  wks = gsn_open_wks("pdf","wd")
  gsn_define_colormap(wks,"BlueRed") ; select color map
  ; gsn_reverse_colormap(wks)

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
  res@cnMinLevelValF = 0.
  res@cnMaxLevelValF =  100.
  res@cnLevelSpacingF = 2.5

  ; res@cnFillDrawOrder      = "Predraw"  ; draw contours first

  ;; lablebar
  res@lbOrientation = "vertical"
  res@lbLabelStride = 2

  ;; res@lbLabelStrings =  (/0., 100., 200., 400., 800., 1600., 3200., 4000. /)

  mpres  = res  ; Map resources
  mpres@mpFillAreaSpecifiers  = (/"land"/)
  mpres@mpMaskAreaSpecifiers  = (/"Oceans"/)
  mpres@mpGeophysicalLineThicknessF = 2.0
  mpres@mpGeophysicalLineColor = "Black"
  plot = gsn_csm_contour_map(wks,d(0,:,:),mpres)
end
