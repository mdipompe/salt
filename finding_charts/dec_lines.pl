# Provided the center of an image and the size of the image, this subroutine
# returns the minimum DEC on the minimum side.  
# This takes in an array of RA and DEC in degrees. 
sub get_min_max_dec{

	@input_min_max_ra_data = @_;

	my $ra = $input_min_max_ra_data[0];
	my $dec = $input_min_max_ra_data[1];
	
	#printf "getminmax input: $input_min_max_ra_data[0], $input_min_max_ra_data[1] \n";
	
	my $new_y_slope = dec_slope(); 
	my $new_y_y_int = dec_yint($input_min_max_ra_data[1]);
		
	my $bottom_side = ($y_slope * 0) + $y_y_int;
	my $top_side = ($y_slope * $number_of_pixels_across) + $y_y_int;
	@return_sides = ($bottom_side, $top_side);

	return @return_sides;

}

# This takes in an array of DEC in degrees, and returns the slope for calculating the 
# DEC given a pixel value. 
sub dec_slope{

	my $ysize_dec = (($ysize/2) / 60);
	$y_slope = (($ysize_dec) / ($number_of_pixels_across / 2));

	return $y_slope;

}

# This takes in an array of DEC in degrees, and returns the y intercept for calculating the 
# DEC given a pixel value. 
sub dec_yint{

	$input_dec_slope_yint = $_[0];	
	
	$y_y_int = $input_dec_slope_yint - (($number_of_pixels_across / 2) * $y_slope);
	#print "xslope = $x_y_int = $input_ra_slope_yint[0] - (($number_of_pixels_across / 2) * $x_slope); \n";

	return $y_y_int;

}

# This routine takes in an RA array, in hours, and returns an RA in decimal.
sub ra_hours_to_dec{
	@input_ra_data = @_;
	my $ra_hours = $input_ra_data[0];
	my $ra_minutes = $input_ra_data[1];
	my $ra_seconds = $input_ra_data[2];
	$ra_dec = 15.0 * ($ra_hours + ($ra_minutes / 60.0) + ($ra_seconds / 3600.0));
	return $ra_dec;
}

# This routine takes in a Dec array, in degrees, and returns a Dec in decimal.
sub dec_deg_to_dec{
	@input_dec_data = @_;
	my $dec_degrees = $input_dec_data[1];
	my $dec_arcminutes = $input_dec_data[2];
	my $dec_arcseconds = $input_dec_data[3];

	$dec_dec = ($dec_degrees + ($dec_arcminutes / 60.0) + ($dec_arcseconds / 3600.0));
	
	if ($input_dec_data[0] eq '-'){
		$dec_dec = $dec_dec * (-1);
	}


	return $dec_dec;
}

# This routine takes in an RA in degrees, and returns an RA array with the entries being
# hours, minutes, seconds.
sub ra_dec_to_hours{
	my $input_ra_data = $_[0];
	my $ra_dec = $input_ra_data;
	my $ra_dec_hours = $ra_dec / 15.0;	
	my $ra_hours = int($ra_dec_hours);
	my $remainder = $ra_dec_hours - $ra_hours;
	my $ra_minutes = int(60.0 * $remainder);
	my $remainder = (60.0 * $remainder) - $ra_minutes;
	my $ra_seconds = (60.0 * $remainder);
	return ($ra_hours, $ra_minutes, $ra_seconds);	
}

# This routine takes in a Dec in degrees, and returns a Dec array with the entries being
# sign, degrees, arcminutes, arcseconds.
sub dec_dec_to_hours{
	my $input_dec_data = $_[0];
	my $dec_dec = $input_dec_data;
	
	if ($dec_dec < 0.0){
		$dec_sign = '-';
		$dec_dec = $dec_dec * (-1.0);
	}
	else {
		$dec_sign = '+';
	}
	
	my $dec_hours = int($dec_dec);
	my $remainder = $dec_dec - $dec_hours;
	my $dec_arcminutes = int(60.0 * $remainder);
	my $remainder = (60.0 * $remainder) - $dec_arcminutes;
	my $dec_arcseconds = (60.0 * $remainder);
	return ($dec_sign, $dec_hours, $dec_arcminutes, $dec_arcseconds);	
}

