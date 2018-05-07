basex = 40;
basez  = 1;
basey  = 18;

shaftd  = 7.3;
shafth  = 3.5;


cube([basex, basey, basez], center=true);
translate([0, 0, (basez + shafth)/2]) {
  difference () {
      cylinder(h=shafth, d=shaftd+2, $fn = 36, center = true);
      cylinder(h=shafth, d=shaftd, $fn = 36, center=true);
  }
}
