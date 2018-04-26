# Provided the center of an image and the size of the image, this subroutine
# returns the minimum RA on the minimum side.  
# This takes in an array of RA and DEC in degrees. 
sub get_min_max_ra{

	@input_min_max_ra_data = @_;

	my $ra = $input_min_max_ra_data[0];
	my $dec = $input_min_max_ra_data[1];
	
	#printf "getminmax input: $input_min_max_ra_data[0], $input_min_max_ra_data[1] \n";
	
	my $new_x_slope = ra_slope($dec); 
	my $new_x_y_int = ra_yint(@input_min_max_ra_data);
		
	my $left_side = ($x_slope * 0) + $x_y_int;
	my $right_side = ($x_slope * $number_of_pixels_across) + $x_y_int;
	@return_sides = ($left_side, $right_side);

	return @return_sides;

}

# This takes in an array of DEC in degrees, and returns the slope for calculating the 
# RA given a pixel value. 
sub ra_slope{

	@input_ra_slope_dec = @_[0];	

	my $xsize_dec = (($xsize/2) / 60) / cos($input_ra_slope_dec[0] * 3.14159265 / 180.0);
	$x_slope = (-1) * (($xsize_dec) / ($number_of_pixels_across / 2));

	return $x_slope;

}

# This takes in an array of DEC in degrees, and returns the y intercept for calculating the 
# RA given a pixel value.  
sub ra_yint{

	@input_ra_slope_yint = @_;	
	my $x_slope = ra_slope($input_ra_slope_yint[1]);
	
	#print "xslope = $x_slope \n";
	$x_y_int = $input_ra_slope_yint[0] - (($number_of_pixels_across / 2) * $x_slope);
	#print "xslope = $x_y_int = $input_ra_slope_yint[0] - (($number_of_pixels_across / 2) * $x_slope); \n";

	return $x_y_int;

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

# This subroutine takes in the decimal values for the min_max_ra, and then returns
# the position of the first line, in hours, minutes, and seconds.
sub find_first_line{
	my @min_max_ra = @_;
	my @output_left_side_hours = ra_dec_to_hours($min_max_ra[0]);
	my @output_right_side_hours = ra_dec_to_hours($min_max_ra[1]);

	my $right_side_line_int = (int(($output_right_side_hours[2] / $line_distance)) * $line_distance) + $line_distance;
	
	#print "test: $right_side_line_int \n";

	if ($right_side_line_int == 60){
		#print "yes! \n";
		$output_right_side_hours[1] = ($output_right_side_hours[1] + 1.0);
		$right_side_line_int = 0.0;
		
		print "$output_right_side_hours[0],$output_right_side_hours[1],$right_side_line_int \n";
		
			if ($output_right_side_hours[1] == 60){
				$output_right_side_hours[0] = ($output_right_side_hours[0] + 1.0);
				$output_right_side_hours[1] = 0;	
					if ($output_right_side_hours[0] == 24){
						$output_right_side_hours[0] = 0.0;					
					}
			}
	}
	
	@right_side_line = ($output_right_side_hours[0],$output_right_side_hours[1],$right_side_line_int);	
	return @right_side_line;
	
}

# This subroutine takes in the hours, minutes, and seconds values for a line and then 
# returns the position of the next line, in hours, minutes, and seconds.
sub find_next_line{
	my @line_hours = @_;

	$new_line_int = $line_hours[2] + $line_distance;
	
	#print "test: $new_line_int \n";

	if ($new_line_int == 60){
		#print "yes! \n";
		$line_hours[1] = ($line_hours[1] + 1.0);
		$new_line_int = 0.0;
				
			if ($line_hours[1] == 60){
				$line_hours[0] = ($line_hours[0] + 1.0);
				$line_hours[1] = 0;	
					if ($line_hours[0] == 24){
						$line_hours[0] = 0.0;					
					}
			}
	}
	
	@new_line = ($line_hours[0],$line_hours[1],$new_line_int);	
	return @new_line;
	
}

# The input to the program is the RA and DEC of the center of the image, given with
# individual entries. 
@input_ra = ($ARGV[0], $ARGV[1], $ARGV[2]);
@input_dec = ($ARGV[3], $ARGV[4], $ARGV[5], $ARGV[6]);

#@input_ra = (16.0, 30.0, 32.64);
#@input_dec = ('+', 39.0, 23.0, 3.09);

#@input_ra = (12.0, 34.0, 53.92);
#@input_dec = ('-', 00.0, 01.0, 5.07);

$xsize = 10; #in arcminutes
$ysize = 10; #in arcminutes
$number_of_pixels_across = 600;
$number_of_pixels_updown = 600;

$line_distance = 10.0; #in arcseconds


#print "Input RA: $input_ra[0]h $input_ra[1]m $input_ra[2]s \n";
#print "Input DEC: $input_dec[0]"."$input_dec[1]d $input_dec[2]\' $input_dec[3]\" \n";

$ra_dec = ra_hours_to_dec(@input_ra);
$dec_dec = dec_deg_to_dec(@input_dec);

@min_max_ra = get_min_max_ra(($ra_dec, $dec_dec));

$line_x_slope = ra_slope($dec_dec); 
$line_x_y_int = ra_yint(($ra_dec, $dec_dec));
#print "new line x slope: $line_x_slope \n";
#print "new line yint: $line_x_y_int \n";

@output_left_side_hours = ra_dec_to_hours($min_max_ra[0]);
@output_right_side_hours = ra_dec_to_hours($min_max_ra[1]);

#print "output left side = $output_left_side_hours[0] $output_left_side_hours[1] $output_left_side_hours[2] \n";
#print "output right side = $output_right_side_hours[0] $output_right_side_hours[1] $output_right_side_hours[2] \n";

open(OUTPUTLINES,">>output_ra_lines.dat") || die("The file output_ra_lines.dat will not open!");	

@first_line = find_first_line(@min_max_ra);
$first_line_dec = ra_hours_to_dec(@first_line);
#print "The first line will be at: $first_line[0] $first_line[1] $first_line[2] \n";

$lines_to_print_ra_hours[0] = $first_line[0];
$lines_to_print_ra_minutes[0] = $first_line[1];
$lines_to_print_ra_seconds[0] = $first_line[2];
$lines_to_print_ra_dec[0] = $first_line_dec;
$lines_to_print_name[0] = "$first_line[0]h$first_line[1]m$first_line[2]".".00s";
$lines_to_print_name_pixel[0] = (($first_line_dec - $line_x_y_int) / $line_x_slope) - 45;
$lines_to_print_pixel[0] = (($first_line_dec - $line_x_y_int) / $line_x_slope);
#print "$lines_to_print_name[0] $lines_to_print_pixel[0] \n";
printf OUTPUTLINES "$lines_to_print_pixel[0] $lines_to_print_name[0] $lines_to_print_name_pixel[0]\n";


@next_line = @first_line;

$nline = 0;

$has_crossed_edge = 0;

while ($has_crossed_edge == 0){

	@next_line = find_next_line(@next_line);
	$next_line_dec = ra_hours_to_dec(@next_line);

	if ($next_line_dec > $min_max_ra[0]){
		$has_crossed_edge = 1;
	}
	else {
	
		$nline++;
		#print "The next line will be at: $next_line[0] $next_line[1] $next_line[2] (compare $next_line_dec to $min_max_ra[0]) \n";
		$lines_to_print_ra_hours[$nline] = $next_line[0];
		$lines_to_print_ra_minutes[$nline] = $next_line[1];
		$lines_to_print_ra_seconds[$nline] = $next_line[2];
		$lines_to_print_ra_dec[$nline] = $next_line_dec;
		$lines_to_print_pixel[$nline] = ($next_line_dec - $line_x_y_int) / $line_x_slope ;
		
		if (($next_line[2] == 0) && ($next_line[1] != 0)) {
		
			$lines_to_print_name[$nline] = "$next_line[1]m$next_line[2]".".00s";
			$lines_to_print_name_pixel[$nline] = ($next_line_dec - $line_x_y_int) / $line_x_slope - 45;
		
		}
		elsif (($next_line[2] == 0) && ($next_line[1] == 0)) { 
		
			$lines_to_print_name[$nline] = "$next_line[0]h$next_line[1]m$next_line[2]".".00s";
			$lines_to_print_name_pixel[$nline] = ($next_line_dec - $line_x_y_int) / $line_x_slope - 25;

		}
		else {
			$lines_to_print_name[$nline] = "$next_line[2]".".00s";
			$lines_to_print_name_pixel[$nline] = ($next_line_dec - $line_x_y_int) / $line_x_slope - 15;
				
		}

	printf OUTPUTLINES "$lines_to_print_pixel[$nline] $lines_to_print_name[$nline] $lines_to_print_name_pixel[$nline] \n";

	#print "$lines_to_print_name[$nline] $lines_to_print_pixel[$nline] \n";
	
	}

}

close(OUTPUTLINES);