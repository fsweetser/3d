
$fn = 36;

shell = 2;

pcbx = 17;
pcby = 29;
pcbz = 1.75;

socketx = 13.5;
sockety = 11;
socketz = 6.5;


plugx = 13;
plugy = 6.7;
plugz = 5.5;
plugoverlap = 4.2;
plugzoff = -1.5;

compx = pcbx;
complip = 1;
compy = pcby - complip;
compz = 3;

clipz = 10;

buttonr = 1.7;
buttonh = shell;
buttonyoffset = 21;

ledd = 7.5;
ledoff = 12;

module innermod () {
    translate([0,0,0]){
        cube([pcbx, pcby, pcbz]);
    }
    
    translate([(pcbx-socketx)/2,pcby-sockety,pcbz]){
        cube([socketx, sockety, socketz]);
    }
    
    translate([(pcbx-plugx)/2,-(plugy-plugoverlap),plugzoff]) {
        cube([plugx, plugy, plugz]);
    }
    
    translate([(pcbx-compx)/2,0,-compz]){
        cube([compx, compy, compz]);
    }
}

module shell () {
    difference(){
        minkowski(){
            innermod();
            sphere(r = shell);
        }
        innermod();
        
        // Socket opening
        translate([(pcbx-socketx)/2,pcby-sockety+shell,0]){
            cube([socketx, sockety, socketz]);
        }
        translate([-shell,pcby,-(pcbz+shell+compz)]){
            cube([pcbx+(2*shell), shell, socketz+pcbz+compz+(2*shell)+5]);
        }
        
        // Plug opening
        translate([(pcbx-plugx)/2,-(plugy-plugoverlap+shell),plugzoff]){
            cube([plugx, plugy, plugz]);
        }
        translate([((pcbx-plugx)/2)-shell,-(plugy-plugoverlap+shell),plugzoff-shell]){
            cube([plugx + (2*shell), shell, plugz + (2*shell)]);
        }
        
        // Button opening
        translate([pcbx,buttonyoffset,-pcbz/2]){
            rotate([0,90,0]){
                cylinder(r = buttonr, h = buttonh);
            }
        }
        
        // LED viewport
        translate([shell+((pcbx-(ledd/2))/2),ledoff,pcbz]){
            cylinder(d = ledd, h = shell);
        }
    }
}

//innermod();
//shell();


// Bottom
rotate([0,180,0]){
    difference() {
        shell();
        translate([-shell,-(plugy),0]){
            cube([pcbx + (2*shell), pcby + plugy + shell, clipz+plugz]);
        }
    }
}


// Top
translate([pcbx, 0, 0]) {
    difference() {
        shell();
        translate([-shell,-(plugy),-clipz]){
            cube([pcbx + (2*shell), pcby + plugy + shell, clipz]);
        }
    }
}
