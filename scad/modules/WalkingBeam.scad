module beam(){
    /* The walking beam acts as a class I lever transferring
    the movement from the pitmans arms to the horse head. */

    r1 = 75;                // Distance from horse head to mounting point (fulcrum).
    r2 = 65;                // Distance from the equalizer to the middle mounting point.
    e = 10;                 // Total added extension (beyond mounting points)
    a = [r1+r2+e,10,12];    // Walking beam dimensions
    rh = 1.7;               // Screw holes radius
    b = [5, 2.3];           // Outer and inner radius of the pivoting point
    d = -5;                 // Side displacement
    
    difference(){
        union(){
            // Walking beam body
            translate([d,0,0])
                cube(a, center = true);                       
            
            // Fulcrum or pivoting point
            translate([0,0,a.z/2])
            rotate([90,0,0])
                cylinder(r = b.x, h = a.y, center = true);
        }
        
        // Pivoting point hole
        translate([0,0,a.z/2])
        rotate([90,0,0])
            cylinder(r = b.y, h = a.y+1, center = true);
        
        // Equalizer mounting screw hole
        translate([-r1,0,0])
            cylinder(r = rh, h = a.z+1, center = true);
        
        // Horse head screw hole
        translate([r2,0,0])
        rotate([90,0,0])
            cylinder(r = rh, h = a.y+1, center = true);
    }
}

beam();