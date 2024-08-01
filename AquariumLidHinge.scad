$fn = $preview ? 30 : 120;
epsilon = 0.001;

pin_hole = 5;
pin_mount = 4;
pin_length = 20;
depth = 20;
width = pin_length + (pin_mount/2);
glass_thickness = 4;
hinge_gap = 0.5;

module pin_holder() {
    difference() {
        translate([0,0,(pin_hole + pin_mount)/2])
            rotate([90, 0, 0])
                cylinder(h = pin_length+(pin_mount/2), d = pin_hole + pin_mount, center = false);
        translate([0,0,(pin_hole + pin_mount)/2])
            rotate([90, 0, 0])
                cylinder(h = pin_length + epsilon, d = pin_hole + epsilon, center = false);
    }
}

module glass_clamp() {
    translate([0, -width, 0])
        cube([depth, width, 2]);
    translate([0, -width, 2 + glass_thickness])
        cube([depth, width, 2]);
    translate([0, -width, 0])
        cube([2, width, 4 + glass_thickness]);
}

module pin_holder_stand_in() {
    translate([0,0,(pin_hole + pin_mount)/2])
        rotate([90, 0, 0])
            cylinder(h = pin_length+(pin_mount/2), d = pin_hole + pin_mount, center = false);
}

module curve() {
    difference() {
        translate([0,0,height/2])
            cube([width*2, depth, height], center = true);
        cylinder(height + epsilon, d = depth + epsilon, center = false);
    }
}

module topFillet() {
    difference() {
        cube([4, depth, 4]);
        translate([0, (depth/2)+1, 0])
            rotate([90, 0, 0])
                cylinder(depth+2, d = 4 + epsilon, center = true);
    }
}

module bottomFillet() {
    difference() {
        cube([4, depth, 4]);
        translate([0, (depth/2)+1, 4])
            rotate([90, 0, 0])
                cylinder(depth+2, d = 4 + epsilon, center = true);
    }
}

translate([0, 0, width])
rotate([90, 0 , 0]) {
    difference() {
        glass_clamp();
        translate([0, 0, 2 + glass_thickness])
            pin_holder_stand_in();
    }
    translate([0, 0, 2 + glass_thickness])
        pin_holder();
}

//TODO: remove the double translate
//TODO: chamfer everything
//TODO: add flag for other hinge side
//TODO: other hinge side needs air hole thing