# This subroutine takes in the decimal values for the min_max_dec, and then returns
# the position of the bottom line, in degrees, arcminutes, and arcseconds.
sub find_first_line{
	my @min_max_dec = @_;
	my @output_bottom_side_degrees = dec_dec_to_hours($min_max_dec[0]);
	my @output_top_side_degrees = dec_dec_to_hours($min_max_dec[1]);

	if ($output_bottom_side_degrees[0] eq '+'){

		my $bottom_side_line_int = (int(($output_bottom_side_degrees[2] / $line_distance)) * $line_distance) + $line_distance;
		
		#print "test: $bottom_side_line_int \n";
	
		if ($bottom_side_line_int == 60){
			$output_bottom_side_degrees[1] = ($bottom_right_side_degrees[1] + 1.0);
			$bottom_side_line_int = 0.0;
			
			#print "$output_bottom_side_hours[0],$output_bottom_side_hours[1],$bottom_side_line_int,0.0 \n";
			
				if ($output_bottom_side_hours[1] == 360){
					$output_bottom_side_hours[1] = 0;	
				}
		}
		
		@bottom_side_line = ($output_bottom_side_hours[0],$output_bottom_side_hours[1],$bottom_side_line_int,0.00);	
		return @bottom_side_line;
	
	}

	if ($output_bottom_side_degrees[0] eq '-'){

		my $bottom_side_line_int = (int(($output_bottom_side_degrees[2] / $line_distance)) * $line_distance);
			
		if ($bottom_side_line_int == 60){
			$output_bottom_side_degrees[1] = ($bottom_right_side_degrees[1] - 1.0);
			$bottom_side_line_int = 0.0;
			
			print "$output_bottom_side_hours[0],$output_bottom_side_hours[1],$bottom_side_line_int,0.0 \n";
			
				if ($output_bottom_side_hours[1] == 360){
					$output_bottom_side_hours[1] = 0;	
				}
		}
		
		@bottom_side_line = ($output_bottom_side_hours[0],$output_bottom_side_hours[1],$bottom_side_line_int,0.00);	
		return @bottom_side_line;
	
	}	
	
}

# This subroutine takes in the degrees, arcminutes, and arcseconds values for a horizontal
#line and then returns the position of the next line up, in degrees, arcminutes, and arcseconds.
sub find_next_line{
	my @line_degrees = @_;


	if ($line_degrees[0] eq '+'){

		$new_line_int = $line_degrees[2] + $line_distance;
		
		#print "test: $line_degrees[0] $line_degrees[1] $line_degrees[2] $line_degrees[3]:  $new_line_int \n";
	
		if ($new_line_int == 60){
			$line_degrees[1] = ($line_degrees[1] + 1.0);
			$new_line_int = 0.0;
					
				if ($line_degrees[1] == 60){
					$line_degrees[1] = 0;	
				}
		}
	
		@new_line = ($line_degrees[0],$line_degrees[1],$new_line_int,0.00);	
		#print "new_line = ($line_hours[0],$line_hours[1],$new_line_int,0.00) \n";
		return @new_line;
		
	}

	if ($line_degrees[0] eq '-'){

		$new_line_int = $line_degrees[2] - $line_distance;
		
		#print "test: $line_degrees[0] $line_degrees[1] $line_degrees[2] $line_degrees[3]:  $new_line_int \n";
		
		if ($new_line_int == (-1 * $line_distance)){
			
			if ($line_degrees[1] == 0){
				$new_line_int = $line_distance;			
				$line_degrees[0] = '+';
			}
			else {
				$line_degrees[1] = ($line_degrees[1] - 1.0);
				$new_line_int = (60 - $line_distance);
			}
			
		}
	
		@new_line = ($line_degrees[0],$line_degrees[1],$new_line_int,0.00);	
		#print "new_line = ($line_hours[0],$line_hours[1],$new_line_int,0.00) \n";
		return @new_line;

	}


	
}

