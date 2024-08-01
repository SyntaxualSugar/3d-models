$fn = $preview ? 30 : 120;
epsilon = 0.001;

difference() {
    cylinder(h = 60, d = 27, center = false);
    translate([0, 0, -1])
        cylinder(h = 62, d = 25, center = false);
}
difference() {
    translate([0, 0, 29])
        cylinder(h = 1, d = 27, center = false);
    cylinder(h = 62, d = 24, center = false);
}