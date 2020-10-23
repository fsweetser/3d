tube = 11.5;
walls = 1.2; // optimized for 0.4mm nozzle

steps = 12;  // no object will be produced for values less than 3
height = 30;
width = 40;

$fn = 72;

module step (height, steps, width) {
    yoffset = (width/2)*tan(360/(2*steps));
    zoffset = height;
    
    polyhedron(points=[
                     [0, 0, 0],
                     [width/2, yoffset, 0],
                     [width/2, -yoffset, 0],
                     [0, 0, zoffset],
                     [width/2, yoffset, zoffset],
                     [width/2, -yoffset, zoffset]
                    ],
              faces = [
                     [0,1,2],
                     [0,2,5,3],
                     [0,3,4,1],
                     [1,4,5,2],
                     [3,5,4]
                     ]);
}

module allsteps (height, steps, width) {
    for (index = [1:steps]){
        rotate([0,0,(360/steps)*index]){
            step(height = (height/steps)*index, width = width, steps = steps);
        }
    }
    cylinder(d=tube+(2*walls), h=height);
}

// This defines the negative space in the cylinder used to
// round out the steps
module trimpyramid (width, height, steps) {
    for (index = [1:steps]){
        layerr = (width/2)-(((width/2)-((tube/2)+walls))/steps)*(index-1);
        translate([0,0, (index-1)*(height/steps)]){
            cylinder(r=layerr, h=(height/steps));
        }
    }
}

// This hollowed out cylinder will be used to round
// out hte steps
module trimoff (width, height, steps) {
    difference() {
        cylinder(r=(width/2)/cos(360/steps), h=height);
        trimpyramid(width, height, steps);
    }
}


// Round out the steps, and carve out the actual pen slot
difference(){
    allsteps(height=height, steps=steps, width=width);
    trimoff(width, height, steps);
    translate([0,0,2]){
        cylinder(d=tube, h=height);
    }
}