// Altoid tin base inner dimensions
tinx = 90;
tiny = 56;
tinz = 17;
tincorner = 14;

// refill cartridge dimensions
cartlen = 53;
cartd   = 11;

count = 7;

// Size of outer wall
outerwall = 3;

// Size of the wall between cartridges
//sepwall = (tinx - (2*outerwall) - (count*cartd))/(count - 1);

line = tinx - ((2*outerwall) + cartd);
step = line/(count-1);

$fn = 72;

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

module cartridge() {
    cube([cartd, cartlen, cartd], center=true);
}

difference() {
    tin();
    
    pos = -line/2;
    for(i = [0:(count-1)])
        translate([(pos + i*step), 0, (tinz - cartd)/2]){
            cartridge();
        }
}
