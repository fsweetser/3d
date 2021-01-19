ht = 150;
diam = 50;



brhole  = 3.3;
brwall  = 3;
brx = 7;
bry = 14;

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
            translate([0, bry - (brhole/2) - (brx/4), 0]){
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

translate([0,diam/2,0]){
    bracket();
}
rotate([0,0,120]){
    translate([0,diam/2,0]){
        bracket();
    }
}
rotate([0,0,240]){
    translate([0,diam/2,0]){
        bracket();
    }
}
