module spike(spiker, spikeh){
    polyhedron(
               points =[[spiker, 0, 0],
                        [spiker, 0, 2*spiker],
                        [-spiker, 0, 2*spiker],
                        [-spiker, 0, 0],
                        [0, -spikeh, spiker]],
                faces = [[0, 1, 2, 3],
                         [0, 4, 1],
                         [1, 4, 2],
                         [2, 4, 3],
                         [0, 3, 4]]);
}

module spikecyl(steps = 24,
                cylr = 12,
                spikeh = 4,
                zspikes = 75,
                toph = 10,
                keychain = 5,
                spikecols = 1,
                inckeychain = 1,
                throughhole = 0,
                slot = 0) {
                    
    $fn = 36;

    spiker = tan(180/steps)*cylr;
    zsteps = floor(zspikes/(2*spiker));
                    
    difference(){
        union(){
            // generate the body using spikes backed with
            // cubes, rotated around the axis.  using a series
            // of cubes makes rendering messy, but avoids gaps
            // between the flat backed spikes and an actual
            // rounded cylinder.  repeat each layer enough times
            // to reach the desired height.
            for(j = [0 : zsteps-1]){
                translate([0,0,j*2*spiker]){
                    for(i = [0 : steps-1]){
                        rotate([0, 0, i * (360/steps)]){
                                if(((i+1) % spikecols) == 0){
                                translate([0,-cylr,0]){
                                    spike(spiker=spiker, spikeh=spikeh);
                                }
                            }
                            
                            translate([0,-cylr/2,spiker]){
                                cube([2*spiker,cylr,2*spiker], center=true);
                            }
                        }
                    }
                }
            }
            
            
            // tack on another cylinder with a hole for putting
            // it on a keychain.
            if(inckeychain){
                difference(){
                    cylinder(r = cylr, h = (zsteps*spiker*2)+toph);
                    translate([0,0,(zsteps*spiker*2)+(toph/2)]){
                        rotate([90,0,0]){
                            cylinder(d = keychain, h = (cylr*2)+2, center = true);
                        }
                    }
                }
            }
        }
        
        if(throughhole){
            cylinder(r = cylr * throughhole, h = 2 * zspikes);
        }
        
        if(slot){
            translate([0, -slot/2, 0]){
                cube([cylr + spikeh, slot, zsteps*spiker*2]);
            }
        }
    }
}

//spikecyl();