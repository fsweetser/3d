// 82mm x 184mm

spikew = 10;
spikeh = 5;

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

module spike() {
    translate([0,0,baseplate]){
        polyhedron(
            points = [[-spikew/2,  spikew/2, 0],
                      [ spikew/2,  spikew/2, 0],
                      [-spikew/2, -spikew/2, 0],
                      [ spikew/2, -spikew/2, 0],
                      [0, 0, spikeh]],
            faces = [[0, 2, 3, 1],
                     [4, 2, 0],
                     [4, 3, 2],
                     [4, 1, 3],
                     [4, 0, 1]]);
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
    