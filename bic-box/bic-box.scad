// Altoid tin base inner dimensions
tinx = 90;
tiny = 56;
tinz = 17;
tincorner = 14;

bicx = 85; // real = 82
bicy = 27; // real = 25
bicz = 15; // real = 15

slotx = 75;
sloty = 12;
slotz = 8;

$fn = 144;

corner=2;
wall=1;

module tin() {
    cube([tinx - (2*tincorner), tiny, tinz], center=true);
    cube([tinx, tiny - (2*tincorner), tinz], center=true);
    translate([(tinx-(2*tincorner))/2, (tiny-(2*tincorner))/2, 0]){
        cylinder(h=tinz, r=tincorner, center=true);
    }
    translate([-(tinx-(2*tincorner))/2, (tiny-(2*tincorner))/2, 0]){
        cylinder(h=tinz, r=tincorner, center=true);
    }
    translate([(tinx-(2*tincorner))/2, -(tiny-(2*tincorner))/2, 0]){
        cylinder(h=tinz, r=tincorner, center=true);
    }
    translate([-(tinx-(tincorner*2))/2, -(tiny-(tincorner*2))/2, 0]){
        cylinder(h=tinz, r=tincorner, center=true);
    }
}

module bic() {
    cube([bicx, bicy, bicz], center=true);
}
module slot() {
    difference(){
        cube([slotx, sloty, slotz], center=true);
        translate([(slotx/2)-corner, (sloty/2)-corner, 0]) {
            difference(){
                translate([corner/2,corner/2,0]) {
                    cube([corner, corner, 2*slotz], center=true);
                }
                cylinder(h=2*slotz, r=corner, center=true);
            }
        }
        translate([-((slotx/2)-corner), (sloty/2)-corner, 0]) {
            rotate([0,0,90]){
                difference(){
                    translate([corner/2,corner/2,0]) {
                        cube([corner, corner, 2*slotz], center=true);
                    }
                    cylinder(h=2*slotz, r=corner, center=true);
                }
            }
        }
        translate([(slotx/2)-corner, -((sloty/2)-corner), 0]) {
            rotate([0,0,270]){
                difference(){
                    translate([corner/2,corner/2,0]) {
                        cube([corner, corner, 2*slotz], center=true);
                    }
                    cylinder(h=2*slotz, r=corner, center=true);
                }
            }
        }
        translate([-((slotx/2)-corner), -((sloty/2)-corner), 0]) {
            rotate([0,0,180]){
                difference(){
                    translate([corner/2,corner/2,0]) {
                        cube([corner, corner, 2*slotz], center=true);
                    }
                    cylinder(h=2*slotz, r=corner, center=true);
                }
            }
        }
    }
}



difference() {
    tin();
    translate([0,0,(tinz-bicz)/2]) {
        bic();
    }
    translate([0, -((sloty+bicy)/2+wall), (tinz-slotz)/2]) {
        slot();
    }
    translate([0, ((sloty+bicy)/2+wall), (tinz-slotz)/2]) {
        slot();
    }
}
