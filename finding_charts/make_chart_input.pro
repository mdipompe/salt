PRO make_chart_input,name,ra,dec,program,pi,outfile

;  NAME:
;    make_chart_input
;
;  PURPOSE:
;    Make a file suitable for passing to Kevin's finding chart making program
;
;  USE:
;    make_chart-input,name,ra,dec,program,pi,outfile
;
;  INPUTS:
;    name - array of object names (string)
;    ra - array of ra values (decimal degrees)
;    dec - array of dec values (decimal degrees)
;    program - the name of your salt program (e.g. '2017-1-SCI-056')
;    pi - name of PI
;    outfile - string name of file to write out
;
;  OPTIONAL INPUT:
;
;  KEYWORDS:
;
;  OUTPUT:
;    Writes to file
;
;  HISTORY:
;    4-25-18 - Cleaned up from other codes - MAD (Dartmouth)
;-

  openw,lun,outfile,/get_lun
  FOR i=0L,n_elements(name)-1 DO BEGIN
     ras=sixty(ra[i]/15.)
     IF (dec[i] LT 0) THEN sign='-' ELSE sign='+'
     decs=sixty(abs(dec[i]))
     
     printf,lun,strtrim(name[i],2) + ' ' + $
            strmid(strtrim(ras[0],2),0,2) + ' ' + $
            strmid(strtrim(ras[1],2),0,2) + ' ' + $
            strmid(strtrim(ras[2],2),0,5) + ' ' + $
            strtrim(sign,2) + ' ' + $
            strmid(strtrim(decs[0],2),0,2) + ' ' + $
            strmid(strtrim(decs[1],2),0,2) + ' ' + $
            strmid(strtrim(decs[2],2),0,5) + ' ' + $
            strtrim(program,2) + ' ' + $
            strtrim(pi,2), format='(A)'
  ENDFOR
  free_lun,lun

  return
END
