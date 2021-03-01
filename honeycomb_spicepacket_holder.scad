// bottom
//cube([137,48,2]);

/*
thickness =2;
a=137; // width
b=48;  // depth
c=110; // front height
d=133; // back height


difference() {
    difference() {
        box(a,b,c,d);
        translate([thickness,thickness,thickness]) {
            cube([133,44,133]);
        }
    }

    union () {
        for (i=[0:9]) {
            translate([9,thickness,9 + (i*10)]) {
                honeycomb(7, 10, thickness);
            }
            translate([17,thickness,14 + (i*10)]) {
                honeycomb(7, 10, thickness);
            }
        }
    }
}
*/

d=10;
thickness=2;
s=0.8;
numX=15;
numY=10;
num_onset = ceil(numX/2);
num_offset = floor(numX/2);
a = d / 2;
ir = a * sqrt(3) / 2;
sX = tan(60)*sqrt(3)*a/((d - a)*2);
width = num_offset*(d + a + sX) + (numX%2==1 ? sX/2 + d - (d - a)/2 : 0) -sX/2 + (d - a)/2;
height = (numY + 0.5)*(ir*2 + s) - s;
difference() {
    translate([-width / 2, -height / 2, 0]) {
        cube([width, height, 2]);
    }
    
    hexagon_matrix();
}

module box(a,b,c,d) {

    CubePoints = [
      [0, 0, 0],  //0
      [a, 0, 0],  //1
      [a, b, 0],  //2
      [0, b, 0],  //3
      [0, 0, c],  //4
      [a, 0, c],  //5
      [a, b, d],  //6
      [0, b, d]]; //7
      
    CubeFaces = [
      [0,1,2,3],  // bottom
      [4,5,1,0],  // front
      [7,6,5,4],  // top
      [5,6,2,1],  // right
      [6,7,3,2],  // back
      [7,4,0,3]]; // left
      
    polyhedron( CubePoints, CubeFaces );
}

module honeycomb(n = 10, d=10, thickness = 2) {
    
    rotate([90,0,0]) {
        for (i=[0:n]) {
            union() {
                translate([i * 16,0,0]) {
                    cylinder(h=thickness, d=d, $fn=6);
                }
            }
        }
    }
}

module hexagon_matrix(d=10, thickness=2, s=0.8, numX=15, numY=10) {
    num_onset = ceil(numX/2);
    num_offset = floor(numX/2);
    a = d / 2; // Side length
    ir = a * sqrt(3) / 2; // Inradius (apothem)
    sX = tan(60)*sqrt(3)*a/((d - a)*2); // x offset for spacing
    width = num_offset*(d + a + sX) + (numX%2==1 ? sX/2 + d - (d - a)/2 : 0) -sX/2 + (d - a)/2;
    height = (numY + 0.5)*(ir*2 + s) - s;
    translate([-width/2 + d/2, -height/2 + d/2 -(d/2 - ir), 0]) {
        matrix(d, thickness, sX, s, num_onset, numY, a, ir);
        translate([(d + a) / 2 + sX/2, ir + s/2, 0]) {
            matrix(d, thickness, sX, s, num_offset, numY, a, ir);
        }
    }
}

module matrix(d, thickness, sX, s, nX, nY, a, ir) {
    for (iX = [0:nX - 1]) {
        translate([iX*(d + a + sX), 0, 0]) {
            for (iY = [0:nY - 1]) {
                translate([0, iY*(ir*2 + s), 0]) {
                    cylinder(h=thickness, d=d, $fn=6);
                }
            }
        }
    }
}
