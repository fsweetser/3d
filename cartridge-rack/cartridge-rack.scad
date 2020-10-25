rows = 3;
cols = 4;

cartdiam = 12;
cartdepth = 25;

xmargin = 5;
ymargin = 3;

blockx = cartdiam + (2*xmargin); //20;
blocky = cartdiam + (2*ymargin); //15;

floor = 0.5;

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

for (x = [ 0 : (cols - 1)]) {
    for (y = [ 0 : (rows - 1)]) {
        translate([x*blockx,y*blocky,y*stepz*0.5]){
            mkblock(offset=y);
        }
    }
}