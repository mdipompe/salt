PRO make_blocks,name,ra,dec,chartpath,outdir=outdir,pos_ang=pos_ang
;+
;  NAME:
;    make_blocks
;
;  PURPOSE:
;    Using a template block ('block_template.xml'), make blocks for
;    batch upload to PIPT Phase 2.  Ideal for specifying many targets
;    for basic long-slit spectroscopy, with different position angles.
;    Also automatically attaches finding charts. You can edit
;    parameters that will be the same/similar for all blocks in the
;    block template itself.
;
;  USE:
;    make_blocks,name,ra...
;
;  INPUTS:
;    ra - array of ra values (decimal degrees)
;    dec - array of dec values (decimal degrees)
;    name - array of object names (string)
;    chartpath - the full path to the directory containing your
;                finding charts. These files should have the same name as
;                your targets, with .pdf at the end.
;
;  OPTIONAL INPUT:
;    outdir - the output directory for your blocks. Note that the PIPT
;             tool requires this directory to ONLY have block files in
;             it. If it doesn't exist, will be created.
;             Default: 'blocks'  
;    pos_ang - array of slit position angles. 
;
;  KEYWORDS:
;
;  OUTPUT:
;    Writes to file
;
;  HISTORY:
;    4-25-18 - Formalized from other codes - MAD (Dartmouth)
;-
  
  ;MAD Set default output directory
  IF (n_elements(outdir) EQ 0) THEN outdir='./blocks'
  
  ;MAD Check if output directory exists, make if not 
  test=file_search(outdir)
  IF (test EQ '') THEN BEGIN
     cmd=['mkdir',outdir]
     spawn,cmd,/noshell
  ENDIF
    
  flag=0
  FOR i=0L,n_elements(name)-1 DO BEGIN     
     
     outfile=strtrim(name[i],2) + '_block.xml'
     openr,lun1,'block_template.xml',/get_lun
     openw,lun2,outdir+'/'+outfile,/get_lun
     line=''
     WHILE ~EOF(lun1) DO BEGIN
        readf,lun1,line        
        xx=strsplit(line,'>',/extract)
        IF (n_elements(xx) GT 1) THEN BEGIN
           yy=strsplit(xx[1],'<',/extract)
           IF (yy[0] EQ '---INSERT NAME---' OR $
               yy[0] EQ '---INSERT TARGET NAME---') THEN $
                  line=xx[0]+'>'+strtrim(name[i],2)+'<'+yy[1]+'>'
           IF (yy[0] EQ '---INSERT ABSOLUTE FILE PATH OR AUTOMATIC---') THEN $
              line=xx[0]+'>'+chartpath+'/'+strtrim(name[i],2)+'.pdf'+'<'+yy[1]+'>'
           IF (flag EQ 1) THEN BEGIN
              line=xx[0]+'>'+strtrim(pos_ang[i],2)+'<'+yy[1]+'>'
              flag=0
           ENDIF
           IF (yy[0] EQ '---INSERT EXPTIME---') THEN $
              line=xx[0]+'>'+ strtrim(exptime,2) +'<'+yy[1]+'>'
        ENDIF
        IF (strtrim(line,2) EQ '<ns1:OnSkyPositionAngle>' AND n_elements(pos_ang) NE 0) THEN flag=1
        printf,lun2,line
     ENDWHILE
     free_lun,lun1
     free_lun,lun2
  ENDFOR
  
  

  stop
END

