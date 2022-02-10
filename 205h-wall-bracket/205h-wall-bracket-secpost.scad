use <write.scad>

$fn = 36;

outerx = 86;
outery = 150;
outerz = 11;

bottomz = 2.6;

pathx = 58;

gridthick = 2;

topholex = 48;
topholey = 42;

botholex = 58;
botholey = 31;
botholegap = 40;

rnotchx = 12;
rnotchy = 31.5;
rnotchz = 5.75;
rnotchwall = 2.25;
rnotchyd = 58.75;

elecholespace = 83.4;
botscrewy = 35;

cornerrad = 10;

screwcol2sep = 22.75;

postboty = 39.5;
postymargin = 82.8;
postxmargin = 7.75;

screwclearance = 10;
screwhole = 4.5;
screwtop = 7.25;
screwbot = 0.74;

cornerscrewxmargin = 8.25;
cornerscrewbotymargin = 24.25;
cornerscrewtopymargin = 19.25;

midscrewxmargin = 13.75;

secx = 1.5;
secy = 7;
secz = 4.6;
secxoffset = 2.5;
secyoffset = 106;

sechd = 3.25;
secbridge = 0.75; 
    
difference(){
    // main block
    cube([outerx, outery, outerz]);
    
    // gap down the main cube
    translate([(outerx-pathx)/2,gridthick,bottomz]){
        cube([pathx, outery-(2*gridthick), outerz]);
    }
    
    // top half of the hole
    translate([(outerx-botholex)/2,botholegap,0]){
        cube([botholex, botholey, bottomz]);
    }
    
    // bottom half of the hole (slightly wider)
    translate([(outerx-topholex)/2,botholegap+botholey, 0]){
        cube([topholex, topholey, bottomz]);
    }
    
    // screw holes
    translate([outerx/2,botscrewy,0]){
        screwhole();
    }
    translate([outerx/2,botscrewy+elecholespace,0]){
        screwhole();
    }
    
    
    translate([(outerx/2)+screwcol2sep,botscrewy,0]){
        screwhole();
    }
    translate([outerx/2+screwcol2sep,botscrewy+elecholespace,0]){
        screwhole();
    }
    
    translate([(outerx/2)-screwcol2sep,botscrewy,0]){
        screwhole();
    }
    translate([(outerx/2)-screwcol2sep,botscrewy+elecholespace,0]){
        screwhole();
    }
    
    translate([cornerscrewxmargin,cornerscrewbotymargin,0]){
        screwhole();
    }
    translate([cornerscrewxmargin,outery-cornerscrewtopymargin,0]){
        screwhole();
    }
    translate([outerx-cornerscrewxmargin,cornerscrewbotymargin,0]){
        screwhole();
    }
    translate([outerx-cornerscrewxmargin,outery-cornerscrewtopymargin,0]){
        screwhole();
    }
    
    translate([midscrewxmargin,(botholegap+botholey+(screwclearance/2)+2),0]){
        screwhole();
    }
    translate([outerx-midscrewxmargin,(botholegap+botholey+(screwclearance/2)+2),0]){
        screwhole();
    }
    
    // ventilation holes
    ventoffsets = [-3,-2, -1, 0, 1, 2, 3];
    for (ofs = ventoffsets) {
        translate([(outerx/2)+(ofs*(1+(outerz-bottomz-2))),outery,bottomz+((outerz-bottomz)/2)]){
            rotate([90,0,0]){
                cylinder(d=outerz-bottomz-2, h=outery);
            }
        }
    }
    
    // holes for the mounting bits to latch onto
    translate([4.25+5, 105.5, 0]){
        mirror([1,0,0]) notch();
    }
    
    translate([outerx - 9.5, 32, 0]){
        notch();
    }
    
    // hole for the lump on the back of the AP
    translate([outerx-rnotchx-rnotchwall, rnotchyd, outerz-rnotchz]){
        cube([rnotchx, rnotchy, rnotchz]);
    }
    
    // round off the corners
    translate([cornerrad, cornerrad, 0]){
        rotate([0,0,180]){
            corner(crad=cornerrad, cht=outerz);
        }
    }
    translate([outerx-cornerrad, cornerrad, 0]){
        rotate([0,0,270]){
            corner(crad=cornerrad, cht=outerz);
        }
    }
    translate([cornerrad, outery-cornerrad, 0]){
        rotate([0,0,90]){
            corner(crad=cornerrad, cht=outerz);
        }
    }
    translate([outerx-cornerrad, outery-cornerrad, 0]){
        rotate([0,0,0]){
            corner(crad=cornerrad, cht=outerz);
        }
    }

    // Label for top side
    translate([outerx/2, outery-15, bottomz]){
        write("TOP", h=10, center=true);
    }

    // Identify compatible model
    translate([outerx/2,15,bottomz]){
        #write("205H", h=10, center=true);
    }
}
translate([postxmargin,postboty,outerz]){
    post();
}   
translate([outerx-postxmargin,postboty+postymargin,outerz]){
    post();
}

// Post to grab security screw
translate([outerx-(secx/2)-secxoffset, secyoffset, (secz/2)+outerz]){
    secpost();
}

module screwhole() {

    
    translate([0,0,bottomz]){
        cylinder(d=screwclearance, h=outerz);
    }
    cylinder(d=4.5, h=bottomz);
    translate([0,0,screwbot]){
        cylinder(h=bottomz-screwbot, d1=screwhole, d2=screwtop);
    }
}

module notch(){
    notchx = 5;
    notchy = 19.25;
    
    notchz = 2;
    
    lipx = 2.75;
    lipy = 8;
    
    cube([notchx, notchy, outerz-notchz]);
    translate([0,lipy,0]){
        cube([notchx, notchy-lipy, outerz]);
    }
    cube([notchx-lipx, notchy, outerz]);
}

module corner(crad=10, cht=5) {
    difference(){
        cube([crad, crad, cht]);
        cylinder(r=crad, h=cht);
    }
}

module post() {
    hatz=1.25;
    hatd=7;
    haty=3.75;
    
    stemd=4.25;
    stemz=4.3;
    
    translate([0,0,stemz - hatz]){
        intersection(){
            cylinder(d=hatd, h=hatz);
            translate([0,0,hatz/2]){
                cube([hatd, haty, hatz], center=true);
            }
        }
    }
    translate([0,0,stemz/2]){
        cube([stemd, stemd, stemz], center=true);
    }
}

module secpost() {
    difference(){
        cube([secx, secy, secz], center=true);
        translate([0,0,((secz-sechd)/2)-secbridge]){
            rotate([0,90,0]){
                cylinder(h=secx+0.1, d=sechd, center=true);
            }
        }
    }
}
