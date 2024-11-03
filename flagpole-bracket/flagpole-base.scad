$fn = 36;

base   = 71;
height = 203.76;
thick  = 50;

thickbuffer = 5;

length = 92;

ax = -base/2;
ay = 0;

bx = base/2;
by = 0;

cx = 0;
cy = -height;


holed = 7;

// top set of holes
thx = 25.5;
thy = -8;

// bottom set of holes
bhx = 13;
bhy = -74;

arcy = 68;
arcr = 23.5;

// post dimensions - almost, but not quite, a simple cylinder
posttop = 93.9;
postbot = 95.5;

difference(){
    polyhedron( points = [[ax, ay, 0],
                          [bx, by, 0],
                          [cx, cy, 0],
                          [ax, ay, thick],
                          [bx, by, thick],
                          [cx, cy, thick]],
                faces = [[1, 0, 2],    // back
                         [3, 0, 1, 4], // top
                         [3, 5, 2, 0], // left side
                         [2, 5, 4, 1], // right side
                         [4, 5, 3]]     // front
                         );
    
    translate([thx,thy,0]){
        cylinder(h = 2*thick, d = 7, center = true);
    }
    
    translate([-thx,thy,0]){
        cylinder(h = 2*thick, d = 7, center = true);
    }
    
    translate([bhx,bhy,0]){
        cylinder(h = 2*thick, d = 7, center = true);
    }
    
    translate([-bhx,bhy,0]){
        cylinder(h = 2*thick, d = 7, center = true);
    }
    
    tip();
    
    translate([0,-0.5*length, (postbot/2) + thickbuffer]){
        rotate([90,0,0]){
            #cylinder(h = length, d2 = postbot, d1 = posttop, center = true, $fn=144);
        }
    }
    
}




module tip(){
    difference() {     
        polyhedron( points = [[ax, ay, 0],
                              [bx, by, 0],
                              [cx, cy, 0],
                              [ax, ay, thick],
                              [bx, by, thick],
                              [cx, cy, thick]],
                    faces = [[1, 0, 2],    // back
                             [3, 0, 1, 4], // top
                             [3, 5, 2, 0], // left side
                             [2, 5, 4, 1], // right side
                             [4, 5, 3]]     // front
                             );
        translate([0, -0.5*arcy, 0.5*thick]){
            cube([base, arcy+7.75, thick], center = true);
        }
        translate([0, -arcy, 0.5*thick]){
            cylinder(r = arcr, h = thick, center = true);
        }
    }
}