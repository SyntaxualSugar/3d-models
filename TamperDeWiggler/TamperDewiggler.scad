$fn = $preview ? 30 : 120;
epsilon = 0.001;

module thing() {
    difference() {
        cylinder(h = 23, d = 14.4, center = false);
        translate([0, 0, -1])
            cylinder(h = 24, d = 12.2, center = false);
    }

    difference() {
        cylinder(h = 1, d = 18, center = false);
        cylinder(h = 1, d = 12.2, center = false);
    }
}

thing();