
topd   = 50;
botd   = 49.5;

height = 25;
wall   = 5;

roped  = 10;

$fn = 72;

label     = ["\u2191", "U", "P", "\u2191"];
textarc   = 90;
textrotate = 60;
textdepth = 0.2;
textsize  = 10;

chars = len(label);

difference(){
    cylinder(d1 = botd + (2*wall), d2 = botd + (2*wall), h = height);
    cylinder(d1 = botd, d2 = topd, h = height);
    
    for(i = [0:1:chars]){
        rotate([0,0,textrotate+(i*(textarc/chars))]){
            translate([(topd/2)+wall - (textdepth+1), 0, height/2]){
                rotate([90,0,90]){
                    linear_extrude(1) {
                        text(label[i], size=textsize, valign="center", halign="center");
                    }
                }
            }
        }
    }
}

module ropeclip () {
    difference(){
        cylinder(d = roped + (2*wall), h = height);
        cylinder(d = roped, h = height);
    }
}

translate([wall + ((topd + roped)/2), 0, 0]){
    ropeclip();
}

translate([-(wall + ((topd + roped)/2)), 0, 0]){
    ropeclip();
}

