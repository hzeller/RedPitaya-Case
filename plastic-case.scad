$fn=48;
epsilon=0.1;

standoff_outer=6;
standoff_hole=3 + 0.25;
standoff_bottom_height=5;

analog_shield_height=6.5; // mm   Standoff height.
analog_shield_assembly_height=1;  // mm. Height of two metal shields

case_shell_thick=1;  // The case shell thickness.

// Total outside height of the case.
case_height=analog_shield_height + analog_shield_assembly_height + case_thick;

connector_height=9;

// The standoff in the corner of the analog area. With
// one flat area, so that it is possible to tempoarily fix
// it to the 13x2 connector while assembling.
module analog_corner_standoff() {
    difference() {
	hull() {
	    cylinder(r=standoff_outer/2, h=analog_shield_height);
	    translate([-connector_height + standoff_outer/2, -standoff_outer/2, 0]) cube([connector_height, 0.1, analog_shield_height]);
	}

	// bore hole.
	translate([0,0,-epsilon]) cylinder(r=standoff_hole/2, h=analog_shield_height + 2 * epsilon);
    }
}

module bottom_standoff() {
    difference() {
	cylinder(r=standoff_outer/2, h=standoff_bottom_height);
	translate([0,0,-epsilon]) cylinder(r=standoff_hole/2, h=analog_shield_height + 2 * epsilon);
    }
}

module standoffs() {
    translate([-10, 10, 0]) mirror([1,0,0]) analog_corner_standoff();
    translate([10, 10, 0]) analog_corner_standoff();
    translate([-10, 0, 0]) bottom_standoff();
    translate([10, 0, 0]) bottom_standoff();
    translate([-10, -10, 0]) bottom_standoff();
    translate([10, -10, 0]) bottom_standoff();
}


// Final assembly
standoffs();