PRO go

  readcol,'../..//obsc_pairs.txt',$
          name, ra, dec, g, ra2, dec2, g2, format='(A),D,D,D,D,D,D'

  openw,1,'obsc_posang.txt'
  FOR i=0L,n_elements(name)-1 DO BEGIN
     posang,1,ra[i]/15.,dec[i],ra2[i]/15.,dec2[i],angle
     IF (angle GT 90) THEN angle=angle-180
     IF (angle LT -90) THEN angle=angle+180
     printf,1,name[i] + '   ' + strtrim(angle,2),format='(A)'
  ENDFOR
  close,1

  readcol,'../../unob_pairs.txt',$
          name, ra, dec, g, ra2, dec2, g2, format='(A),D,D,D,D,D,D'

  openw,1,'unob_posang.txt'
  FOR i=0L,n_elements(name)-1 DO BEGIN
     posang,1,ra[i]/15.,dec[i],ra2[i]/15.,dec2[i],angle
     IF (angle GT 90) THEN angle=angle-180
     IF (angle LT -90) THEN angle=angle+180
     printf,1,name[i] + '   ' + strtrim(angle,2),format='(A)'
  ENDFOR
  close,1

  stop
END
