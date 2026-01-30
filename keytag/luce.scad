
cx = 60;
cy = 21;
cz = 2;

tz = 0.5;
toffs = 10;

hole = 5;

module number() {
    translate([toffs,12,0]){
        linear_extrude(0.5) {
            text("617-370", font = "Courier New:style=Bold", size = 8);
        }
    }

    translate([toffs,2.5,0]){
        linear_extrude(0.5){
            text("5023", font = "Courier New:style=Bold", size = 8);
        }
    }
    
}

module stencils() {
     translate([11,13.75,0]){
        cube([5.5,0.8,tz]);
    }
    translate([49.5,15.25,0]){
        cube([6,0.8,tz]);
    }
    translate([17,5.5,0]){
        cube([6,0.8,tz]);
    }
}
//number();

difference() {
    cube([cx, cy, cz]);
    translate([0,0,cz-tz]){
        number();
    }
    translate([0,cy,tz]){
        rotate([180,0,0]){
            number();
        }
    }
    
    translate([5,cy/2,0]){
        cylinder(d = hole, h = cz, $fn = 36);
    }
}

translate([0,0,cz-tz]){
    stencils();
}
translate([0,cy,tz]){
    rotate([180,0,0]){
        stencils();
    }
}

