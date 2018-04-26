# / / / / / / / / / / / / / / /
#   SALT_Finder_Chart.pl
# / / / / / / / / / / / / / / /
#
# This program will take in an RA and DEC and then spit out a finder
# chart based on that RA and DEC, and allow the user to modify a Position Angle.
# 
#
# NOTE - There are two lines that may need to be edited to have your idl bin path!
#        Lines 97 and Line 381
#    
$input_file = "$ARGV[0]";

$xsize = 10.0; #size of image in arcminutes
$ysize = 10.0; #size of image in arcminutes 

$slit_length = 480.0; # in pixels
$box_size = 147; # in pixels
$rss_rad = $slit_length / 2; 

# First, let's open the input file. The format is:
#
# FAKE_OBJECT RA_Hours RA_minutes RA_seconds Dec_sign Dec_Degrees Dec_Arcmin Dec_Arcsec Proposal_ID PI
#
open(INF, "$input_file") || die("input file $object_list not found");
	$k=0;
	while ($aline=<INF>) {
		chop $aline;
		($name[$k], $ra_hours[$k], $ra_minutes[$k], $ra_seconds[$k], $dec_sign[$k], 
		$dec_degrees[$k], $dec_arcmin[$k], $dec_arcsec[$k], $propid[$k], 
		$PI[$k])=split(' ',$aline);
		$k++;
	}
	$anum=$k;
close (INF);

$n_objects = scalar(@name);