# The input to the program is the RA and DEC of the center of the image, given with
# individual entries. 
@input_ra = ($ARGV[0], $ARGV[1], $ARGV[2]);
@input_dec = ($ARGV[3], $ARGV[4], $ARGV[5], $ARGV[6]);

# These are for testing the program.
#@input_ra = (16.0, 30.0, 32.64);
#@input_dec = ('+', 39.0, 23.0, 3.09);

#@input_ra = (12.0, 34.0, 53.92);
#@input_dec = ('-', 00.0, 1.0, 5.07);

$xsize = 10; #in arcminutes
$ysize = 10; #in arcminutes
$number_of_pixels_across = 600;
$number_of_pixels_updown = 600;

$line_distance = 2.0; #in arcseconds

#print "Input RA: $input_ra[0]h $input_ra[1]m $input_ra[2]s \n";
#print "Input DEC: $input_dec[0]"."$input_dec[1]d $input_dec[2]\' $input_dec[3]\" \n";

$ra_dec = ra_hours_to_dec(@input_ra);
$dec_dec = dec_deg_to_dec(@input_dec);
@dec_hex_test = dec_dec_to_hours($dec_dec);

#printf "degrees: $ra_dec, $dec_dec, $dec_hex_test[0]"."$dec_hex_test[1]"."d "."$dec_hex_test[2]"."\' "."%.2f"."\" \n", $dec_hex_test[3];

@min_max_dec = get_min_max_dec(($ra_dec, $dec_dec));

$line_y_slope = dec_slope(); 
$line_y_y_int = dec_yint($dec_dec);
#print "new line y slope: $line_y_slope \n";
#print "new line yint: $line_y_y_int \n";

@output_bottom_side_hours = dec_dec_to_hours($min_max_dec[0]);
@output_top_side_hours = dec_dec_to_hours($min_max_dec[1]);

#printf "output bottom side = $output_bottom_side_hours[0] $output_bottom_side_hours[1] $output_bottom_side_hours[2] %.2f \n", $output_bottom_side_hours[3];
#printf "output top side = $output_top_side_hours[0] $output_top_side_hours[1] $output_top_side_hours[2] %.2f \n", $output_top_side_hours[3];



open(OUTPUTLINES,">>output_dec_lines.dat") || die("The file output_dec_lines.dat will not open!");	

@first_line = find_first_line(@min_max_dec);
$first_line_dec = dec_deg_to_dec(@first_line);
#printf "The first line will be at: $first_line[0] $first_line[1] $first_line[2] %.2f \n", $first_line[3];

$lines_to_print_dec_sign[0] = $first_line[0];
$lines_to_print_dec_degrees[0] = $first_line[1];
$lines_to_print_dec_arcminutes[0] = $first_line[2];
$lines_to_print_dec_arcseconds[0] = $first_line[3];
$lines_to_print_dec_dec[0] = $first_line_dec;

if ( ($first_line[1] < 10) && ($first_line[1] >= 0) ){

	if (($first_line[2] < 10) && ($first_line[2] >= 0)){
		$lines_to_print_name[0] = "$first_line[0]"."0"."$first_line[1]!Eo!N"."0"."$first_line[2]\'+string(39B)+\'00.0\'+string(39B)+string(39B)";
	}
	else {
		$lines_to_print_name[0] = "$first_line[0]"."0"."$first_line[1]!Eo!N"."$first_line[2]\'+string(39B)+\'00.0\'+string(39B)+string(39B)";
	}

}
else {

	if (($first_line[2] < 10) && ($first_line[2] >= 0)){
		$lines_to_print_name[0] = "$first_line[0]$first_line[1]!Eo!N"."0"."$first_line[2]\'+string(39B)+\'00.0\'+string(39B)+string(39B)";
	}
	else {
		$lines_to_print_name[0] = "$first_line[0]$first_line[1]!Eo!N"."$first_line[2]\'+string(39B)+\'00.0\'+string(39B)+string(39B)";
	}

}

