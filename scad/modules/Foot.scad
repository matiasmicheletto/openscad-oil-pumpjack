module foot(){
    /* This is the model for the samson post that holds the 
    center of the walking beam in its place*/
    
    a = [7,14,130];     // Samson post
    b = [20.5,14,5];    // Long horizontal foot
    c = [12,14,5];      // Short horizontal foot
    rh = 2.3;           // Walking beam coupling hole radius
    re = 5;             // Mounting point outer radius
    rv = 1.7;           // Screw hole radius
    
    difference(){
        union(){
            translate([0,0,a.z/2])
                cube(a, center = true);
            translate([b.x/2,0,b.z/2])
                cube(b, center = true);
            translate([-c.x/2,0,c.z/2])
                cube(c, center = true);
            // Mounting point
            translate([0,0,a.z])
            rotate([90,0,0])
                cylinder(r = re, h = a.y, center = true);
            // Foot reinforcement
            translate([0,0,re])
            rotate([90,0,0])
                cylinder(r = re, h = a.y, center = true);
        }

        // Mounting point peg
        translate([0,0,a.z])
            cube([2*re,10,2*re], center = true);
        
        // Mounting point hole
        translate([0,0,a.z])
        rotate([90,0,0])
            cylinder(r = rh, h = a.y+1, center = true);
        
        // Ground screw holes
        translate([b.x-rv-2,0,b.z/2])
            cylinder(r = rv, h = b.z, center = true);
        translate([-c.x+rv+2,0,b.z/2])
            cylinder(r = rv, h = c.z, center = true);
    }
}

foot();