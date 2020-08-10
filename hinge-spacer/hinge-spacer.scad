bx = 37.2;
by = 88.9;
bz = 2;

$fn = 36;

holed = 5.5;

mhx = 5.6;
ohx = 14;
ohy = 6;

difference() {
    cube([bx,by,bz], center=true);
    
    translate([(bx/2)-(holed/2)-mhx,0,0]){
        #cylinder(d=holed, h=bz+1, center=true);
    }
    
    translate([(bx/2)-(holed/2)-ohx,((by/2)-(holed/2)-ohy),0]){
        #cylinder(d=holed, h=bz+1, center=true);
    }
    
    translate([(bx/2)-(holed/2)-ohx,-((by/2)-(holed/2)-ohy),0]){
        #cylinder(d=holed, h=bz+1, center=true);
    }
}