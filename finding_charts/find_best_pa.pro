pro find_best_pa
;PRO find_best_pa, field1, field2, field3
	
	COMMON SHARED		
			
	;shared_image = image
	;shared_slitlength = slitlength
	shared_pa = 0.0
	
	posangle_new = shared_pa
	
    set_plot,'x'
    
    circle_rad = shared_slitlength / 2 
    
    inner_circle_rad = 0.05 * circle_rad 
 
    WINDOW, 0, XSIZE=600, YSIZE=600
    ;imdisp, shared_image, /axis, /negative, background=255, margin=0.0
    cgimage,shared_image,/negative,xrange=[0,600],yrange=[0,600],/save
        plot_circle, 300, 300, circle_rad, color=100, /overplot
    plot_circle, 300, 300, inner_circle_rad, color=100, /overplot
    xyouts, 460, 100, 'PA = 0'+string(176b), color=299, /data
	;yoneval = ((shared_slitlength / 2.0) * cos((-1)*posangle_new * 3.14159265/180.0))+300
	;xoneval = ((shared_slitlength / 2.0) * sin((-1)*posangle_new * 3.14159265/180.0))+300
	;xtwoval = 300 - (xoneval - 300)
	;ytwoval = 300 - (yoneval - 300)
	;	
	;oplot, [xoneval, 300], [yoneval, 300], color=299, thick=2
	;oplot, [xtwoval, 300], [ytwoval, 300], color=299, thick=2

	y_one_val = ((shared_slitlength / 2.0) * cos((-1)*posangle_new * 3.14159265/180.0))+300
	x_one_val = ((shared_slitlength / 2.0) * sin((-1)*posangle_new * 3.14159265/180.0))+300
	x_two_val = 300 - (x_one_val - 300)
	y_two_val = 300 - (y_one_val - 300)
	
	slit_size = 1.3
	
	slit_delta_x = slit_size * cos((-1)*posangle_new * 3.14159265/180.0)
	slit_delta_y = slit_size * sin((-1)*posangle_new * 3.14159265/180.0)
	
	x_one_val_new = x_one_val - slit_delta_x
	y_one_val_new = y_one_val + slit_delta_y
	x_two_val_new = x_two_val - slit_delta_x
	y_two_val_new = y_two_val + slit_delta_y
	
	center_x = 300 - slit_delta_x
	center_y = 300 + slit_delta_y
	
	oplot, [x_one_val_new, center_x], [y_one_val_new, center_y], color=299, thick=1
	oplot, [x_two_val_new, center_x], [y_two_val_new, center_y], color=299, thick=1

	x_one_val_new = x_one_val + slit_delta_x
	y_one_val_new = y_one_val - slit_delta_y
	x_two_val_new = x_two_val + slit_delta_x
	y_two_val_new = y_two_val - slit_delta_y

	center_x = 300 + slit_delta_x
	center_y = 300 - slit_delta_y
		
	oplot, [x_one_val_new, center_x], [y_one_val_new, center_y], color=299, thick=1
	oplot, [x_two_val_new, center_x], [y_two_val_new, center_y], color=299, thick=1
	
		
	xyouts, 460, 100, 'PA = '+strtrim(posangle_new,2)+string(176b), color=299

	loadct, 0
	
	plot_tickmarks, shared_slitlength

; An example program to exercise some of the features of FSC_FIELD.

tlb = Widget_Base(Column=1)
;button = Widget_Button(tlb, Value='Change First Field to Float', $
;   UValue='ChangeToFloat')

   ; Create an integer field, no more than 4 digits in the value.

;field1id = FSC_FIELD(tlb, Title='Integer:', LabelSize=50, Digits=4, Object=field1, $
;   Value=5, UValue='Field 1 Event', Event_Pro='Example_Event', /CR_Only, /Highlight)

   ; Create a floating point field. Only two decimal points to the right of the decimal.
   ; Set the Undefined value to -9999.0.

field1id = FSC_FIELD(tlb, Title='PA:', LabelSize=50, Value=0.0, Object=field1, Undefined=-9999.0, $
   /CR_Only, UValue='Field 1 Event', Event_Pro='find_best_pa_event', Decimal=2, /Highlight)

   ; Create a string field.

;field = FSC_FIELD(tlb, Title='String:', LabelSize=50, Value='Coyote Rules!', Object=field3, /Nonsensitive, /Highlight)

   ; Set up TABing between fields.

;field1->SetTabNext, field2->GetTextID()
;field2->SetTabNext, field3->GetTextID()
;field3->SetTabNext, field1->GetTextID()

button = Widget_Button(tlb, Value='Up, 0.5', UValue='goUpbig')
button = Widget_Button(tlb, Value='Up, 0.1', UValue='goUp')
button = Widget_Button(tlb, Value='Down, 0.1', UValue='goDown')
button = Widget_Button(tlb, Value='Down, 0.5', UValue='goDownbig')
button = Widget_Button(tlb, Value='Set PA', UValue='getPA')
button = Widget_Button(tlb, Value='Quit', UValue='Quit')
;Widget_Control, tlb, /Realize, Set_UValue={field1:field1, field2:field2, field3:field3, field1id:field1id, labelsize:75}
Widget_Control, tlb, /Realize, Set_UValue={field1:field1, field1id:field1id, labelsize:75}
;XManager, 'find_best_pa', tlb, /No_Block

XManager, 'find_best_pa', tlb

;print, shared_pa

END
