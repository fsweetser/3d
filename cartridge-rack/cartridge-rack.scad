rows = 4;
cols = 4;

cartdiam = 10;
cartdepth = 20;

blockx = 20;
blocky = 15;

floor = 1;

stepz = cartdepth/2;

$fn = 36;

module mkblock(offset) {
    difference(){
        cube([blockx, blocky, (offset*stepz)+cartdepth+floor], center=true);
        translate([0,0,floor+(offset*stepz*0.5)]){
            cylinder(d=cartdiam, h=cartdepth, center=true);
        }
    }
}

for (x = [ 0 : (rows - 1)]) {
    for (y = [ 0 : (cols - 1)]) {
        translate([x*blockx,y*blocky,y*stepz*0.5]){
            mkblock(offset=y);
        }
    }
}