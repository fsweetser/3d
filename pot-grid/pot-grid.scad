diam     = 65;
slatw    = 2;
height   = 2;

$fn = 72;


difference(){
    union(){
        cube([diam, slatw, height], center = true);
        translate([0,diam/4,0]){
            cube([diam, slatw, height], center = true);
        }
        translate([0,-diam/4,0]){
            cube([diam, slatw, height], center = true);
        }
        
        cube([slatw, diam, height], center = true);
        translate([diam/4,0,0]){
            cube([slatw, diam, height], center = true);
        }
        translate([-diam/4,0,0]){
            cube([slatw, diam, height], center = true);
        }
        
        difference(){
            cylinder(h = height, d = diam + (2*slatw), center = true);
            cylinder(h = height, d = diam, center = true);
        }
    }

    difference(){
        cube([diam+(2*slatw), diam+(2*slatw), height], center = true);
        cylinder(h = height, d = diam + (2*slatw), center = true);
    }

}