FUNCTION getposangle, image, slitlength  
    set_plot,'x'
    
    circle_rad = slitlength / 2 
    
    inner_circle_rad = 0.05 * circle_rad 
     
    WINDOW, 0, XSIZE=750, YSIZE=750
    imdisp, image, /axis, /negative, background=255, margin=0.0
	;plot_circle, 300, 300, circle_rad, color=100, /overplot
	plot_circle, 300, 300, inner_circle_rad, color=100, /overplot
	
	loadct, 0
	
	plot_tickmarks, slitlength

    READ, posangle, PROMPT='Enter Position Angle: '

	bpa = posangle * (1.0)
	
	yoneval = ((slitlength / 2.0) * cos((-1)*posangle * 3.14159265/180.0))+300
	xoneval = ((slitlength / 2.0) * sin((-1)*posangle * 3.14159265/180.0))+300
	xtwoval = 300 - (xoneval - 300)
	ytwoval = 300 - (yoneval - 300)
	
	oplot, [xoneval, 300], [yoneval, 300], color=299, thick=2
	oplot, [xtwoval, 300], [ytwoval, 300], color=299, thick=2
	
	xyouts, 460, -50, 'PA = '+strtrim(posangle,2)

    READ, posangle, PROMPT='Enter new Position Angle (-9999 if satisfied): '

	while posangle ne '-9999' do begin

		bpa = posangle 
			
    	; READ, posangle, PROMPT='Enter Position Angle: '

		imdisp, image, /axis, /negative, background=255, margin=0.0
		;plot_circle, 300, 300, circle_rad, color=100, /overplot
		plot_circle, 300, 300, inner_circle_rad, color=100, /overplot
		plot_tickmarks, slitlength

		yoneval = ((slitlength / 2.0) * cos((-1)*posangle * 3.14159265/180.0))+300
		xoneval = ((slitlength / 2.0) * sin((-1)*posangle * 3.14159265/180.0))+300
		xtwoval = 300 - (xoneval - 300)
		ytwoval = 300 - (yoneval - 300)
		
		oplot, [xoneval, 300], [yoneval, 300], color=299, thick=2
		oplot, [xtwoval, 300], [ytwoval, 300], color=299, thick=2
		
		xyouts, 460, -50, 'PA = '+strtrim(posangle,2)
	
    	READ, posangle, PROMPT='Enter new Position Angle (-9999 if satisfied): '
	
	endwhile
		
	;bestposangle = posangle	
	RETURN, bpa

END 
