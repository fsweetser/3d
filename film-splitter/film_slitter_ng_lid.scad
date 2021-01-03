// Parametric Film Sliter
// 2021 Logan E Brown
// <thinkbrown@96west.net>

// Entirely for screwform stuff
use <libspeaker.scad>;
$fn=64;
// fairly arbitrary, 
// length should probably be at least film width to keep things in line
// height was randomly chosen, changing it will likely require adjusting the blade angle
slitter_height = 30;
slitter_length = 60;
wall_thickness = 4;
// Definition for screw/nut dimensions
m4_clearance_d = 4.5;
m4_head_clearance_d = 7;
m4_head_clearance_h = 4;
m4_nut_d = 7.1;
m4_nut_h = 4.5;
// math for nut holes.
m4_nut_flats = 2 * m4_nut_d/sqrt(3);
// Definition for blade dimensions
// Note that a safety razor blade is actually about 0.15mm thick,
// but we need enough space to slide it in and then apply pressure.
blade_thickness = 0.4;
blade_height = 22;
blade_width = 43;
blade_angle = 10;
// offset of the mounting holes in the blade.
// This model assumes the blade is symmetrical and both mounting
// holes are on center line
blade_hole = 9;
blade_offset = blade_height*sin(blade_angle);
film_thickness = 0.7;
clip_thickness = 1;

//16mm cuts
16mm_to_minox = [6.6];
16mm_width = 16;
//35mm cuts
35mm_to_16_and_minox = [4.8, 20.8, 30.2];
35mm_to_minox = [8.1, 17.5, 26.9];
35mm_width = 35;
//120 cuts
120_to_16_and_minox = [2, 18, 34, 50, 59.4];
120_to_minox = [2, 11.4, 20.8, 30.2, 39.6, 49, 58.4];
120_width = 61;

// For slitting 16mm film to minox (approx 9.4mm) - TESTED
//plate(16mm_width, 16mm_to_minox);
// For slitting 35mm film to 16mm and minox - TESTED
//plate(35mm_width, 35mm_to_16_and_minox);
// For slitting 35mm film to minox
//plate(35mm_width, 35mm_to_minox);

// For slitting 120 film to 3 16mm strips and a minox strip. Waste not, want not.
//plate(120_width, 120_to_16_and_minox);
// for slitting 120 film to no less than 6 strips of minox
//plate(120_width, 120_to_minox);

cap(120_width, 120_to_minox);

module plate(film_width, widths){
    slitter(film_width, widths);
    translate([film_width+2*wall_thickness+20,0,0])
        cap(film_width, widths);
}

module slitter(film_width, widths){
    slitter_width = film_width+2*wall_thickness;
    difference(){
        cube([film_width+2*wall_thickness, slitter_length, slitter_height]);
        translate([wall_thickness, 0, slitter_height-wall_thickness-film_thickness])
            cube([film_width, slitter_length, wall_thickness+film_thickness]);
        for (width = widths){
            translate([wall_thickness+width-blade_thickness/2,wall_thickness,0])
                hull(){
                    translate([0,sin(blade_angle)*blade_height,0])
                        rotate([blade_angle,0,0])
                            #cube([blade_thickness, blade_width, blade_height]);
                    translate([0,sin(blade_angle)*(blade_height+(sin(blade_angle)*blade_width)),-sin(blade_angle)*blade_width])
                        rotate([blade_angle,0,0])
                            cube([blade_thickness, blade_width, sin(blade_angle)*blade_width]);
                }
                translate([wall_thickness+width,0,0])
                    cube([blade_thickness, blade_width, blade_height]);
        }
        rotate([blade_angle,0,0])
            translate([0, blade_hole+sin(blade_angle)*blade_width, blade_height/2])
                rotate([0,90,0])
                    union(){
                        screw_form(m4_clearance_d, m4_head_clearance_d, m4_head_clearance_h, slitter_width);
                        #translate([0,0,slitter_width-m4_nut_h])
                            cylinder(d=m4_nut_flats, h=m4_nut_h, $fn=6);
                    }
        rotate([blade_angle,0,0])
            translate([0, blade_width-blade_hole+sin(blade_angle)*blade_width, blade_height/2])
                rotate([0,90,0])
                    union(){
                        screw_form(m4_clearance_d, m4_head_clearance_d, m4_head_clearance_h, slitter_width);
                        #translate([0,0,slitter_width-m4_nut_h])
                            cylinder(d=m4_nut_flats, h=m4_nut_h, $fn=6);
                    }
    }
}

module cap(film_width, widths){
    slitter_width = film_width+2*wall_thickness;
    difference(){
        union(){
            translate([wall_thickness,clip_thickness,0])
                cube([film_width, slitter_length, wall_thickness]);
            translate([0,clip_thickness,wall_thickness])
                cube([film_width+2*wall_thickness, slitter_length, 1]);
            cube([film_width+2*wall_thickness,clip_thickness,wall_thickness+clip_thickness]);
            translate([0,slitter_length+clip_thickness,0])
                cube([film_width+2*wall_thickness,clip_thickness,wall_thickness+clip_thickness]);
        }
        translate([3*wall_thickness/2,0,-wall_thickness])
            rotate([45,0,0])
                cube([film_width-wall_thickness, wall_thickness*sqrt(2), wall_thickness*sqrt(2)]);
        translate([wall_thickness, 0, slitter_height-wall_thickness-film_thickness])
            cube([film_width, slitter_length, wall_thickness+film_thickness]);
        for (width = widths){
            translate([wall_thickness+width-blade_thickness/2,wall_thickness,-slitter_height+film_thickness+wall_thickness])
                translate([0,sin(blade_angle)*blade_height,0])
                    rotate([blade_angle,0,0])
                        cube([blade_thickness, blade_width, blade_height]);
        }
    }
}
