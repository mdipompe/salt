;readcol,'pipt_input_targets2015-2.txt',name,type,ra,dec,format='A,A,D,D',delim=','
readcol,'../group_1_nonmateos.dat',blah,name,ra,dec,format='A,A,A,D,D',delim=' '


rah = ra*0
ram = ra*0
ras = ra*0

ded = ra*0
dem = ra*0
des = ra*0

for i=0,n_elements(ra)-1 do begin

   rasx = sixty(ra[i]*24d/360d)
   rah[i] = rasx[0] & ram[i] = rasx[1] & ras[i] = rasx[2]

    decsx = sixty(dec[i],/trail)
   ded[i] = abs(decsx[0]) & dem[i] = decsx[1] & des[i] = decsx[2]
   
endfor

design = strarr(n_elements(ra))+'-'
design[where(dec gt 0.)] = '+'

;program = strarr(n_elements(ra))+'2015-2-SCI-025'
program = strarr(n_elements(ra))+'2016-2-SCI-035'
PI = strarr(n_elements(ra))+'Hickox'

forprint,name,rah,ram,ras,design,ded,dem,des,program,PI,format='A,I3,I3,D7.3,X,A,I4,I3,D7.3,X,A,X,A',textout='chart_input_targets_all_wise_2016.txt',/nocomm
end
