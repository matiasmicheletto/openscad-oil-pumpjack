module pitman(){
    /* The pitman's arms are responsible for converting
    the circular movement from the cranks to the linear 
    movement of the walking beam*/

    pt = [13,65,5]; // Arms dimensions
    rh = 3.75;      // Shaft hole radius
    
    difference(){
        union(){
            cube(pt, center = true);
            // Semicircular endings
            translate([0,-pt.y/2,0])
                cylinder(r = pt.x/2, h = pt.z, center = true);
            translate([0,pt.y/2,0])
                cylinder(r = pt.x/2, h = pt.z, center = true);
        }
        translate([0,-pt.y/2,0])
            cylinder(r = rh, h = pt.z, center = true);
        translate([0,pt.y/2,0])
            cylinder(r = rh, h = pt.z, center = true);
    }
}

rotate([0,0,90])
    pitman();
translate([0,20,0])
rotate([0,0,90])
    pitman();
