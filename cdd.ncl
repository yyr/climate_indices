; Copyright (C) Yagnesh Raghava Yakkala. http://yagnesh.org
; Created: Friday, July 21 2017
load "./cmip.ncl"

begin
  expmts = (/"historical", "historicalGHG", "historicalNat", "historicalMisc"/)

  indice = "cdd"
  outname = indice + "_trend"
  plot = new(4,graphic)
  wks = gsn_open_wks("pdf", outname)
  gsn_define_colormap(wks,"NCV_blue_red") ; select color map

  do it = 0, 3, 1
    fin = expmts(it) + "/" +expmts(it) + "_" + str_upper(indice) + "_1951-2005_trend.nc"
    f = addfile(fin, "r")

    varname = getfilevarnames(f)
    d = f->$varname(3)$

    d = d * 55
    printMinMax(d, 0)

    res = True ; options desired
    res@gsnLeftString = ""
    res@gsnRightString = ""
    res@tiMainString = expmts(it)

    res@cnFillOn = True
    res@gsnSpreadColors=True
    res@cnLinesOn = False
    res@cnLineLabelsOn = False

    res = set_res_cn(res)

    res@cnLevelSelectionMode = "ManualLevels"
    res@cnMinLevelValF = -100.
    res@cnMaxLevelValF =  100.
    res@cnLevelSpacingF = 5

    ;; lablebar
    res@lbOrientation = "vertical"
    res@lbLabelStride = 2

    res@gsnDraw                   = False                  ; don't draw
    res@gsnFrame                  = False                  ; don't advance frame
    res@cnFillDrawOrder = "Predraw"
    res@cnLineDrawOrder = "Predraw"
    res = set_res_no_margin(res)
    res = set_res_tm_size(res)
    res@lbLabelBarOn = False
    res@gsnLeftString = ""
    res@gsnRightString = ""

    mpres  = res  ; Map resources
    mpres@mpDataBaseVersion           = "Ncarg4_1"
    res@mpOutlineMaskingOn = True
    mpres@mpFillOn  = True  ; Map resources
    mpres@mpFillBoundarySets    = "NoBoundaries"

    mpres@mpGeophysicalLineThicknessF = 2.0
    mpres@mpGeophysicalLineColor = "Black"

    mpres@mpFillBoundarySets    = "NoBoundaries"
    fill_specs = (/"water","land"/)
    mask_specs = (/ "land" /)

    mpres@mpFillAreaSpecifiers  = fill_specs
    mpres@mpSpecifiedFillColors = (/"lightskyblue","white"/)

    mpres@mpAreaMaskingOn       = 1
    mpres@mpMaskAreaSpecifiers  = mask_specs

    plot(it) = gsn_csm_contour_map(wks,d(0,:,:),mpres)
  end do

  pres = set_res_panel(True)
  pres@txString           = "Cold Days trend 1951 to 2005"
  pres = set_res_lb(pres)
  pres@lbOrientation = "horizontal"
  pres@lbLabelFontHeightF = 0.01		 ; set font height of Label Bar labels
  ; pres@lbLabelStride = 6
  ; pres@lbAutoManage = False
  ; pres@gsnPanelDebug = True
  panelize_2col(wks,plot,pres)
end
