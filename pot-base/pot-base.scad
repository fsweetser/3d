// these dimensions are for the inside of the container
height = 15;
base   = 70;
top    = 80;

wall   = 2;

$fn = 36;

difference(){
    cylinder(h = height + wall, d1 = base + (2*wall), d2 = top + (2*wall));
    translate([0,0,wall]){
        cylinder(h = height, d1 = base, d2 = top);
    }
}