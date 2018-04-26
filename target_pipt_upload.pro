PRO target_pipt_upload,name,ra,dec,outfile,epoch=epoch,mag=mag,band=band,obj_type=obj_type,$
                       time=time,max_phase=max_phase,priority=priority
;+
;  NAME:
;    target_pipt_upload
;
;  PURPOSE:
;    Take properties of objects for salt observations and spit out a
;    file for upload to the PIPT tool. This only deals with the
;    minimum required info for a file to upload, but should be easy to modify.
;
;  USE:
;    target_pipt_upload,'outfile',...
;
;  INPUTS:
;    ra - array of ra values (decimal degrees)
;    dec - array of dec values (decimal degrees)
;    name - array of object names (string)
;    outfile - string name of file to write out
;
;  OPTIONAL INPUT:
;    epoch - Position epoch. Can be array or single value (string).
;            Default: 2000
;    mag - array of magnitudes. Assumed target is not variable, and
;          will use this for min and max values.
;          Default: 20.
;    band - Can be array or single value (string). Johnson
;           system.
;           Default: 'B'
;    obj_type - Can be array or single value (string). 
;               Default: AGN.  See PIPT instructions for options.
;    time - single or array of values corresponding to total on-target observing
;           time.
;           Defaults: 2250s.
;    max_phase - single or array values (string) of maximum lunar
;                phase.
;                Default: 14.6 (dark time)
;    priority - single or array of values (string) of observing
;               priority.
;               Default: High
;
;  KEYWORDS:
;
;  OUTPUT:
;    Writes to file
;
;  HISTORY:
;    4-25-18 - Formalized from other codes - MAD (Dartmouth)
;-

  ;MAD Set default values, sizes of arrays
  IF (n_elements(epoch) EQ 0) THEN epoch='2000'
  IF (n_elements(epoch) EQ 1 AND n_elements(ra) GT 1) THEN epoch=strarr(n_elements(ra)) + epoch
  IF (n_elements(mag) EQ 0) THEN mag=20.
  IF (n_elements(mag) EQ 1 AND n_elements(ra) GT 1) THEN mag=fltarr(n_elements(ra)) + mag
  IF (n_elements(band) EQ 0) THEN band='B'
  IF (n_elements(band) EQ 1 AND n_elements(ra) GT 1) THEN band=strarr(n_elements(ra)) + band
  IF (n_elements(obj_type) EQ 0) THEN obj_type='AGN'
  IF (n_elements(obj_type) EQ 1 AND n_elements(ra) GT 1) THEN obj_type=strarr(n_elements(ra)) + obj_type
  IF (n_elements(time) EQ 0) THEN time=2250
  IF (n_elements(time) EQ 1 AND n_elements(ra) GT 1) THEN time=intarr(n_elements(ra)) + time
  IF (n_elements(max_phase) EQ 0) THEN max_phase='14.6'
  IF (n_elements(max_phase) EQ 1 AND n_elements(ra) GT 1) THEN max_phase=strarr(n_elements(ra)) + max_phase
  IF (n_elements(priority) EQ 0) THEN priority='High'
  IF (n_elements(priority) EQ 1 AND n_elements(ra) GT 1) THEN priority=strarr(n_elements(ra)) + priority
  
  
  openw,lun,outfile,/get_lun
  printf,lun,'target name, target type, right ascension, declination, equinox, bandpass, minimum magnitude, maximum magnitude, observing time, maximum lunar phase, ranking',format='(A)'
  FOR i=0L,n_elements(ra)-1 DO BEGIN
     printf,lun,strtrim(name[i],2) + ', ' + $
            strtrim(obj_type[i],2) + ', ' + $
            strtrim(ra[i],2) + ', ' + $
            strtrim(dec[i],2) + ', ' + $
            strtrim(epoch[i],2) + ', ' + $
            strtrim(band[i],2) + ', ' + $
            strtrim(mag[i],2) + ', ' + $
            strtrim(mag[i],2) + ', ' + $
            strtrim(time[2],2) + ', ' + $
            strtrim(max_phase[i],2) + ', ' + $
            strtrim(priority[i],2),format='(A)'
  ENDFOR
  free_lun,lun

  stop
END
