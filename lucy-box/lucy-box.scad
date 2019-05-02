// Altoid tin base inner dimensions
tinx = 91.5;
tiny = 56.9;
tinz = 21.2;
tincorner = 14;

// Lucy dimensions, with cartridge installed
// the 0.5 is for extra clearance

stubx = 18.5;
stuby = 14.5;
lucyx = 55.5;
lucyy = 42.5;
lucyz = stuby;  // real size is 9, we use the maximum size for the hole

// refill cartridge dimensions
cartlen = 53;
cartd   = 11;

// Amount to shift everything on X to center it up
xshift = 2;

// Size of the wall between Lucy and the spare cartridge
sepwall = 0.51;

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

module lucy() {
    cube([lucyx, lucyy, lucyz], center=true);
    translate([-(lucyx + stubx)/2,-(lucyy - stuby)/2,0]){
        cube([stubx, stuby, stuby], center=true);
    }
}

module cartridge() {
    cube([cartd, cartlen, cartd], center=true);
}


difference() {
    tin();
    
    translate([xshift,0, (tinz - lucyz)/2]){
        lucy();
    }
    translate([xshift, 0, (tinz - cartd)/2]){
        translate ([sepwall + ((lucyx + cartd)/2), 0, 0]) {
            cartridge();
        }
    }
}