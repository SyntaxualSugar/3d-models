$fn = $preview ? 30 : 120;
epsilon = 0.001;

screw_hole_diameter = 4;
screw_dist_from_edge = screw_hole_diameter/2 + 3;
screw_inset_diameter = 8;
screw_inset_thickness = 2;
screw_inset_dist_from_edge = screw_inset_diameter/2 + 1;
ring_inner_diameter = 58;
ring_outer_diameter = 85;
ring_height = 4;
ring_bevel = 4;

hose_cylinder_wall_thickness = 2;
hose_inner_diameter = 58;
hose_outer_diameter = hose_inner_diameter + (hose_cylinder_wall_thickness * 2);
hose_cylinder_height = 40;
hose_cone_outer_diameter = ring_inner_diameter;

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
        union() {
            cylinder(h = ring_height, d = ring_outer_diameter, center = false);
            // Add hose cylinder
            cylinder(h = hose_cylinder_height, d = hose_outer_diameter, center = false);
            translate([0,0,ring_height])
                roundConcaveFillet(hose_outer_diameter/2, 5);
        }
        
        // Negative X hole
        translate([-(ring_outer_diameter/2) + screw_dist_from_edge, 0, 0])
            cylinder(h = ring_height, d = screw_hole_diameter, center = false);
        // Positive X hole
        translate([(ring_outer_diameter/2) - screw_dist_from_edge, 0, 0])
            cylinder(h = ring_height, d = screw_hole_diameter, center = false);
        // Negative X screw inset
        translate([-(ring_outer_diameter/2) + screw_inset_dist_from_edge, 0, screw_inset_thickness])
            cylinder(h = 3, d = screw_inset_diameter, center = false);
        // Positive X screw inset
        translate([(ring_outer_diameter/2) - screw_inset_dist_from_edge, 0, screw_inset_thickness])
            cylinder(h = 3, d = screw_inset_diameter, center = false);
        
        // Hollow hose cylinder
        cylinder(h = 100, d = hose_inner_diameter, center = false);
    }
}

difference() {
  thing();  
  roundConvexFillet(ring_outer_diameter/2, 4);
    translate([0, 0, hose_cylinder_height-1])
halfCircleConvexFillet(hose_outer_diameter/2, hose_cylinder_wall_thickness);
}
