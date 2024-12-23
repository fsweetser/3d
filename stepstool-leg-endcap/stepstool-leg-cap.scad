tubed = 22.8;
tubeh = 17;
wall  = 2;
//angle = 60;
angle = 45;

$fn = 63;

difference(){
    cylinder(h = tubeh + wall + (tubed+(2*wall))*tan(90-angle), d = tubed + (2*wall));
    cylinder(h = tubeh, d = tubed);

    translate([0,wall+(tubed/2),tubeh+wall]){
        rotate([angle,0,0]){
            translate([0,tubed/2,0]){
                cylinder(h = (tubed+(2*wall))/cos(90 - angle), d = tubed);
                translate([-(wall+(tubed/2)),0,0]){
                    cube([tubed+(2*wall), tubed/2, (tubed+(2*wall))/cos(90 - angle)]);
                }
            }
        }
    }
}