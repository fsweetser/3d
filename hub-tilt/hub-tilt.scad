lift = 13;
width = 70;
base = 60;
foot = 20;

thick = 10;

frontwedge = 5;

angle = asin(lift/base);
basey = base*cos(angle);


difference(){
    cube([width, foot+basey, thick]);
    
    translate([thick,0,-0.5]){
        cube([width-(2*thick), foot-thick, thick+1]);
    }
    
    translate([thick, foot,-0.5]){
        cube([width-(2*thick), basey-thick, thick+1]);
    }
}

module backwedge() {
    difference() {
        cube([thick, basey, lift]);
        rotate([angle, 0,0]){
            cube([thick, basey/cos(angle), lift]);
        }
    }
}

module frontwedge() {
    rotate([angle,0,0]){
        cube([thick, thick, 2*thick]);
    }
}

translate([0,foot - thick + cos(90-angle)*thick,0]){
    frontwedge();
}

translate([width-thick,foot - thick + cos(90-angle)*thick,0]){
    frontwedge();
}


translate([0,foot,thick]){
    backwedge();
}

translate([width-thick,foot,thick]){
    backwedge();
}