; Copyright (C) Yagnesh Raghava Yakkala. http://yagnesh.org
; Created: Friday, July 21 2017
load "./cmip.ncl"

begin
  expmts = (/"historical", "historicalGHG", "historicalNat", "historicalMisc"/)

  indice = "tn"
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

    mpres = set_cmip_common_mp_res(True)
    mpres@tiMainString = expmts(it)
    set_res_cn_limits(mpres, -50., 50, 2)

    plot(it) = gsn_csm_contour_map(wks,d(0,:,:),mpres)
  end do

  pres = set_res_panel(True)
  pres@txString           = "Tropical Nights trend, 1951 to 2005"
  pres = set_res_lb(pres)
  pres@lbOrientation = "horizontal"
  pres@lbLabelFontHeightF = 0.01		 ; set font height of Label Bar labels
  panelize_2col(wks,plot,pres)
end
