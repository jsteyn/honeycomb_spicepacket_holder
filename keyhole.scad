

module keyhole(diameter=5, thickness=2, length=10) {
    smalld=diameter/3*2;
    translate([0, diameter/2, 0]) {
        cylinder(d=diameter, h=thickness, $fn=20);
    }
    translate([-(smalld/2),diameter/2,0]) {
        cube([smalld, length-(smalld/2)-(diameter/2), thickness], center=false);
    }
    translate([0, length - (smalld/2), 0]) {
        cylinder(d=smalld, h=thickness, $fn=20);
    }
}
