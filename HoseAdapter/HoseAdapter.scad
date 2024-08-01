$fn=120;

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
echo(hose_outer_diameter);
hose_cylinder_height = 40;
hose_cone_outer_diameter = ring_inner_diameter;

difference() {
    union() {
        cylinder(h = ring_height, d = ring_outer_diameter, center = false);
        // Add hose cylinder
        cylinder(h = hose_cylinder_height, d = hose_outer_diameter, center = false);
        // Add hose cone
        cylinder(h = 14, d1 = hose_cone_outer_diameter+10, d2 = hose_outer_diameter, center = false);
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
    
    // Add base Bevel
    difference() {
        translate([0, 0, ring_height/2])
            cylinder(h = ring_height/2, d = ring_outer_diameter, center = false);
        translate([0, 0, ring_height/2])
            cylinder(h = ring_height/2, d1 = ring_outer_diameter, d2 = ring_outer_diameter - (ring_bevel * 2), center = false);
    }
    
    // Hollow hose cylinder
    cylinder(h = 100, d = hose_inner_diameter, center = false);
    // Hollow hose cone
    cylinder(h = 14, d1 = hose_cone_outer_diameter, d2 = hose_inner_diameter, center = false);
    
    // Remove excess from hose cylinder
    //cylinder(h = 4, d = ring_inner_diameter, center = false);
    
    // Add Top Rim Inner Bevel
    translate([0, 0, hose_cylinder_height - 1])
        cylinder(h = 1, d1 = hose_inner_diameter, d2 = hose_outer_diameter - (hose_cylinder_wall_thickness * 1.5), center = false);
    
    // Add Top Rim Outer Bevel
    difference() {
        translate([0, 0, hose_cylinder_height-1])
            cylinder(h = 1, d = hose_outer_diameter, center = false);
        translate([0, 0, hose_cylinder_height-1])
            cylinder(h = 1, d1 = hose_outer_diameter, d2 = hose_outer_diameter - (hose_cylinder_wall_thickness * 0.5), center = false);
    }
    
}

