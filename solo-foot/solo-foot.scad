width  = 18;
thick  = 6;
height = 3.5;

pind   = 2.6;
pinsep = 10.7;
pinlen = 2.5;

$fn = 36;

cube([width, thick, height]);
translate([(width/2) - (pinsep/2),thick/2,height]){
    cylinder(h=pinlen, d=pind);
}

cube([width, thick, height]);
translate([(width/2) + (pinsep/2),thick/2,height]){
    cylinder(h=pinlen, d=pind);
}