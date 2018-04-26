PRO find_best_pa_event, event

COMMON SHARED

; An example event handler for FSC_Field.

Widget_Control, event.top, Get_UValue=info
Widget_Control, event.id, Get_UValue=thisEvent


; Not interested in losing keyboard focus events.
theName = Tag_Names(event, /Structure_Name)
IF theName EQ 'WIDGET_KBRD_EVENT' THEN BEGIN
   IF event.type EQ 0 THEN RETURN
ENDIF

; What kind of event is this?
CASE thisEvent OF
   'Field 1 Event': BEGIN

      ; Demonstate various ways to test if the value from this field is undefined.

      Print, ''
      IF N_Elements(*event.value) EQ 0 THEN Print, 'Field 1 Value is Undefined from Event Structure' ELSE $
         Print, 'Field 1 Value from Event Structure: ', *event.value

      Widget_Control, info.field1id, Get_Value=theValue
      IF Finite(theValue) EQ 0 THEN Print, 'Field 1 Value is Undefined and Assigned Value: ', theValue ELSE $
         Print, 'Field 1 Value via Widget Get_Value Function: ', theValue


      IF Finite(info.field1->Get_Value()) EQ 0 THEN Print, 'Field 1 Value is Undefined from Object Get_Value Function' ELSE $
         Print, 'Field 1 Value via Object Get_Value Function: ', info.field1->Get_Value()

      END
   'Field 2 Event': BEGIN
      Print, ''
      IF N_Elements(*event.value) EQ 0 THEN Print, 'Field 2 Value is Undefined' ELSE $
         Print, 'Field 2 Value: ', *event.value

      theValue = info.field2->Get_Value()
      IF theValue EQ -9999.0 THEN Print, 'Field 2 Value is Undefined and Assigned Value: ', theValue ELSE $
         Print, 'Field 2 Value via Object Get_Value Function: ', theValue

      END

   'Print It': BEGIN
      theValue =info.field3->Get_Value()
      Print, ''
      Print, 'Field 3 Value: ', theValue
      END
   'Set It': BEGIN
      info.field3->Set_Value, 'Coyote Rules!'
      END
   'Quit': Widget_Control, event.top, /Destroy
   'ChangeToUInt': BEGIN
      info.field1->SetProperty, Title='Unsigned:', Value=UINT(RandomU(seed, 1)*100)
      END
   'ChangeToFloat': BEGIN
      info.field1->SetProperty, Title='Float:', Value=RandomU(seed, 1)*100
      END
   'ChangeToString': BEGIN
      info.field1->SetProperty, Title='String:', Value='Coyote Jules'
      END
   'PrintFloat': BEGIN
      IF N_Elements(info.field1->Get_Value()) EQ 0 THEN Print, 'Field 1 Value is Undefined' ELSE $
         Print, 'Field 1 Value: ', info.field1->Get_Value()
      END
   'getPA': BEGIN
      IF N_Elements(info.field1->Get_Value()) EQ 0 THEN Print, 'Field 1 Value is Undefined' ELSE $
         
        posangle = info.field1->Get_Value()
 		posangle_new = posangle
   
    	

        
        ;imdisp, shared_image, /axis, /negative, background=255, margin=0.0
        cgimage,shared_image,/negative,xrange=[0,600],yrange=[0,600]
		;plot_circle, 300, 300, inner_circle_rad, color=100, /overplot
		plot_tickmarks, shared_slitlength

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
  
   		shared_pa = posangle
         
      END

    'goUpbig': BEGIN
      IF N_Elements(info.field1->Get_Value()) EQ 0 THEN Print, 'Field 1 Value is Undefined' ELSE $
        
 		;print, 'going up!'
        posangle = info.field1->Get_Value() 
         
        posangle_new = posangle + 0.5
         
        info.field1->SetProperty, Value=posangle_new
 		
        ;imdisp, shared_image, /axis, /negative, background=255, margin=0.0
        cgimage,shared_image,/negative,xrange=[0,600],yrange=[0,600]

		;plot_circle, 300, 300, inner_circle_rad, color=100, /overplot
		plot_tickmarks, shared_slitlength

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
 		
 		shared_pa = posangle
         
      END
      
    'goUp': BEGIN
      IF N_Elements(info.field1->Get_Value()) EQ 0 THEN Print, 'Field 1 Value is Undefined' ELSE $
        
 		;print, 'going up!'
        posangle = info.field1->Get_Value() 
         
        posangle_new = posangle + 0.1
         
        info.field1->SetProperty, Value=posangle_new
 		
        ;imdisp, shared_image, /axis, /negative, background=255, margin=0.0
		cgimage,shared_image,/negative,xrange=[0,600],yrange=[0,600]

		;plot_circle, 300, 300, inner_circle_rad, color=100, /overplot
		plot_tickmarks, shared_slitlength

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
 		
 		shared_pa = posangle
         
      END
      
    'goDown': BEGIN
      IF N_Elements(info.field1->Get_Value()) EQ 0 THEN Print, 'Field 1 Value is Undefined' ELSE $

		;print, 'going down!'
        posangle = info.field1->Get_Value() 
 
        posangle_new = posangle - 0.1

        info.field1->SetProperty, Value=posangle_new

        ;imdisp, shared_image, /axis, /negative, background=255, margin=0.0
        cgimage,shared_image,/negative,xrange=[0,600],yrange=[0,600]

		;plot_circle, 300, 300, inner_circle_rad, color=100, /overplot
		plot_tickmarks, shared_slitlength

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
 
  		shared_pa = posangle
         
      END

    'goDownbig': BEGIN
      IF N_Elements(info.field1->Get_Value()) EQ 0 THEN Print, 'Field 1 Value is Undefined' ELSE $

		;print, 'going down!'
        posangle = info.field1->Get_Value() 
 
        posangle_new = posangle - 0.5 

        info.field1->SetProperty, Value=posangle_new

        ;imdisp, shared_image, /axis, /negative, background=255, margin=0.0
		cgimage,shared_image,/negative,xrange=[0,600],yrange=[0,600]

		;plot_circle, 300, 300, inner_circle_rad, color=100, /overplot
		plot_tickmarks, shared_slitlength

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
 
  		shared_pa = posangle
         
      END      
      
   'LabelSize': BEGIN
      Widget_Control, event.top, Update=0
      currentSize = info.labelsize
      info.field1->SetProperty, LabelSize=info.labelsize
      info.field2->SetProperty, LabelSize=info.labelsize
      info.field3->SetProperty, LabelSize=info.labelsize
      IF currentsize EQ 75 THEN info.labelsize = 50 ELSE info.labelsize = 75
      Widget_Control, event.top, Update=1
      END
   'MakeEditable': BEGIN
      Widget_Control, event.id, Get_Value=buttonValue
      CASE buttonValue OF
         'Make String Field Editable': BEGIN
            info.field3->SetEdit, 1
            Widget_Control, event.id, Set_Value='Make String Field Non-Editable'
            END
         'Make String Field Non-Editable': BEGIN
            info.field3->SetEdit, 0
            Widget_Control, event.id, Set_Value='Make String Field Editable'
            END
      ENDCASE
      END
   'MakeSensitive': BEGIN
      Widget_Control, event.id, Get_Value=buttonValue
      CASE buttonValue OF
         'Make String Field Sensitive': BEGIN
            info.field3->SetSensitive, 1
            Widget_Control, event.id, Set_Value='Make String Field Non-Sensitive'
            END
         'Make String Field Non-Sensitive': BEGIN
            info.field3->SetSensitive, 0
            Widget_Control, event.id, Set_Value='Make String Field Sensitive'
            END
      ENDCASE
      END
ENDCASE

IF Widget_Info(event.top, /Valid_ID) THEN Widget_Control, event.top, Set_UValue=info
END ;--------------------------------------------------------------------------------------------------------------
