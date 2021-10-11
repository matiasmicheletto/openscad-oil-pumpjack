module equalizer(shr, psr){
    /* The equalizer is attached to the walking beam and transfers
    the power from the pitmans arms to it. Its length should match 
    the separation between the cranks. */
    
    shl = 11; // Side shafts length

    L = 85;   // Part total length (Y)
    W = 7.5;  // Part width (X)
    
    h = 10;   // walking beam peg height (Z)    
    w = 10;   // Walking beam width (Y)
    
    br = h-psr;   // Rounder border radius
    
    module body() {
        cube([W, L-2*shl, 2*psr], center = true);
        
        translate([0, 0, br/2+psr])
            cube([W, L-2*shl-2*br, br], center = true);
        
        translate([0, shl-L/2+br, psr])
            rotate([0,90,0])
                cylinder(r = br, h = W, center = true);
        translate([0, L/2-shl-br, psr])
            rotate([0, 90, 0])
                cylinder(r = br, h = W, center = true);

        translate([0, (L-shl)/2, 0])
            rotate([90, 0, 0])
                cylinder(r = psr-0.1, h = shl, center = true);
            
        translate([0, (shl-L)/2, 0]) 
            rotate([90, 0, 0])
                cylinder(r = psr-0.1, h = shl, center = true);
    }
    
    difference(){
        color([.5,.5,.5])
        body();
        translate([0,0,h/2])
            cube([w, W, h], center = true);
        translate([0,0,-psr/2])
            cylinder(r = shr, h = psr, center = true);
    }
}

equalizer(1.7, 3.5);
