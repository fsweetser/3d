// Diameter of the screw holes for the AP mounting bracket
screwwidth   = 4;
// Distance (center to center) between the screw holes for
// the AP mounting bracket
screwspacing = 129.4;

// thickness of the overall object
shell = 2;

// How much clearance to allow for the AP diameter
apdiameter = 210;
// How much clearance to allow for the AP thickness,
// including room to maneuver into the bracket
apdepth = 90;

// Width of the overall bracket
width = 50;

// Diameter of the screw holes to bolt this bracket to the ceiling
earhole = 6;
// How much margin to build around the bolt holes
earshell = 3;

// a bit extra to make holes clean
extra = 0.1;

$fn = 36;

difference () {
    
    // base shell
    cube([apdepth+(2*shell), apdiameter+(2*shell), width], center=true);
    cube([apdepth, apdiameter, width+(2*extra)], center=true);
    
    // screw holes for the AP bracket
    translate([(apdepth+shell)/2,screwspacing/2,-0.25*width]){
        rotate([0,90,0]){
            cylinder(h=shell+1, d=screwwidth, center=true);
        }
    }
    translate([(apdepth+shell)/2,-screwspacing/2,-0.25*width]){
        rotate([0,90,0]){
            cylinder(h=shell+1, d=screwwidth, center=true);
        }
    }
}


// ears to bolt bracket to ceiling
difference() {
    translate([-((apdepth+shell)/2), (apdiameter/2)+shell, 0]){
        rotate([0,90,0]){
            cylinder(r = (2*earshell)+earhole, h = shell, center=true);
        }
    }
    
    translate([-((apdepth+shell)/2), (apdiameter/2)+(earhole/2)+earshell+shell, 0]){
        rotate([0,90,0]){
            cylinder(d=earhole, h=shell+extra, center=true);
        }
    }
}

difference() {
    translate([-((apdepth+shell)/2), -((apdiameter/2)+shell), 0]){
        rotate([0,90,0]){
            cylinder(r = (2*earshell)+earhole, h = shell, center=true);
        }
    }
       translate([-((apdepth+shell)/2), -((apdiameter/2)+(earhole/2)+earshell+shell), 0]){
        rotate([0,90,0]){
            cylinder(d=earhole, h=shell+extra, center=true);
        }
    }
}
