//cube([37.3, 65.5, 1]);

y  = 65.6;
z  = 1;
x = 37.3;

delta = 0.25;

pnts = [
           [0, 0, 0],
           [0, 0, z],
           [x+(2*delta), 0, z],
           [x+(2*delta), 0, 0],
           [0+delta, y, 0],
           [0+delta, y, z],
           [x, y, z],
           [x, y, 0]
         ];
         
fcs = [
          [0, 1, 2, 3], // bottom
          [7, 6, 5, 4], // top
          [1, 5, 6, 2], // front
          [0, 3, 7, 4], // back
          [0, 4, 5, 1], // left
          [3, 2, 6, 7]  // right
          ];
          
         
polyhedron(points = pnts,
           faces = fcs);