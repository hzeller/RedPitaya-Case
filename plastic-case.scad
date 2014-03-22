// RedPitaya case
//(cc-BY-SA) h.zeller@acm.org
// Some measurements are a bit manually 'adjusted' - this should be more
// parametric. Ah, well, first version.
$fn=48;
epsilon=0.1;

case_thick=1.5;

// rounded: pretty for printing, but without much faster for development.
// Also, might create trouble with 'liftoff'
rounded=true;

stand_b=5;   // Standoff bottom
stand_t=6;   // Standoff top (above board, below shield)

mechanical_support=0.8;

screw_head_dia=6;
screw_head_thick=2;
screw_base_dia=8.2;

base_headroom=1;
shield_mount_thick=1;  // The thickness of the two shielding flaps on top of each other.
board_thick=1.65;
above_shield=stand_b + board_thick + stand_t + shield_mount_thick;

base_t=above_shield + base_headroom;
base_w=90;
base_h=65;

drill_hole=3 + 0.3;

connector_height=9.3;

heatsink_extra_space=4;  // Additional space around edges of the heatsink.

// The standoff in the corner of the analog area. With
// one flat area, so that it is possible to tempoarily fix
// it to the 13x2 connector while assembling.
module analog_corner_standoff() {
    difference() {
	hull() {
	    cylinder(r=stand_t/2, h=stand_t);
	    translate([-connector_height + stand_t/2, -stand_t/2, 0]) cube([connector_height, 0.1, stand_t]);
	}

	// bore hole.
	translate([0,0,-epsilon]) cylinder(r=drill_hole/2, h=stand_t + 2 * epsilon);
    }
}

module bottom_standoff() {
    difference() {
	cylinder(r=stand_t/2, h=stand_b);
	translate([0,0,-epsilon]) cylinder(r=drill_hole/2, h=stand_t + 2 * epsilon);
    }
}

// Put together the set of standoffs needed.
module standoffs() {
    translate([-10, 10, 0]) mirror([1,0,0]) analog_corner_standoff();
    translate([10, 10, 0]) analog_corner_standoff();
    translate([-10, 0, 0]) bottom_standoff();
    translate([10, 0, 0]) bottom_standoff();
    translate([-10, -10, 0]) bottom_standoff();
    translate([10, -10, 0]) bottom_standoff();
}

// Parts mounted on the RedPitaya
module connector13x2() {
    color("DarkSlateGray") cube([40.6 + 2 * 0.5, 8.8 + 2 * 0.3, connector_height + 1]);
}
module ethernet() {
    // we go 'underground' as we need to poke space into the case
    color("silver") translate([0, 0, -8]) cube([25, 19.5, 11.3 + 8]);
}
module usb() {
    color("silver") translate([0, 0, -8]) cube([21, 7.5, 14.5 + 8]);
}
module sata() {
    color("DarkSlateGray") cube([35, 6.5, connector_height + 1]);
}
module heatsink() {
    color("DarkSlateGray") rotate([0, 0, -45]) translate([0, 0, 10]) {
	difference() {
	    cube([28.5 + heatsink_extra_space, 28.5 + heatsink_extra_space, 20], center=true);
            // Some support through the fins
	    translate([0, 0, 2]) cube([30 + heatsink_extra_space, 0.8, 16], center=true);
	}
    }
    translate([-23.3, 0, 0]) cylinder(r=4, h=9);
    translate([+23.3, 0, 0]) cylinder(r=4, h=9);
}
module led_window() {
    cube([34, 3, 12]);
}
module bnc_cut(radius=4.2) {
    hull() {
	rotate([0, 90, 0]) cylinder(r=radius, h=15);
	translate([0, -4, -15]) cube([15, 2 * radius, 1]);
    }
}
module arrow() {
    cylinder(r=2.5, h=30, $fn=3);
}

