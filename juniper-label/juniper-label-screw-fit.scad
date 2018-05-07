basex = 40;
basez  = 2.5;
basey  = 18;

// 7.25

sleeved  = 7.25;
sleeveh  = 4;

screwshaft = 5;
//screwshaft = 3.75;
screwheadw = 9;
screwheadh = 4;

difference () {
  union() {
    cube([basex, basey, basez], center=true);

    translate([0, 0, (basez + sleeveh)/2]) {
      difference () {
        cylinder(h=sleeveh, d=sleeved+2, $fn = 36, center = true);
        cylinder(h=sleeveh, d=sleeved, $fn = 36,  center=true);
      }
    }
  }
  
  union () {
    // screw shaft
    cylinder(h = (basez+sleeveh)*2, d = screwshaft, $fn = 36, center=true);
    //screw head
    translate([0,0, ((screwheadh/2) - (basez/2))]) {
      #cylinder(d1 = screwheadw, d2 = 0, h = screwheadh, $fn = 36, center=true);
    }
  }
}  

