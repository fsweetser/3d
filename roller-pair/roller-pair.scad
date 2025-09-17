// cylinder variables
steps = 24;
cylr  = 12;
spikeh = 4;
zspikes = 75;

bridgez = 3;
cylgap = 0.25;

// snap fit variables
// column width
w=2;
// main column height
h=0;

// snap fit width
s=0.7;
//snap fit height
f=1;
//snap cut out enable pull height (1 none)
cf=0.7;
// mini column height
m=1;
// edge lip
l=0.05;
// triangle fit cut 0-1 (0 keeps whole)
cl=0.5;
// tolerance of hole in percentage
t=1.01;
// side cut 0-1 (0 keeps whole)
c=0.5;
// Depth offset of triangle cut
dpt=0.05;
// Cut side 0 center
cs=0;

snapscale = 5;
snaptol   = 0.02;

$fn = 72;

module half_sphere(){
    resize([s*2,s*2,f*cf])
    difference(){
    sphere (r=s);
    translate([-s,-s,-s*2])       
    cube(size=s*2);
    }
}

module arrow(){
    difference(){
        union(){
            translate([0,0,h/2+m+f-f*cf]) half_sphere(); //arrow head top
            translate([0,0,h/2+m])cylinder (r1=s-l, r2=s, h=f-f*cf); //arrow head bottom
            translate([0,0,h/2])cylinder(r=s-l, h=m); //mini column
        }
    }
}

module triangle(){
translate([0,0,h/2]){
    polyhedron(
        points = [ [(s-l)*cl,10,m+f],[(s-l)*cl,-10,m+f],[-(s-l)*cl,-10,m+f],[-(s-l)*cl,10,m+f], // the four points at base
                 [0+cs,1,dpt], [0+cs,-1, dpt]],         // the apex point 
        faces = [ [1,0,4],[1,4,5],
                  [2,1,5],[0,3,4],[5,4,3],[3,2,5], // each triangle side
                  [0,1,3],[1,2,3] ]                // two triangles for square base
         );
         }
}

module top_snap_fit(){
    difference(){
        arrow();
        triangle();
    }
}

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

spiker = tan(180/steps)*cylr;
zsteps = floor(zspikes/(2*spiker));
cylh   = zsteps * spiker;


module spikecyl(steps = 24,
                cylr = 12,
                spikeh = 4,
                zspikes = 75,
                spikecols = 1,
                flex = 1) {

    spiker = tan(180/steps)*cylr;
    zsteps = floor(zspikes/(2*spiker));
                    
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
                    roffset = (i * (360/steps)) + (j % 2 ? 0 : 180/steps);
                    rotate([0, 0, roffset]){
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
    }
}


difference(){
    spikecyl(
                steps   = steps,
                cylr    = cylr,
                spikeh  = spikeh,
                zspikes = zspikes,
                flex    = 1
                );
                
    scale(snapscale*(1+snaptol)) {
        arrow();
    }

    translate([0,0,0.1+(2*cylh)]){
        scale(snapscale*(1+snaptol)) {
            rotate([180,0,0]){
                arrow();
            }
        }
    }
}


translate([0,-50,0]){
    // use this distance to make the spikes mesh like gears
    //distance = (2*cylr)+spikeh+cylgap;
    
    // use this distance to keep the cylinders uncoupled
    distance = 2 * ( cylr + spikeh + 0.25);

    cylinder(r=cylr, h=bridgez);
    
    translate([distance,0,0]){
        cylinder(r=cylr, h=bridgez);
    }
    
    translate([0,-0.75*cylr,0]){
        cube([distance, 1.5*cylr, bridgez]);
    }
    
    translate([0,0,bridgez]){
        scale(snapscale*(1-snaptol)){
            top_snap_fit();
        }
    }
    
    translate([distance,0,bridgez]){
        scale(snapscale*(1-snaptol)){
            top_snap_fit();
        }
    }
}
