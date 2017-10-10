; Copyright (C) Yagnesh Raghava Yakkala. http://yagnesh.org
; Created: Friday, July 21 2017
load "./cmip.ncl"

begin
  expmts = (/"historical", "historicalGHG", "historicalNat", "historicalMisc"/)

  do it = 0, 3, 1
    fin = "./trends/" + expmts(it) + "_WDD_1951-2005_trend.nc"
    f = addfile(fin, "r")
    d = f->warm_days_percent_wrt_90th_percentile_of_reference_period

    d = d * 55
    printMinMax(d, 0)

    ; seamask(d)

    wks = gsn_open_wks("pdf", expmts(it) + "_wd_trend")
    gsn_define_colormap(wks,"MPL_RdPu") ; select color map

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

    res@gsnDraw                   = False                  ; don't draw
    res@gsnFrame                  = False                  ; don't advance frame
    res@cnFillDrawOrder = "Predraw"
    res@cnLineDrawOrder = "Predraw"

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
    mpres@mpSpecifiedFillColors = (/"white","blue"/)

    mpres@mpAreaMaskingOn       = 1
    mpres@mpMaskAreaSpecifiers  = mask_specs

    plot = gsn_csm_contour_map(wks,d(0,:,:),mpres)

    draw(plot)
    frame(wks)
  end do
end
