wall = 2;

length = 21.5;
height = 3;
width  = 8;


difference(){
    cube([width, length+wall+wall, height+wall]);
    translate([0,wall,0]){
        cube([width, length, height]);
    }
}