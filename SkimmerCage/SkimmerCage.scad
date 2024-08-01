$fn = $preview ? 30 : 120;
epsilon = 0.001;

height = 45;
width = 29.8;
depth = 25;
shell_thickness = 2;
slot_width = 2;
slot_space = 2;
slot_offset = 0;
side_slot_extra_depth = 0;
neck = 3;
cylinder_size = 2.75;
edge_flow_box_depth = 4;

step_size = slot_space + slot_width;

module thing() {
    difference() {
        union() {
            cube([height, width, depth]);

            //Add necks
            translate([0, 0, depth])
                cube([height, shell_thickness, neck]);
            translate([0, width - shell_thickness, depth])
                cube([height, shell_thickness, neck]);
            
            //Add holding cylinders
            translate([0, shell_thickness/2, depth + neck])
                rotate([0, 90, 0])
                cylinder(h = height, d = cylinder_size, center = false);

            translate([0, width - (shell_thickness/2), depth + neck])
                rotate([0, 90, 0])
                cylinder(h = height, d = cylinder_size, center = false);
        }
        
        internal_height = height - (2 * shell_thickness);
        height_modulus = (internal_height % (slot_width + slot_space));
        height_start_offset = shell_thickness + height_modulus;
        height_end_offset = internal_height - height_modulus;
        
        //slots on y
        for (dx=[height_start_offset:step_size:height_end_offset]) {
            translate([dx, -0.01, shell_thickness])
                cube([slot_width, width + (shell_thickness - 0.01), depth - (shell_thickness * 2) + side_slot_extra_depth]);
        }
        
        internal_width = width - (2 * shell_thickness);
        modulus = (internal_width % (slot_width + slot_space));
        start_offset = shell_thickness + modulus + slot_offset;
        end_offset = internal_width - modulus;
        
        //slots on z and x
        for (dy=[start_offset:step_size:end_offset]) {
            //z
            translate([shell_thickness, dy, -0.01])
                cube([height - (shell_thickness * 2), slot_width, shell_thickness + 0.01]);
            //x
            translate([-0.01, dy, shell_thickness])
                cube([height + (shell_thickness - 0.01), slot_width, depth - (shell_thickness * 2)]);
        }
        
        //hollow it out
        translate([shell_thickness, shell_thickness, shell_thickness - 0.01])
            cube([height - (shell_thickness * 2), width - (shell_thickness * 2), depth - (shell_thickness - 0.02)]);
        
        //edge flow box
        translate([5, -5, depth+neck-edge_flow_box_depth])
            cube([height - 10, width + 10, depth]);
    }
}

module bottomFillet(length) {
    difference() {
        cube([4, length+epsilon, 4]);
        translate([0, (length/2)+1, 4])
            rotate([90, 0, 0])
                cylinder(length + (epsilon*2) +2, d = 4 + epsilon, center = true);
    }
}

difference() {
    thing();
    //add bottom fillets
    translate([height-2,0,-2])
        bottomFillet(width);
    translate([-2,0,2])
        rotate([0, 90, 0])
            bottomFillet(width);
    translate([height,width-2,-2])
        rotate([0, 0, 90])
            bottomFillet(height);
    translate([0,2,-2])
        rotate([0, 0, 270])
            bottomFillet(height);
}

