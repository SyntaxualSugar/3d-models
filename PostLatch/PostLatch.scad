$fn = $preview ? 30 : 120;
epsilon = 0.001;

pole_diameter = 15.05;
width = 19;
depth = 42;
height = 32;

module roundConcaveFillet(radius, rads) {
    rotate_extrude()
        translate([radius, 0, 0])
            difference() {
                square([rads, rads]);
                
                translate([rads, rads])
                    circle(r = rads);
            }
}

module roundConvexFillet(radius, rads) {
    rotate_extrude()
        translate([radius-rads, 0, 0])
            difference() {
                square([rads+epsilon, rads+epsilon]);
                circle(r = rads);
            }
}

module halfCircleConvexFillet(radius, rads) {
    hrads = rads/2;
    rotate_extrude()
        translate([radius-hrads, 0, 0])
            difference() {
                translate([-hrads, 0, 0])
                    square([rads+epsilon, hrads+epsilon]);
                circle(r = hrads);
            }
}

module thing() {
    difference() {
        translate([0,0,height/2])
            cube([width, depth, height], center = true);
        
        // Negative Y hole
        translate([1, 11, 0])
            cylinder(h = height + epsilon, d = pole_diameter, center = false);
        // Positive Y hole
        translate([1, -11, 0])
            cylinder(h = height + epsilon, d = pole_diameter, center = false);
        // Negative Y opening
        translate([11.5, 11, 0])
            cylinder(h = height + epsilon, d = pole_diameter, center = false);
        // Positive Y opening
        translate([11.5, -11, 0])
            cylinder(h = height + epsilon, d = pole_diameter, center = false);
    }
}

module curve() {
    difference() {
        translate([0,0,height/2])
            cube([width, depth, height], center = true);
        cylinder(height + epsilon, d = depth + epsilon, center = false);
    }
}

difference() {
    thing();
    curve();
}