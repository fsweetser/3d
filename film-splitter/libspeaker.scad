//libspeaker
libversion = "0.0.1";
echo("Using libspeaker version: ", libversion);
module mounting_holes(speaker_num_holes, speaker_hole_d, screw_d, box_thick){
    for ( i = [0 : speaker_num_holes] ){
        rotate([0,360/speaker_num_holes*i,0])
            translate([speaker_hole_d/2,0,0])
                rotate([90,0,0])
                    cylinder(d=screw_d, h=box_thick);
    }
}


module screw_form(screw_d, screwhead_d, screwhead_h, box_thick){
    union(){
        cylinder(d=screw_d, h=box_thick);
        cylinder(d=screwhead_d+1, h=screwhead_h);
    }
}

module speaker_cutout(speaker_cutout_d, speaker_flange_d, speaker_flange_h, box_thick){
    translate([0,speaker_flange_h-box_thick,0])rotate([90,0,0])
        cylinder(d=speaker_flange_d, h=speaker_flange_h);
    rotate([90,0,0])
        cylinder(d=speaker_cutout_d, h=box_thick);
}

module screw_cutout(screw_d, screw_l, screwhead_h, nut_d, nut_thick, box_thick, bevel_depth, full_slot = true){
    hex_size = 2 * nut_d/sqrt(3);
    union(){
        //screw cutout
        translate([0,0,0])
            cylinder(d=screw_d, h=screw_l-(box_thick-bevel_depth-screwhead_h)+1);
        //screw slot
        if (full_slot) {
        translate([0,-screw_d/2,0])
            cube([box_thick/2,screw_d,screw_l/4+nut_thick]);
        }
        //nut slot
        translate([0,-nut_d/2,screw_l/4])
            #cube([box_thick/2,nut_d,nut_thick]);
        //nut cutout
        translate([0,0,screw_l/4])
            cylinder(d=hex_size, h=nut_thick,$fn=6);
    }
}

module bevel(box_width, box_height, wall_thick, bevel_depth) {
    difference() {
        cube([box_width, box_height, bevel_depth]);
        translate([wall_thick/2, wall_thick/2, 0])
            cube([box_width-wall_thick, box_height-wall_thick, bevel_depth]);
    }
}

module speaker_volume(height, width, depth) {
    echo("Enclosure volume: ", height*width*depth/1000000, " liters");
}