$lines_to_print_name_pixel[0] = (($first_line_dec - $line_y_y_int) / $line_y_slope) - 5;
$lines_to_print_pixel[0] = (($first_line_dec - $line_y_y_int) / $line_y_slope);
$lines_to_print_name_pixel_y[0] = -72;
printf OUTPUTLINES "$lines_to_print_pixel[0] $lines_to_print_name[0] $lines_to_print_name_pixel[0] $lines_to_print_name_pixel_y[0] \n";
@next_line = @first_line;

$nline = 0;

$has_crossed_edge = 0;

while ($has_crossed_edge == 0){

	@next_line = find_next_line(@next_line);
	$next_line_dec = dec_deg_to_dec(@next_line);
	
	#print "The next line will be at: $next_line[0] $next_line[1] $next_line[2] $next_line[3] \n";

	if ($next_line_dec > $min_max_dec[1]){
		$has_crossed_edge = 1;
	}
	else {
	
		$nline++;
		#print "The next line will be at: $next_line[0] $next_line[1] $next_line[2] (compare $next_line_dec to $min_max_ra[0]) \n";
		$lines_to_print_dec_sign[$nline] = $next_line[0];
		$lines_to_print_dec_degrees[$nline] = $next_line[1];
		$lines_to_print_dec_arcminutes[$nline] = $next_line[2];
		$lines_to_print_dec_arcseconds[$nline] = $next_line[3];
		$lines_to_print_dec_dec[$nline] = $next_line_dec;
		$lines_to_print_pixel[$nline] = ($next_line_dec - $line_y_y_int) / $line_y_slope ;
		
		if (($next_line[2] == 0) && ($next_line[1] != 0)) {
		
			#$lines_to_print_name[$nline] = "$next_line[0]$next_line[1]!Eo!N"."$next_line[2]\'"."0.00\"";
			
			if (($next_line[2] < 10) && ($next_line[2] >= 0)){
				$lines_to_print_name[$nline] = "$next_line[0]$next_line[1]!Eo!N"."0"."$next_line[2]\'+string(39B)+\'"."00.0\'+string(39B)+string(39B)";
			}
			else {
				$lines_to_print_name[$nline] = "$next_line[0]$next_line[1]!Eo!N"."$next_line[2]\'+string(39B)+\'"."00.0\'+string(39B)+string(39B)";
			}
			
			$lines_to_print_name_pixel[$nline] = ($next_line_dec - $line_y_y_int) / $line_y_slope - 5;
			$lines_to_print_name_pixel_y[$nline] = -72;
		}
		else {

			if (($next_line[2] < 10) && ($next_line[2] >= 0)){
				$lines_to_print_name[$nline] = "0"."$next_line[2]\'+string(39B)+\'"."00.0\'+string(39B)+string(39B)";			
			}
			else {
				$lines_to_print_name[$nline] = "$next_line[2]\'+string(39B)+\'"."00.0\'+string(39B)+string(39B)";
			}
			$lines_to_print_name_pixel[$nline] = ($next_line_dec - $line_y_y_int) / $line_y_slope - 5;
			$lines_to_print_name_pixel_y[$nline] = -49;	
		}

	printf OUTPUTLINES "$lines_to_print_pixel[$nline] $lines_to_print_name[$nline] $lines_to_print_name_pixel[$nline] $lines_to_print_name_pixel_y[$nline] \n";

	#print "$lines_to_print_name[$nline] $lines_to_print_pixel[$nline] \n";
	
	}

}

close(OUTPUTLINES);