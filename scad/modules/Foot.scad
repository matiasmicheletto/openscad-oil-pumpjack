module foot(a, c, msr, shr){
    /* This is the model for the samson post that holds the 
    center of the walking beam in its place*/
    
    sp = [7, 14, a+c];    // Samson post
    lf = [20.5, 14, 5];   // Long horizontal foot
    sf = [12, 14, 5];     // Short horizontal foot    
    sor = 5;              // Mounting point outer radius
    
    difference(){
        union(){
            translate([0, 0, sp.z/2])
                cube(sp, center = true);
            translate([lf.x/2, 0, lf.z/2])
                cube(lf, center = true);
            translate([-sf.x/2, 0, sf.z/2])
                cube(sf, center = true);
            // Mounting point
            translate([0,0,sp.z])
            rotate([90,0,0])
                cylinder(r = sor, h = sp.y, center = true);
            // Foot reinforcement
            translate([0, 0, sor])
            rotate([90, 0, 0])
                cylinder(r = sor, h = sp.y, center = true);
        }

        // Mounting point peg
        translate([0,0,sp.z])
            cube([2*sor, 10 ,2*sor], center = true);
        
        // Mounting point hole
        translate([0, 0, sp.z])
        rotate([90, 0, 0])
            cylinder(r = msr, h = sp.y+1, center = true);
        
        // Ground screw holes
        translate([lf.x - shr - 2, 0, lf.z/2])
            cylinder(r = shr, h = lf.z, center = true);
        translate([-sf.x + shr + 2, 0, lf.z/2])
            cylinder(r = shr, h = sf.z, center = true);
    }
}

foot(50, 60, 2.3, 1.7);