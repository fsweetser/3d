ht = 150;       // height of the leg
diam = 50;      // diameter of the main cylinder

brackets = 4;   // how many screw brackets to create

brhole  = 3.75;  // diameter of the screw hole
brwall  = 3;    // thickness of the bracket walls
brx = 7;        // how wide to make the bracket
bry = 14;       // how long to make the bracket (only half will be outside of the cylinder)
foot = 10;      // how far the foot extends from the main cylinder
footangle = 60; // angle of the foot

$fn = 36;


// Bracket with rounded supports.  Math is a little off, so
// it doesn't really center up properly.
module rounded_bracket () {
    // bottom plate
    translate([0,0,brwall/2]){
        difference(){
            cube([brx, bry*2, brwall], center = true);
            translate([0, bry - (brhole/2) - (brx/4), 0]){
                cylinder(d = brhole, h = brwall + 1, center = true);
            }
        }
    }
    
    difference(){

        union(){
            // left and right side walls
            translate([(brx/2)+(brwall/2),0,bry]){
                cube([brwall, bry*2, bry*2], center = true);
            }
            translate([-(brx/2)-(brwall/2),0,bry]){
                cube([brwall, bry*2, bry*2], center = true);
            }
        }
        // round out the side walls
        translate([0,bry,bry+(brwall/2)]){
            rotate([0,90,0]){
                #cylinder(h = (brx + 2*brwall + 1), d = (2*bry)-brwall, center = true);
            }
        }
        // trim off the overhead left from the cylinder above
        // the cube is slightly oversized to make 
        translate([0,(bry/2) + (brwall/4),bry*2 - (brx + 2*brwall + 1)/2 - (brwall/4)]){
            #cube([(brx + 2*brwall + 1), (bry - (brwall/2)), (bry - (brwall/2))], center = true);
        }
    }
}


module bracket () {
    // bottom plate
    translate([0,0,brwall/2]){
        difference(){
            cube([brx, bry*2, brwall], center = true);
            translate([0, bry - (brhole/2) - (brx/3), 0]){
                cylinder(d = brhole, h = brwall + 1, center = true);
            }
        }
    }
    
    difference(){

        union(){
            // left and right side walls
            translate([(brx/2)+(brwall/2),0,bry+(brwall/2)]){
                cube([brwall, bry*2, brwall+(bry*2)], center = true);
            }
            translate([-(brx/2)-(brwall/2),0,bry+(brwall/2)]){
                cube([brwall, bry*2, brwall+(bry*2)], center = true);
            }
        }
        
        translate([0,bry,(2*bry)+brwall]){
            rotate([45,0,0]){
             cube([brx + 2*brwall + 1, bry*2/(sin(45)), bry*2/(sin(45))], center = true);   
            }
        }

    }
}
//bracket();


cylinder(h = ht, d = diam);

footht = tan(footangle)*(diam + (2*foot));
translate([0,0,ht - footht]){
    cylinder(r1 = 0, d2 = (diam + (2*foot)),
             h = footht);
}

for (i = [0:(brackets-1)]){
    rotate([0,0,i*(360/brackets)]){
        translate([0,diam/2,0]){
            bracket();
        }
    }
}