// The rough outline of the RedPitaya, so that we can substract its volume from the
// case and thus punch the holes for connectors and heatsink.
module RedPitaya() {
    translate([87, 0, board_thick]) rotate([0, 0, 180]) {
	// from Red_Pitaya_Dimensions_v1.0.1.pdf. All measuremeents are from the back of the board
	// so that is what we're using as reference (later we need to shift that, as the rest of the
	// case assume zeor-X at the row of screws)
	difference() {
	    translate([0, -30, -board_thick]) color("red") cube([90, 60, board_thick]);
	    // screw holes.
	    translate([3, 27, -2 + epsilon])   cylinder(r=3/2, h=2);
	    translate([3, -27, -2 + epsilon])  cylinder(r=3/2, h=2);
	    translate([87, 27, -2 + epsilon])  cylinder(r=3/2, h=2);
	    translate([87, -27, -2 + epsilon]) cylinder(r=3/2, h=2);
	}

	// Show direction of input/output
	translate([92, 12, 0]) rotate([0, 0, 15]) scale([1.6, 1, 1]) arrow();
	translate([92, -12, 0]) rotate([0, 0, 180-15]) scale([1.6, 1, 1]) arrow();

	translate([43.1 - 0.5, 21.2 - 0.3, 0])    connector13x2();
	translate([43.1 - 0.5, -30 - 0.3, 0])     connector13x2();
	translate([6.6, -23.3 - 7, 0])   sata();
	translate([-2.2, 30 - 6 - 19, 0]) ethernet();
	translate([-2.2, -2, 0])    usb();
	translate([-5, -24, -10 + 1.7]) cube([10, 24, 10]);  // power, terminal, SD-card
	translate([55.5, 0, 0])       heatsink();

	// Capacitors
	translate([26, 12.5, 0]) color("silver") cylinder(r=8.5/2, h=9.2);
	translate([26, 21.5, 0]) color("silver") cylinder(r=8.5/2, h=9.2);

	translate([11, 30 - 5.2, 0]) cube([16, 2.7, 9]);  // JTAG
	translate([7.5, 28, 0]) led_window();  // we formulate that as block to punch out the top
	translate([89, -5.5, 0])  rotate([0, 0, -5]) bnc_cut();
	translate([89,  5.5, 0])  rotate([0, 0, 5])  bnc_cut();
	translate([87, -17.5, 0]) rotate([0, 0, -15]) bnc_cut();
	translate([87,  17.5, 0]) rotate([0, 0, 15])  bnc_cut();
    }
}

// The volume the case is wrapped around.
module cased_volume() {
    hull() {
	// Basic inner volume.
	translate([-3, -base_h/2, 0]) cube([base_w, base_h, base_t]);

	// The angled 'blocks' sticking out.
	// inner.
	translate([-3, 0, 0]) hull() {
	    rotate([0, 0, -5]) translate([-10, 0, 0]) cube([10, 13, base_t]);
	    rotate([0, 0, 5]) translate([-10, -13, 0]) cube([10, 13, base_t]);

	    // outer
	    rotate([0, 0, 15]) translate([-11, -26, 0]) cube([10, 13, base_t]);
	    rotate([0, 0, -15]) translate([-11, 13, 0]) cube([10, 13, base_t]);
	}
    }
}

module heatsink_support() {
    assign (extra_len= 1.41 * heatsink_extra_space) {
       translate([87 - 55.5, 21.2 - 0.5, base_t - 1 + case_thick/2]) cube([15 + extra_len, 0.7, 2 + case_thick], center=true);
       translate([87 - 55.5, -21.2 + 0.5, base_t - 1 + case_thick/2]) cube([15 + extra_len, 0.7, 2 + case_thick], center=true);
   }
}

