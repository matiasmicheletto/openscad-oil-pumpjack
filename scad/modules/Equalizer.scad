module equalizer(){
    /* The equalizer is attached to the walking beam and transfers
    the power from the pitmans arms to it. Its length should match 
    the separation between the cranks. */

    eq = [62,15,7]; // Equalizers dimensions (x,y,z)
    bm = [10,10];   // Walking beam coupling section
    h = 13;         // Side shafts length
    rh = 3.5;       // Side shafts radius
    rt = 1.7;       // Screw hole radius
    
    difference(){
        union(){
            translate([0,-eq.y/4,0])
                cube([eq.x,eq.y/2,eq.z], center = true);
            translate([0,eq.y/4,0])
                cube([eq.x-eq.y,eq.y/2,eq.z], center = true);
            translate([eq.x/2-eq.y/2,0,0])
                cylinder(r = eq.y/2, h = eq.z, center = true);
            translate([-eq.x/2+eq.y/2,0,0])
                cylinder(r = eq.y/2, h = eq.z, center = true);
            translate([(eq.x+h)/2,-rh,0])
            rotate([0,90,0])
                cylinder(r = rh-0.1, h = h, center = true);
            translate([-(eq.x+h)/2,-rh,0])
            rotate([0,90,0])
                cylinder(r = rh-0.1, h = h, center = true);
        }
        
        // Walking beam peg
        translate([0,(eq.y-bm.y)/2,0])
            cube([bm.x,bm.y,eq.z], center = true);
        // Screw hole
        rotate([90,0,0])
            cylinder(r = rt, h = eq.y, center = true);
    }
}

equalizer();
