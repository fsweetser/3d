
baseplate = 1;
thomx = 25;
thomy = 25;
thomz = 6.4;
gap = 2;


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

module thomas() {
    translate([0,0,-9]){
        resize([thomx,thomy,thomz]){
            import("thomas_the_train_face.STL");
        }
    }
    //translate([-(thomx+gap), -(thomy+gap)/2, 0]){
    translate([0,0,0]){
        cube([thomx+gap, thomy+gap, baseplate]);
    }
}

for (row = [ 0 : len(grid) - 1]){
    line = grid[row];
    for (col = [ 0 : len(line) - 1]){
            if(line[col]){
            translate([(thomx+gap)*col,(thomx+gap)*row,0]){
                thomas();
            }
        }
    }
}
    