# Now, for each object in the list, let's begin.
for($w = 0; $w < $n_objects; $w++){

	# First, let's convert the RA and Dec to decimal.
	$ra_decimal = 15*($ra_hours[$w] + ($ra_minutes[$w]/60) + ($ra_seconds[$w]/3600));
	$dec_decimal = ($dec_degrees[$w] + ($dec_arcmin[$w]/60) + ($dec_arcsec[$w]/3600));
	
	if ($dec_sign[$w] eq '-'){	
		$dec_decimal = $dec_decimal * -1;		
	}

	
	# Now, let's create a script to find the position angles.

	$find_pos_script="$name[$w].findpos.scr";
	if (-e $find_pos_script) {
		system("rm $find_pos_script");
	} 	
	open(FINDPOSANGLE,">>$find_pos_script") || die("The file $find_pos_script will not open!");	
	
	# The way that this will work is that it will use webget to get the image from the 
	# POSS server, and then run the idl program "find_best_pa.pro" in order to prompt
	# the user to pick a position angle for the object, which it stores in a
	# file called "position_angle.dat"
	
	print FINDPOSANGLE "set_plot,\'x\' \n";
	#print FINDPOSANGLE ".run getposangle.pro \n";
	printf FINDPOSANGLE "result = webget(\"http://stdatu.stsci.edu/cgi-bin/dss_search?v=poss2ukstu_red&r=%.7f&d=%.7f&e=J2000&h=$ysize"."&w=$xsize"."&f=fits&c=none&fov=NONE&v3=\") \n",$ra_decimal, $dec_decimal;
	print FINDPOSANGLE "COMMON SHARED, shared_image, shared_slitlength, shared_pa \n";
	print FINDPOSANGLE "shared_image = result.image \n";
	print FINDPOSANGLE "shared_slitlength = $slit_length \n";
	print FINDPOSANGLE "print, \'--------------------------------------------------\' \n";
	print FINDPOSANGLE "print, \'                  $name[$w]                       \' \n"; 
	print FINDPOSANGLE "print, \'        SELECT THE CORRECT POSITION ANGLE         \' \n"; 
	print FINDPOSANGLE "print, \'--------------------------------------------------\' \n";
	print FINDPOSANGLE "find_best_pa \n";
	print FINDPOSANGLE "finalposangle = shared_pa \n";
	#print FINDPOSANGLE "finalposangle = getposangle(result.image,$slit_length) \n";

	print FINDPOSANGLE " \n";
	print FINDPOSANGLE "hdr = result.imageheader \n";
	print FINDPOSANGLE "adxy,hdr,$ra_decimal,$dec_decimal-($ysize/2.0/60.0),x_bot,y_bot \n";
	print FINDPOSANGLE "adxy,hdr,$ra_decimal,$dec_decimal+($ysize/2.0/60.0),x_top,y_top \n";
	print FINDPOSANGLE "rot=atan((x_top-x_bot)/(y_top-y_bot))*(180./!dpi) \n";
	print FINDPOSANGLE " \n";
	print FINDPOSANGLE "openw, 33, \'position_angle.dat\' \n";
	print FINDPOSANGLE "printf, 33, strtrim(finalposangle,2) + '  ' + strtrim(rot,2),format=\'(A)\' \n";
	print FINDPOSANGLE "close, 33 \n";
	print FINDPOSANGLE " \n";
	print FINDPOSANGLE " \n";
	print FINDPOSANGLE "exit \n";
	close (FINDPOSANGLE);

	#die("I'm dying here!");

	$plot_script="$name[$w].plot.sh";
	open(PLOT,">>$plot_script") || die("The file $plot_script will not open!");	

	print PLOT "/Applications/exelis/idl84/bin/idl $find_pos_script \n";
	
	close(PLOT);
	
	# Now we run the IDL script, which is run from within a shell script.
	
	system("sh $plot_script");
	system("rm $plot_script");

	# Let's open position_angle.dat, which has the final position angle.
	open(INF, "position_angle.dat") || die("position angle file position_angle.dat not found");
		$k=0;
		while ($aline=<INF>) {
			chop $aline;
			($posangle[$k], $ang_offset[$k])=split(' ',$aline);
			$k++;
		}
		$anum=$k;
	close (INF);


	system("rm position_angle.dat");
	system("rm $find_pos_script");

	# This puts the size of the image (given as $xsize) and puts it into degrees.
		#$xsize_dec = ($xsize/2) / 60;
		#$ysize_dec = ($ysize/2) / 60;

		#$x_slope = (-1) * (($xsize_dec) / (300.0));
		#$x_y_int = $ra_decimal - ((300.0) * $x_slope);
		#$y_slope = (($ysize_dec) / (300.0));
		#$y_y_int = $dec_decimal - ((300.0) * $y_slope);

		#$left_side = ($x_slope * 0) + $x_y_int;
		#$right_side = ($x_slope * 600) + $x_y_int;

		#$bottom_side = ($y_slope * 0) + $y_y_int;
		#$top_side = ($y_slope * 600) + $y_y_int;

	# Now, let's make the final plot. We'll open a script. 
	$plotting_script="$name[$w].plot.scr";
	if (-e $plotting_script) {
		system("rm $plotting_script");
	} 	
	open(SCRIPT,">>$plotting_script") || die("The file $plotting_script will not open!");	
	
	#This is the size of the BCAM region on the final plot.
	$bcam_left = 300 - $rss_rad;
	$bcam_right = 300 + $rss_rad;

	# We are going to start by writing the position angle, getting the image, and setting
	# up the plot details, then we'll use imdisp to display the image.
#	print SCRIPT "posangle = $posangle[0] + ($ang_offset[0]) \n";
	print SCRIPT "posangle = $posangle[0] \n";
	printf SCRIPT "result = webget(\"http://stdatu.stsci.edu/cgi-bin/dss_search?v=poss2ukstu_red&r=%.7f&d=%.7f&e=J2000&h=$ysize"."&w=$xsize"."&f=fits&c=none&fov=NONE&v3=\") \n",$ra_decimal, $dec_decimal;
	print SCRIPT "set_plot, \'PS\' \n";
	print SCRIPT "device, \/color, bits_per_pixel=8, filename=\'$name[$w]".".eps\', SET_FONT='Helvetica Bold Italic', /TT_FONT, SET_CHARACTER_SIZE=[350,450] \n";
	print SCRIPT "device,/encapsulated \n";
	#print SCRIPT ".run imdisp.pro \n";
	#print SCRIPT "imdisp, result.image,\/axis, \/negative, background=255, margin=0.0 \n";
	print SCRIPT "cgimage,result.image,/negative,/KEEP_ASPECT_RATIO,xrange=[0,600],yrange=[0,600],/save \n";

	# Now we plot the various information, circles, and text on top of the plot.
	print SCRIPT "xyouts, 50, 620, \'$name[$w] ($propid[$w]; $PI[$w]) \', font=1,charsize=1 \n";

	print SCRIPT "loadct, 9 \n";
	print SCRIPT "plot_circle, 300, 300, 300, color=160, thick=2, /overplot \n";
	print SCRIPT "plot_circle, 300, 300, $rss_rad, color=160, thick=2, /overplot \n";
	print SCRIPT "oplot, [$bcam_left, 280], [300, 300], color=160, thick=1 \n";
	print SCRIPT "oplot, [320, $bcam_right], [300, 300], color=160, thick=1 \n";
	print SCRIPT "oplot, [300, 300], [$bcam_left, 280], color=160, thick=1 \n";
	print SCRIPT "oplot, [300, 300], [320, $bcam_right], color=160, thick=1 \n";

	print SCRIPT "loadct, 13 \n";
	print SCRIPT "xyouts, 513, 513, \'SCAM\', color=60, font=1,charsize=1. \n";
	print SCRIPT "xyouts, 473, 473, \'RSS\', color=60, font=1,charsize=1. \n";
	
#	print SCRIPT "xyouts, 450, 293, \'BCAM\', color=60, font=1 \n";

	print SCRIPT "xyouts, 290, 580, \'N\', color=100, font=1,charsize=1. \n";
	print SCRIPT "xyouts, 7, 293, \'E\', color=100, font=1,charsize=1. \n";

	print SCRIPT "xyouts, 260, -50, \'RA (J2000)\', font=0,charsize=1. \n";
	print SCRIPT "xyouts, -90, 290, \'Dec (J2000)\', Orientation=90.0, font=0,charsize=1. \n";
	print SCRIPT "xyouts, 7, -50, \'POSS2/UKSTU Red\', font=1,charsize=1. \n";

	print SCRIPT "loadct, 11 \n";


	# Now we'll plot the RA lines using a program called ra_lines.pl, which creates a file
	# that has the information for all of the RA lines.
	system("perl ra_lines.pl $ra_hours[$w] $ra_minutes[$w] $ra_seconds[$w] $dec_sign[$w] $dec_degrees[$w] $dec_arcmin[$w] $dec_arcsec[$w]");

	@ralines_to_print_pixel = (0);
	@ralines_to_print_name = (0);
	@ralines_to_print_name_pixel = (0);
		
	open(INF, "output_ra_lines.dat") || die("input file output_ra_lines.dat not found");
		$k=0;
		while ($aline=<INF>) {
			chop $aline;
			($ralines_to_print_pixel[$k], $ralines_to_print_name[$k], $ralines_to_print_name_pixel[$k])=split(' ',$aline);
			$k++;
		}
		$anum=$k;
	close (INF);

	$n_ra_lines = scalar(@ralines_to_print_pixel);
	
	# With output_ra_lines.dat created and opened, we can plot each line on the figure,
	# along with the major tickmarks.
	for($ralines = 0; $ralines < $n_ra_lines; $ralines++){
	
		print SCRIPT "oplot, [$ralines_to_print_pixel[$ralines], $ralines_to_print_pixel[$ralines]], [0, 600], color=60 \n";
		print SCRIPT "loadct, 0 \n";
		print SCRIPT "oplot, [$ralines_to_print_pixel[$ralines], $ralines_to_print_pixel[$ralines]], [0, 10], color=0 \n";
		print SCRIPT "oplot, [$ralines_to_print_pixel[$ralines], $ralines_to_print_pixel[$ralines]], [590, 600], color=0 \n";
		print SCRIPT "loadct, 11 \n";
		printf SCRIPT "xyouts, $ralines_to_print_name_pixel[$ralines], -20, \'$ralines_to_print_name[$ralines]\', font=0, charsize=0.6 \n";
	
	}

	# Then we clean it up.
	system("rm output_ra_lines.dat");


	# Now we do a similar thing for the Dec lines.
	
	system("perl dec_lines.pl $ra_hours[$w] $ra_minutes[$w] $ra_seconds[$w] $dec_sign[$w] $dec_degrees[$w] $dec_arcmin[$w] $dec_arcsec[$w]");
	
	@declines_to_print_pixel = (0);
	@declines_to_print_name = (0);
	@declines_to_print_name_pixel = (0);
	@declines_to_print_name_pixel_y = (0);
	
	open(INF, "output_dec_lines.dat") || die("input file output_dec_lines.dat not found");
		$k=0;
		while ($aline=<INF>) {
			chop $aline;
			($declines_to_print_pixel[$k], $declines_to_print_name[$k], $declines_to_print_name_pixel[$k], $declines_to_print_name_pixel_y[$k])=split(' ',$aline);
			$k++;
		}
		$anum=$k;
	close (INF);

	$n_dec_lines = scalar(@declines_to_print_pixel);
	
	for($declines = 0; $declines < $n_dec_lines; $declines++){
	
		print SCRIPT "oplot, [0, 600], [$declines_to_print_pixel[$declines], $declines_to_print_pixel[$declines]], color=60 \n";
		print SCRIPT "loadct, 0 \n";
		print SCRIPT "oplot, [0, 10], [$declines_to_print_pixel[$declines], $declines_to_print_pixel[$declines]], color=0 \n";
		print SCRIPT "oplot, [590, 600], [$declines_to_print_pixel[$declines], $declines_to_print_pixel[$declines]], color=0 \n";
		print SCRIPT "loadct, 11 \n";
		printf SCRIPT "xyouts, $declines_to_print_name_pixel_y[$declines], $declines_to_print_name_pixel[$declines], \'$declines_to_print_name[$declines], font=0, charsize=0.6 \n";
	
	}

	system("rm output_dec_lines.dat");

	
	# Let's create the angled BCAM box using the correct position angles. 	
	$y_one_val = (($slit_length / 2) * cos((-1)*$posangle[0] * 3.14159265/180.0)) + 300;
	$x_one_val = (($slit_length / 2) * sin((-1)*$posangle[0] * 3.14159265/180.0)) + 300;
	$x_two_val = 300 - ($x_one_val - 300);
	$y_two_val = 300 - ($y_one_val - 300);
	
	$box_ur_corner_x = 1.4142 * $box_size * cos(($posangle[0] * 3.14159265/180.0) + 3.14159265/4) + 300;
	$box_ur_corner_y = 1.4142 * $box_size * sin(($posangle[0] * 3.14159265/180.0) + 3.14159265/4) + 300;

	$box_ul_corner_x = (-1.4142)*$box_size * cos(($posangle[0] * 3.14159265/180.0) - 3.14159265/4) + 300;
	$box_ul_corner_y = (1.4142)*$box_size * sin(($posangle[0] * 3.14159265/180.0) + 3*3.14159265/4) + 300;

	$box_bl_corner_x = (-1.4142)*$box_size * cos(($posangle[0] * 3.14159265/180.0) + 3.14159265/4) + 300;
	$box_bl_corner_y = (-1.4142)*$box_size * sin(($posangle[0] * 3.14159265/180.0) + 3.14159265/4) + 300;

	$box_br_corner_x = (1.4142)*$box_size * cos(($posangle[0] * 3.14159265/180.0) - 3.14159265/4) + 300;
	$box_br_corner_y = (-1.4142)*$box_size * sin(($posangle[0] * 3.14159265/180.0) + 3*3.14159265/4) + 300;
	print SCRIPT "loadct, 9 \n";
	print SCRIPT "oplot, [$box_ur_corner_x, $box_ul_corner_x], [$box_ur_corner_y, $box_ul_corner_y], color=160, thick=2 \n";
	print SCRIPT "oplot, [$box_ul_corner_x, $box_bl_corner_x], [$box_ul_corner_y, $box_bl_corner_y], color=160, thick=2 \n";
	print SCRIPT "oplot, [$box_bl_corner_x, $box_br_corner_x], [$box_bl_corner_y, $box_br_corner_y], color=160, thick=2 \n";
	print SCRIPT "oplot, [$box_br_corner_x, $box_ur_corner_x], [$box_br_corner_y, $box_ur_corner_y], color=160, thick=2 \n";

	print SCRIPT "loadct, 11 \n";
	
	# This is the original slit code:
	#print SCRIPT "oplot, [$x_one_val, 300], [$y_one_val, 300], color=299, thick=5 \n";
	#print SCRIPT "oplot, [$x_two_val, 300], [$y_two_val, 300], color=299, thick=5 \n";
	
	# This is new slit code:
	
	$slit_size = 2.0;
	
	$slit_delta_x = $slit_size * cos((-1)*$posangle[0] * 3.14159265/180.0);
	$slit_delta_y = $slit_size * sin((-1)*$posangle[0] * 3.14159265/180.0);

	$x_one_val_new = $x_one_val - $slit_delta_x;
	$y_one_val_new = $y_one_val + $slit_delta_y;
	$x_two_val_new = $x_two_val - $slit_delta_x;
	$y_two_val_new = $y_two_val + $slit_delta_y;
	
	$center_x = 300 - $slit_delta_x;
	$center_y = 300 + $slit_delta_y;
	
	print SCRIPT "oplot, [$x_one_val_new, $center_x], [$y_one_val_new, $center_y], color=299, thick=1 \n";
	print SCRIPT "oplot, [$x_two_val_new, $center_x], [$y_two_val_new, $center_y], color=299, thick=1 \n";

	$x_one_val_new = $x_one_val + $slit_delta_x;
	$y_one_val_new = $y_one_val - $slit_delta_y;
	$x_two_val_new = $x_two_val + $slit_delta_x;
	$y_two_val_new = $y_two_val - $slit_delta_y;

	$center_x = 300 + $slit_delta_x;
	$center_y = 300 - $slit_delta_y;
		
	print SCRIPT "oplot, [$x_one_val_new, $center_x], [$y_one_val_new, $center_y], color=299, thick=1 \n";
	print SCRIPT "oplot, [$x_two_val_new, $center_x], [$y_two_val_new, $center_y], color=299, thick=1 \n";

	print SCRIPT "xyouts, 460, -50, \'PA = \'+strtrim(string(posangle, format='(f10.1)'),2)+'\!Eo!N\', font=1,charsize=1. \n";
	
	print SCRIPT "loadct, 0 \n";
	print SCRIPT "oplot, [0, 0], [0, 600], color=0, thick=4 \n";
	print SCRIPT "oplot, [600, 600], [0, 600], color=0, thick=4 \n";
	print SCRIPT "oplot, [0, 600], [600, 600], color=0, thick=4 \n";
	print SCRIPT "oplot, [0, 600], [0, 0], color=0, thick=4 \n";

	# Let's draw all of the tiny little tick marks for the RA.
	$pixel_distance = (($ralines_to_print_pixel[0] - $ralines_to_print_pixel[1]) / 5);
	for($ralines = 0; $ralines < $n_ra_lines; $ralines++){

		for($subline = 1; $subline < 5; $subline++){
			
			$subline_pixel_right = $ralines_to_print_pixel[$ralines] + ($pixel_distance * $subline);
			$subline_pixel_left = $ralines_to_print_pixel[$ralines] - ($pixel_distance * $subline);
			
			if (($subline_pixel_right >= 0) && ($subline_pixel_right <= 600)) {
				print SCRIPT "oplot, [$subline_pixel_right, $subline_pixel_right], [0, 5], color=60 \n";
				print SCRIPT "oplot, [$subline_pixel_right, $subline_pixel_right], [595, 600], color=60 \n";
			}
			if (($subline_pixel_left >= 0) && ($subline_pixel_left <= 600)) {
				print SCRIPT "oplot, [$subline_pixel_left, $subline_pixel_left], [0, 5], color=60 \n";
				print SCRIPT "oplot, [$subline_pixel_left, $subline_pixel_left], [595, 600], color=60 \n";
			}
			#print "I've run this calculation: $subline_pixel = $lines_to_print_pixel[$ralines] + ($pixel_distance * $subline)\n";
		}
		
	}


	# Let's draw all of the tiny little tick marks for the Dec.
	$pixel_distance = (($declines_to_print_pixel[0] - $declines_to_print_pixel[1]) / 5);
	for($declines = 0; $declines < $n_dec_lines; $declines++){

		for($subline = 1; $subline < 5; $subline++){
			
			$subline_pixel_up = $declines_to_print_pixel[$declines] + ($pixel_distance * $subline);
			$subline_pixel_down = $declines_to_print_pixel[$declines] - ($pixel_distance * $subline);
			
			if (($subline_pixel_down >= 0) && ($subline_pixel_down <= 600)) {
				print SCRIPT "oplot, [0, 5], [$subline_pixel_down, $subline_pixel_down], color=60 \n";
				print SCRIPT "oplot, [595, 600], [$subline_pixel_down, $subline_pixel_down], color=60 \n";
			}
			if (($subline_pixel_up >= 0) && ($subline_pixel_up <= 600)) {
				print SCRIPT "oplot, [0, 5], [$subline_pixel_up, $subline_pixel_up], color=60 \n";
				print SCRIPT "oplot, [595, 600], [$subline_pixel_up, $subline_pixel_up], color=60 \n";
			}
			#print "I've run this calculation: $subline_pixel = $lines_to_print_pixel[$ralines] + ($pixel_distance * $subline)\n";
		}
		
	}

	print SCRIPT "device, \/close \n";

	print SCRIPT "exit \n";

	close(SCRIPT);

	#die("I'm dying here!");

	# Now that we've written our plotting script, let's run it! 
	$plot_script="$name[$w].plot.sh";
	open(PLOT,">>$plot_script") || die("The file $plot_script will not open!");	

	print PLOT "/Applications/exelis/idl84/bin/idl $plotting_script \n";
		
	close(PLOT);
	
	# Let's clean things up a bit. 
	system("sh $plot_script");
	system("rm $plot_script");
	system("rm $plotting_script");

	# Now, we have to change the .eps bounding box, and convert the file to a pdf. 
	system("sed '2s/.*/%%BoundingBox: -10 -50 460 400/' $name[$w]".".eps > $name[$w]"."_new.eps");
	system("rm $name[$w]".".eps");
	system("mv $name[$w]"."_new.eps $name[$w]".".eps");
	system("epstopdf $name[$w]".".eps");

}


