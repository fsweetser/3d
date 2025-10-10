// From https://www.thingiverse.com/thing:4914245
import("Finger_splint_-_tapered.stl");

$fn = 36;

translate([-17.5,1.27,15]){
    rotate([0,90,-2]){
        cylinder(h = 21, d = 2);
    }
}


translate([-17.5,20.9,15]){
    rotate([0,90,2]){
        cylinder(h = 21, d = 2);
    }
}

