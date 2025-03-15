width = 10;
shell = 1;

wwidth  = 11.5;
wlip    = 3;
wheight = 30.8;

difference(){
    cube([width, wwidth + (2*shell), wheight + (2*shell)]);
    
    translate([0,shell,shell]){
        cube([width, wwidth, wheight]);
    }
    
    translate([0,0,wlip+shell]){
        cube([width, wwidth, wheight - (2*wlip)]);
    }
}