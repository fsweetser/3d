remz = 90;
remx = 45;
remy = 14;

shell = 2;

coverage = 0.75;

shd = 6.5;
shh = 2;
ssd = 3.5;

$fn = 72;


module oshell(){
    cube([remx + (2*shell) - remy, remy + (2*shell), remz + shell], center=true);

    translate([(remx + (shell) - remy)/2,0,0]){
        cylinder(h=remz+shell, d=remy + (2*shell), center=true);
    }

    translate([-(remx + (shell) - remy)/2,0,0]){
        cylinder(h=remz+shell, d=remy + (2*shell), center=true);
    }
}

module remote(){
    cube([remx - remy, remy, remz], center=true);

    translate([(remx - remy)/2,0,0]){
        cylinder(h=remz, d=remy, center=true);
    }

    translate([-(remx - remy)/2,0,0]){
        cylinder(h=remz, d=remy, center=true);
    }
}



difference(){
    oshell();
    translate([0,0,shell]){
        remote();
    }
    
    translate([(remx - remy)/4,(remy+shell)/2,((remz)/2) - ((remx - remy)/4)]){
        rotate([90,0,0]){
            cylinder(h = shh, d2 = shd, d1 = ssd, center=true);
        }
    }

    translate([-(remx - remy)/4,(remy+shell)/2,((remz)/2) - ((remx - remy)/4)]){
        rotate([90,0,0]){
            cylinder(h = shh, d2 = shd, d1 = ssd, center=true);
        }
    }
    
    translate([0,0,54]){
        rotate([45,0,0]){
            #cube([2*remx, 3*(remy + (2*shell)),20], center=true);
        }
    }
}

