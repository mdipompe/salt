pro plot_tickmarks, slitlength

	inside_slitlength = slitlength - 0.1 * slitlength
	
	yonetick = ((slitlength / 2.0) * cos((-1)*0 * 3.14159265/180.0))+300
	xonetick = ((slitlength / 2.0) * sin((-1)*0 * 3.14159265/180.0))+300
	xtwotick = 300 - (xonetick - 300)
	ytwotick = 300 - (yonetick - 300)
	yoneticktwo = ((inside_slitlength / 2.0) * cos((-1)*0 * 3.14159265/180.0))+300
	xoneticktwo = ((inside_slitlength / 2.0) * sin((-1)*0 * 3.14159265/180.0))+300
	xtwoticktwo = 300 - (xoneticktwo - 300)
	ytwoticktwo = 300 - (yoneticktwo - 300)
	oplot, [xonetick, xoneticktwo], [yonetick, yoneticktwo], color=230, thick=0.5
	oplot, [xtwotick, xtwoticktwo], [ytwotick, ytwoticktwo], color=230, thick=0.5

	xyouts, xonetick, yonetick, '0'+string(176b), color=0

	yonetick = ((slitlength / 2.0) * cos((-1)*10 * 3.14159265/180.0))+300
	xonetick = ((slitlength / 2.0) * sin((-1)*10 * 3.14159265/180.0))+300
	xtwotick = 300 - (xonetick - 300)
	ytwotick = 300 - (yonetick - 300)
	yoneticktwo = ((inside_slitlength / 2.0) * cos((-1)*10 * 3.14159265/180.0))+300
	xoneticktwo = ((inside_slitlength / 2.0) * sin((-1)*10 * 3.14159265/180.0))+300
	xtwoticktwo = 300 - (xoneticktwo - 300)
	ytwoticktwo = 300 - (yoneticktwo - 300)
	oplot, [xonetick, xoneticktwo], [yonetick, yoneticktwo], color=230, thick=0.5
	oplot, [xtwotick, xtwoticktwo], [ytwotick, ytwoticktwo], color=230, thick=0.5

	xyouts, xonetick, yonetick, '10'+string(176b), color=0

	yonetick = ((slitlength / 2.0) * cos((-1)*20 * 3.14159265/180.0))+300
	xonetick = ((slitlength / 2.0) * sin((-1)*20 * 3.14159265/180.0))+300
	xtwotick = 300 - (xonetick - 300)
	ytwotick = 300 - (yonetick - 300)
	yoneticktwo = ((inside_slitlength / 2.0) * cos((-1)*20 * 3.14159265/180.0))+300
	xoneticktwo = ((inside_slitlength / 2.0) * sin((-1)*20 * 3.14159265/180.0))+300
	xtwoticktwo = 300 - (xoneticktwo - 300)
	ytwoticktwo = 300 - (yoneticktwo - 300)
	oplot, [xonetick, xoneticktwo], [yonetick, yoneticktwo], color=230, thick=0.5
	oplot, [xtwotick, xtwoticktwo], [ytwotick, ytwoticktwo], color=230, thick=0.5

	xyouts, xonetick, yonetick, '20'+string(176b), color=0

	yonetick = ((slitlength / 2.0) * cos((-1)*30 * 3.14159265/180.0))+300
	xonetick = ((slitlength / 2.0) * sin((-1)*30 * 3.14159265/180.0))+300
	xtwotick = 300 - (xonetick - 300)
	ytwotick = 300 - (yonetick - 300)
	yoneticktwo = ((inside_slitlength / 2.0) * cos((-1)*30 * 3.14159265/180.0))+300
	xoneticktwo = ((inside_slitlength / 2.0) * sin((-1)*30 * 3.14159265/180.0))+300
	xtwoticktwo = 300 - (xoneticktwo - 300)
	ytwoticktwo = 300 - (yoneticktwo - 300)
	oplot, [xonetick, xoneticktwo], [yonetick, yoneticktwo], color=230, thick=0.5
	oplot, [xtwotick, xtwoticktwo], [ytwotick, ytwoticktwo], color=230, thick=0.5

	xyouts, xonetick, yonetick, '30'+string(176b), color=0

	yonetick = ((slitlength / 2.0) * cos((-1)*40 * 3.14159265/180.0))+300
	xonetick = ((slitlength / 2.0) * sin((-1)*40 * 3.14159265/180.0))+300
	xtwotick = 300 - (xonetick - 300)
	ytwotick = 300 - (yonetick - 300)
	yoneticktwo = ((inside_slitlength / 2.0) * cos((-1)*40 * 3.14159265/180.0))+300
	xoneticktwo = ((inside_slitlength / 2.0) * sin((-1)*40 * 3.14159265/180.0))+300
	xtwoticktwo = 300 - (xoneticktwo - 300)
	ytwoticktwo = 300 - (yoneticktwo - 300)
	oplot, [xonetick, xoneticktwo], [yonetick, yoneticktwo], color=230, thick=0.5
	oplot, [xtwotick, xtwoticktwo], [ytwotick, ytwoticktwo], color=230, thick=0.5

	xyouts, xonetick, yonetick, '40'+string(176b), color=0

	yonetick = ((slitlength / 2.0) * cos((-1)*50 * 3.14159265/180.0))+300
	xonetick = ((slitlength / 2.0) * sin((-1)*50 * 3.14159265/180.0))+300
	xtwotick = 300 - (xonetick - 300)
	ytwotick = 300 - (yonetick - 300)
	yoneticktwo = ((inside_slitlength / 2.0) * cos((-1)*50 * 3.14159265/180.0))+300
	xoneticktwo = ((inside_slitlength / 2.0) * sin((-1)*50 * 3.14159265/180.0))+300
	xtwoticktwo = 300 - (xoneticktwo - 300)
	ytwoticktwo = 300 - (yoneticktwo - 300)
	oplot, [xonetick, xoneticktwo], [yonetick, yoneticktwo], color=230, thick=0.5
	oplot, [xtwotick, xtwoticktwo], [ytwotick, ytwoticktwo], color=230, thick=0.5

	xyouts, xonetick, yonetick, '50'+string(176b), color=0

	yonetick = ((slitlength / 2.0) * cos((-1)*60 * 3.14159265/180.0))+300
	xonetick = ((slitlength / 2.0) * sin((-1)*60 * 3.14159265/180.0))+300
	xtwotick = 300 - (xonetick - 300)
	ytwotick = 300 - (yonetick - 300)
	yoneticktwo = ((inside_slitlength / 2.0) * cos((-1)*60 * 3.14159265/180.0))+300
	xoneticktwo = ((inside_slitlength / 2.0) * sin((-1)*60 * 3.14159265/180.0))+300
	xtwoticktwo = 300 - (xoneticktwo - 300)
	ytwoticktwo = 300 - (yoneticktwo - 300)
	oplot, [xonetick, xoneticktwo], [yonetick, yoneticktwo], color=230, thick=0.5
	oplot, [xtwotick, xtwoticktwo], [ytwotick, ytwoticktwo], color=230, thick=0.5

	xyouts, xonetick, yonetick, '60'+string(176b), color=0

	yonetick = ((slitlength / 2.0) * cos((-1)*70 * 3.14159265/180.0))+300
	xonetick = ((slitlength / 2.0) * sin((-1)*70 * 3.14159265/180.0))+300
	xtwotick = 300 - (xonetick - 300)
	ytwotick = 300 - (yonetick - 300)
	yoneticktwo = ((inside_slitlength / 2.0) * cos((-1)*70 * 3.14159265/180.0))+300
	xoneticktwo = ((inside_slitlength / 2.0) * sin((-1)*70 * 3.14159265/180.0))+300
	xtwoticktwo = 300 - (xoneticktwo - 300)
	ytwoticktwo = 300 - (yoneticktwo - 300)
	oplot, [xonetick, xoneticktwo], [yonetick, yoneticktwo], color=230, thick=0.5
	oplot, [xtwotick, xtwoticktwo], [ytwotick, ytwoticktwo], color=230, thick=0.5

	xyouts, xonetick, yonetick, '70'+string(176b), color=0

	yonetick = ((slitlength / 2.0) * cos((-1)*80 * 3.14159265/180.0))+300
	xonetick = ((slitlength / 2.0) * sin((-1)*80 * 3.14159265/180.0))+300
	xtwotick = 300 - (xonetick - 300)
	ytwotick = 300 - (yonetick - 300)
	yoneticktwo = ((inside_slitlength / 2.0) * cos((-1)*80 * 3.14159265/180.0))+300
	xoneticktwo = ((inside_slitlength / 2.0) * sin((-1)*80 * 3.14159265/180.0))+300
	xtwoticktwo = 300 - (xoneticktwo - 300)
	ytwoticktwo = 300 - (yoneticktwo - 300)
	oplot, [xonetick, xoneticktwo], [yonetick, yoneticktwo], color=230, thick=0.5
	oplot, [xtwotick, xtwoticktwo], [ytwotick, ytwoticktwo], color=230, thick=0.5

	xyouts, xonetick, yonetick, '80'+string(176b), color=0

	yonetick = ((slitlength / 2.0) * cos((-1)*90 * 3.14159265/180.0))+300
	xonetick = ((slitlength / 2.0) * sin((-1)*90 * 3.14159265/180.0))+300
	xtwotick = 300 - (xonetick - 300)
	ytwotick = 300 - (yonetick - 300)
	yoneticktwo = ((inside_slitlength / 2.0) * cos((-1)*90 * 3.14159265/180.0))+300
	xoneticktwo = ((inside_slitlength / 2.0) * sin((-1)*90 * 3.14159265/180.0))+300
	xtwoticktwo = 300 - (xoneticktwo - 300)
	ytwoticktwo = 300 - (yoneticktwo - 300)
	oplot, [xonetick, xoneticktwo], [yonetick, yoneticktwo], color=230, thick=0.5
	oplot, [xtwotick, xtwoticktwo], [ytwotick, ytwoticktwo], color=230, thick=0.5

	xyouts, xonetick, yonetick, '90'+string(176b), color=0


	yonetick = ((slitlength / 2.0) * cos((-1)*(-10) * 3.14159265/180.0))+300
	xonetick = ((slitlength / 2.0) * sin((-1)*(-10) * 3.14159265/180.0))+300
	xtwotick = 300 - (xonetick - 300)
	ytwotick = 300 - (yonetick - 300)
	yoneticktwo = ((inside_slitlength / 2.0) * cos((-1)*(-10) * 3.14159265/180.0))+300
	xoneticktwo = ((inside_slitlength / 2.0) * sin((-1)*(-10) * 3.14159265/180.0))+300
	xtwoticktwo = 300 - (xoneticktwo - 300)
	ytwoticktwo = 300 - (yoneticktwo - 300)
	oplot, [xonetick, xoneticktwo], [yonetick, yoneticktwo], color=230, thick=0.5
	oplot, [xtwotick, xtwoticktwo], [ytwotick, ytwoticktwo], color=230, thick=0.5

	xyouts, xonetick, yonetick, '-10'+string(176b), color=0

	yonetick = ((slitlength / 2.0) * cos((-1)*(-20) * 3.14159265/180.0))+300
	xonetick = ((slitlength / 2.0) * sin((-1)*(-20) * 3.14159265/180.0))+300
	xtwotick = 300 - (xonetick - 300)
	ytwotick = 300 - (yonetick - 300)
	yoneticktwo = ((inside_slitlength / 2.0) * cos((-1)*(-20) * 3.14159265/180.0))+300
	xoneticktwo = ((inside_slitlength / 2.0) * sin((-1)*(-20) * 3.14159265/180.0))+300
	xtwoticktwo = 300 - (xoneticktwo - 300)
	ytwoticktwo = 300 - (yoneticktwo - 300)
	oplot, [xonetick, xoneticktwo], [yonetick, yoneticktwo], color=230, thick=0.5
	oplot, [xtwotick, xtwoticktwo], [ytwotick, ytwoticktwo], color=230, thick=0.5

	xyouts, xonetick, yonetick, '-20'+string(176b), color=0

	yonetick = ((slitlength / 2.0) * cos((-1)*(-30) * 3.14159265/180.0))+300
	xonetick = ((slitlength / 2.0) * sin((-1)*(-30) * 3.14159265/180.0))+300
	xtwotick = 300 - (xonetick - 300)
	ytwotick = 300 - (yonetick - 300)
	yoneticktwo = ((inside_slitlength / 2.0) * cos((-1)*(-30) * 3.14159265/180.0))+300
	xoneticktwo = ((inside_slitlength / 2.0) * sin((-1)*(-30) * 3.14159265/180.0))+300
	xtwoticktwo = 300 - (xoneticktwo - 300)
	ytwoticktwo = 300 - (yoneticktwo - 300)
	oplot, [xonetick, xoneticktwo], [yonetick, yoneticktwo], color=230, thick=0.5
	oplot, [xtwotick, xtwoticktwo], [ytwotick, ytwoticktwo], color=230, thick=0.5

	xyouts, xonetick, yonetick, '-30'+string(176b), color=0

	yonetick = ((slitlength / 2.0) * cos((-1)*(-40) * 3.14159265/180.0))+300
	xonetick = ((slitlength / 2.0) * sin((-1)*(-40) * 3.14159265/180.0))+300
	xtwotick = 300 - (xonetick - 300)
	ytwotick = 300 - (yonetick - 300)
	yoneticktwo = ((inside_slitlength / 2.0) * cos((-1)*(-40) * 3.14159265/180.0))+300
	xoneticktwo = ((inside_slitlength / 2.0) * sin((-1)*(-40) * 3.14159265/180.0))+300
	xtwoticktwo = 300 - (xoneticktwo - 300)
	ytwoticktwo = 300 - (yoneticktwo - 300)
	oplot, [xonetick, xoneticktwo], [yonetick, yoneticktwo], color=230, thick=0.5
	oplot, [xtwotick, xtwoticktwo], [ytwotick, ytwoticktwo], color=230, thick=0.5

	xyouts, xonetick, yonetick, '-40'+string(176b), color=0

	yonetick = ((slitlength / 2.0) * cos((-1)*(-50) * 3.14159265/180.0))+300
	xonetick = ((slitlength / 2.0) * sin((-1)*(-50) * 3.14159265/180.0))+300
	xtwotick = 300 - (xonetick - 300)
	ytwotick = 300 - (yonetick - 300)
	yoneticktwo = ((inside_slitlength / 2.0) * cos((-1)*(-50) * 3.14159265/180.0))+300
	xoneticktwo = ((inside_slitlength / 2.0) * sin((-1)*(-50) * 3.14159265/180.0))+300
	xtwoticktwo = 300 - (xoneticktwo - 300)
	ytwoticktwo = 300 - (yoneticktwo - 300)
	oplot, [xonetick, xoneticktwo], [yonetick, yoneticktwo], color=230, thick=0.5
	oplot, [xtwotick, xtwoticktwo], [ytwotick, ytwoticktwo], color=230, thick=0.5

	xyouts, xonetick, yonetick, '-50'+string(176b), color=0

	yonetick = ((slitlength / 2.0) * cos((-1)*(-60) * 3.14159265/180.0))+300
	xonetick = ((slitlength / 2.0) * sin((-1)*(-60) * 3.14159265/180.0))+300
	xtwotick = 300 - (xonetick - 300)
	ytwotick = 300 - (yonetick - 300)
	yoneticktwo = ((inside_slitlength / 2.0) * cos((-1)*(-60) * 3.14159265/180.0))+300
	xoneticktwo = ((inside_slitlength / 2.0) * sin((-1)*(-60) * 3.14159265/180.0))+300
	xtwoticktwo = 300 - (xoneticktwo - 300)
	ytwoticktwo = 300 - (yoneticktwo - 300)
	oplot, [xonetick, xoneticktwo], [yonetick, yoneticktwo], color=230, thick=0.5
	oplot, [xtwotick, xtwoticktwo], [ytwotick, ytwoticktwo], color=230, thick=0.5

	xyouts, xonetick, yonetick, '-60'+string(176b), color=0

	yonetick = ((slitlength / 2.0) * cos((-1)*(-70) * 3.14159265/180.0))+300
	xonetick = ((slitlength / 2.0) * sin((-1)*(-70) * 3.14159265/180.0))+300
	xtwotick = 300 - (xonetick - 300)
	ytwotick = 300 - (yonetick - 300)
	yoneticktwo = ((inside_slitlength / 2.0) * cos((-1)*(-70) * 3.14159265/180.0))+300
	xoneticktwo = ((inside_slitlength / 2.0) * sin((-1)*(-70) * 3.14159265/180.0))+300
	xtwoticktwo = 300 - (xoneticktwo - 300)
	ytwoticktwo = 300 - (yoneticktwo - 300)
	oplot, [xonetick, xoneticktwo], [yonetick, yoneticktwo], color=230, thick=0.5
	oplot, [xtwotick, xtwoticktwo], [ytwotick, ytwoticktwo], color=230, thick=0.5

	xyouts, xonetick, yonetick, '-70'+string(176b), color=0

	yonetick = ((slitlength / 2.0) * cos((-1)*(-80) * 3.14159265/180.0))+300
	xonetick = ((slitlength / 2.0) * sin((-1)*(-80) * 3.14159265/180.0))+300
	xtwotick = 300 - (xonetick - 300)
	ytwotick = 300 - (yonetick - 300)
	yoneticktwo = ((inside_slitlength / 2.0) * cos((-1)*(-80) * 3.14159265/180.0))+300
	xoneticktwo = ((inside_slitlength / 2.0) * sin((-1)*(-80) * 3.14159265/180.0))+300
	xtwoticktwo = 300 - (xoneticktwo - 300)
	ytwoticktwo = 300 - (yoneticktwo - 300)
	oplot, [xonetick, xoneticktwo], [yonetick, yoneticktwo], color=230, thick=0.5
	oplot, [xtwotick, xtwoticktwo], [ytwotick, ytwoticktwo], color=230, thick=0.5

	xyouts, xonetick, yonetick, '-80'+string(176b), color=0

	yonetick = ((slitlength / 2.0) * cos((-1)*(-90) * 3.14159265/180.0))+300
	xonetick = ((slitlength / 2.0) * sin((-1)*(-90) * 3.14159265/180.0))+300
	xtwotick = 300 - (xonetick - 300)
	ytwotick = 300 - (yonetick - 300)
	yoneticktwo = ((inside_slitlength / 2.0) * cos((-1)*(-90) * 3.14159265/180.0))+300
	xoneticktwo = ((inside_slitlength / 2.0) * sin((-1)*(-90) * 3.14159265/180.0))+300
	xtwoticktwo = 300 - (xoneticktwo - 300)
	ytwoticktwo = 300 - (yoneticktwo - 300)
	oplot, [xonetick, xoneticktwo], [yonetick, yoneticktwo], color=230, thick=0.5
	oplot, [xtwotick, xtwoticktwo], [ytwotick, ytwoticktwo], color=230, thick=0.5

	xyouts, xonetick, yonetick, '-90'+string(176b), color=0

	return
	end