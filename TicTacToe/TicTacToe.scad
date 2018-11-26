use <write.scad>

// Size of the spinner piece.
spsize = 30;

// Height and width of the pins.  This
// should come out to a fairly steep angle
// for printing purposes.
pinh = 3.5;
pind = 8;

$fn = 36;

// How thick the walls should be.
wallthick = 4;
// How much space between the spinner and the walls.
wallspace = 1;
// How much space between the pins and their notches.
pinspace = 0.6;

module gamepiece () {
    translate([0,0,tan(30)*(spsize/2)]) {
        rotate([0,-90,0]){
            difference() {
                // OpenSCAD doesn't natively support triangles, so we
                // simulate it with a three sided cylnder.
                cylinder(h = spsize, r = (spsize/2)/cos(30), $fn = 3);
                
                // Letter "O".  Translate before rotate, as the math is
                // far easier this way than rotate then transform.
                rotate([0,0,30]){
                    translate([0,-(tan(30)*(spsize/2)),spsize/2]){
                               rotate([90,0,0]){
                        write("O", h = 0.75*spsize, t = 2, center=true);
                        }
                    }
                }
                
                // Letter "X" on the alternate face.
                rotate([0,0,150]){
                    translate([0,-(tan(30)*(spsize/2)),spsize/2]){
                               rotate([90,0,0]){
                        write("X", h = 0.75*spsize, t = 2, center=true);
                        }
                    }
                }
            }
            
            // Stick pins on the internal spinner.
            translate([0,0, spsize]){
                cylinder(h = pinh, d1 = pind, d2 = 0);
            }
            rotate([0,180,0]){
                cylinder(h = pinh, d1 = pind, d2 = 0);
            }
        }
    }


    // Height of the walls.
    wallz = (spsize/2)/cos(60);
    // Used to calculate how much extra room we'll need to
    // allow the piece to spin without bumping into the walls.
    swing = (spsize)/cos(30);
    // Base for calculating wall dimensions in the Y axis.
    wally = swing+(2*wallthick)+(2*wallspace);
   
    // Create the two walls adjacent to the pins.  The cylinders here
    // are holes carved out of the walls, plus a little extra clearance.
    difference(){
        translate([wallspace, -wally/2, 0]){
            cube([wallthick, wally, wallz]);
        }
        translate([0,0,(spsize/2)*tan(30)]){
            rotate([0, 90, 0]){
                cylinder(h = pinh + pinspace, d1 = pind + pinspace, d2 = 0);
            }
        }
    }
    
    difference(){
        translate([-(wallthick+wallspace+spsize), -wally/2, 0]){
            cube([wallthick, wally, wallz]);
        }
        translate([-(spsize),0,(spsize/2)*tan(30)]){
            rotate([0, -90, 0]){
                cylinder(h = pinh + pinspace, d1 = pind + pinspace, d2 = 0);
            }
        }
    }
    
    // Create the two remaining walls.  They're spaced a little further out
    // to give the piece room to spin.
    translate([-(spsize+wallspace),(wally/2)-wallthick,0]){
        cube([spsize+(2*wallspace),wallthick,wallz]);
    }
    translate([-(spsize+wallspace),-(wally/2),0]){
        cube([spsize+(2*wallspace),wallthick,wallz]);
    }
}


//gamepiece();

 for(x=[0:2])
    for(y=[0:2])
        translate([x*(spsize+(2*wallspace)+(2*wallthick)), y*(spsize+(2*wallspace)+(2*wallthick)), 0]){
            gamepiece();
        }