// Negative volume inside the case. Essentially the cased volume, but we
// leave a couple of support structures in there.
module inner_volume() {
    // We want some mechanical construction parts left behind, e.g.
    // the screw supports or some rigidity enhancements. So we cut this out
    // of the inside block, so that they remain after we substract it from the outer block.
    difference() {
	cased_volume();
	
	// screw support.
	translate([0, 27, above_shield]) cylinder(r=screw_base_dia/2, h=40);
	translate([0, -27, above_shield]) cylinder(r=screw_base_dia/2, h=40);
	translate([84, 27, stand_b + board_thick]) cylinder(r=screw_base_dia/2, h=40);
	translate([84, -27, stand_b + board_thick]) cylinder(r=screw_base_dia/2, h=40);

	// Shielding case plastic melting mounts. These go through holes in the
	// shield to permanently mount the shield in the case ... with a soldering iron.
	translate([-5, 0, base_t - 4]) cylinder(r=1.3, h=5);
	translate([10, 13, base_t - 4]) cylinder(r=1.3, h=5);
	translate([10, -13, base_t - 4]) cylinder(r=1.3, h=5);

	// Some bridges around the connectors and heatsink corner to improve stability.
	// The heatsink cuts away some corner here, so below in mount(), we add that again.
	heatsink_support();

	// Angled support flaps for the back of the case.
	// Around the  SD card
	translate([80, 5, base_t]) rotate([0, 45, 0]) cube([20, mechanical_support, 20]);
	translate([80, 15, base_t]) rotate([0, 45, 0]) cube([20, mechanical_support, 20]);

	// Angled supports between connectors and SATA/LED-slot
	translate([87 - 42.5, 40, 5]) rotate([45 + 15, 0, 0]) cube([mechanical_support, 20, 20]);
	translate([87 - 42.5, -40, 5]) rotate([45 - 15, 0, 0]) cube([mechanical_support, 20, 20]);

	// Bar behind ethernet and usb
	translate([63, 8, base_t - 1.5 + epsilon]) cube([mechanical_support, 30, 3], center=true);

	// Bar accross the heatsink.
	translate([87 - 55.5, 0, base_t - 2/2]) rotate([0, 0, -45]) cube([34 + heatsink_extra_space, 0.8, 2], center=true);

	// Shield around LEDs (very close to ethernet - should not interfere with JTag)
	translate([54, -26, base_t - stand_t/2]) cube([20, mechanical_support, stand_t], center=true);
    }
}

module raw_case() {
    difference() {
	minkowski() {
	    cased_volume();
	    if (rounded) {
		//sphere(r=case_thick);  // This gives trouble with 'liftoff' platform.
		translate([0, 0, -case_thick]) cylinder(r=case_thick, h=2*case_thick);
	    } else {
		cube([2*case_thick, 2*case_thick, 2*case_thick], center=true);
	    }
	}
	inner_volume();
    }
}

module screw_head(x, y) {
    translate([x, y, base_t + case_thick - screw_head_thick + epsilon]) cylinder(r1=drill_hole/2, r2=screw_head_dia/2, h=screw_head_thick);
}

module case() {
    difference() {
	raw_case();

	translate([-20, -60, -15 + epsilon]) cube([120, 120, 15]);   // cut out bottom.

	// Screw holes
	translate([0, 27, 0]) cylinder(r=drill_hole/2, h=16);
	translate([0, -27, 0]) cylinder(r=drill_hole/2, h=16);
	translate([84, 27, 0]) cylinder(r=drill_hole/2, h=16);
	translate([84, -27, 0]) cylinder(r=drill_hole/2, h=16);

	// Screw heads
	screw_head(0, 27);
	screw_head(0, -27);
	screw_head(84, 27);
	screw_head(84, -27);
    }
}


module mount() {
    difference() {
	case();
	translate([0, 0, stand_b]) RedPitaya();
    }
    heatsink_support();
}

module print() {
    // Final assembly. Rotate so that it is on its back.
    translate([0, 0, base_t + case_thick]) rotate([180, 0, 0]) mount();

    // Standoffs. Might make sense to print separately to avoid too many
    // 'spiderwebs' between case and standoffs (depending on your hot-end)
    translate([31, 0, 0]) rotate([0, 0, -45]) standoffs();
}

// View RP separately
//RedPitaya();
print();
