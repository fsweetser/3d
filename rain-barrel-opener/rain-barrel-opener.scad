$fn = 36;

disch  = 5;
discd  = 51;

blockw = 15;
blockh = 7;
blockl = 2 * sqrt(((discd/2)^2) - ((blockw/2)^2));

hole   = 7;

stub   = 5;

cylinder(h = disch, d = discd);

translate([-blockw/2,-blockl/2,-blockh]){
    cube([blockw, blockl, blockh]);
}

translate([-blockl/2,-blockw/2,-blockh]){
    cube([blockl, blockw, blockh]);
}

difference(){
    union(){
        translate([0,blockl/2,disch+stub]){
            rotate([90,0,0]){
                cylinder(h = blockl, d = blockw);
            }
        }
        translate([-blockw/2,-blockl/2,stub]){
            cube([blockw, blockl, stub]);
        }
    }
    
    translate([0,blockl/2,disch+(hole/2)+(stub/2)]){
        rotate([90,0,0]){
            cylinder(h = blockl, d = hole);
        }
    }
    
}