// 82mm x 184mm

spikew = 10;
//spikeh = 5;

baseplate = 1;



grid = [
        [0, 1, 1, 1, 1, 1, 0],
        [1, 1, 1, 1, 1, 1, 1],
        [1, 1, 1, 1, 1, 1, 1],
        [1, 1, 1, 1, 1, 1, 1],
        [1, 1, 1, 1, 1, 1, 1],
        [1, 1, 1, 1, 1, 1, 1],
        [1, 1, 1, 1, 1, 1, 1],
        [1, 1, 1, 1, 1, 1, 1],
        [1, 1, 1, 1, 1, 1, 1],
        [1, 1, 1, 1, 1, 1, 1],
        [1, 1, 1, 1, 1, 1, 1],
        [1, 1, 1, 1, 1, 1, 1],
        [1, 1, 1, 1, 1, 1, 1],
        [1, 1, 1, 1, 1, 1, 1],
        [1, 1, 1, 1, 1, 1, 1],
        [1, 1, 1, 1, 1, 1, 1],
        [0, 1, 1, 1, 1, 1, 0]
       ];


//grid = [[1]];

$fn = 36;

module spike() {
    translate([0,0,baseplate]){
        difference(){
            sphere(d = spikew);
            translate([-spikew/2,-spikew/2,-((spikew/2)+baseplate)]){
                cube([spikew,spikew,spikew/2]);
            }
        }
    }
    translate([-spikew/2, -spikew/2, 0]){
        cube([spikew, spikew, baseplate]);
    }
}

for (row = [ 0 : len(grid) - 1]){
    line = grid[row];
    for (col = [ 0 : len(line) - 1]){
            if(line[col]){
            translate([spikew*col,spikew*row,0]){
                spike();
            }
        }
    }
}
    