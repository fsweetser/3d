$fn = 36;

walls = 2;
width = 25.4;

botlen = 31.75;

backlen = 23;

frontlen = 15.875;

angle = 45;


// Horizontal separation between holes
hhsep = 11;

// Vertical spacing from base to first hole
vbsep = 5;

// Vertical spacing from first hole to second
vhsep = 6;

hdiam = 4.7625;

// Bottom plate

cube(size = [botlen, width, walls]);

// Front handle

translate([botlen,0,0]){
    rotate([0,-angle,0]) {
        cube(size = [frontlen, width, walls]);
    }
}

// Back plate

difference() {
    cube(size=[walls, width, backlen]);
    
    // Screw holes
    
    translate([walls/2,((width/2)-(hhsep/2)),(hdiam/2)+walls+vbsep]){
  //translate([walls/2,((width/2)-(hhsep/2)),hbsep+(-hdiam/2)]){
        rotate([0,90,0]){
            #cylinder(h=walls*2, d=hdiam, center=true);
        }
    }
    
    translate([walls/2,((width/2)+(hhsep/2)),(hdiam/2)+walls+vbsep+vhsep]){
        rotate([0,90,0]){
            cylinder(h=walls*2, d=hdiam, center=true);
        }
    }
}