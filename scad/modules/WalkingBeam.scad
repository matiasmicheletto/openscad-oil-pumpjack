module beam(r1, r2, shr, msr, type = 1){
    /* The walking beam acts as a class I lever transferring the 
     * movement from the pitmans arms to the horse head. */

    H = 12; // Height
    W = 10; // Width
    e = 10; // Total added extension
    
    difference(){
        union(){            
            translate([type==1 ? (r2-r1)/2 : (-r2-r1)/2, 0, H/2]) // Walking beam body
                cube([r1+r2+e, W, H], center = true);                       
            
            rotate([90, 0, 0]) // Fulcrum or pivoting point
                cylinder(r = 2*msr, h = W, center = true);
        }
        
        rotate([90,0,0]) // Pivoting point hole
            cylinder(r = msr, h = W+1, center = true);
        
        translate([type==1 ? r2 : -r2,0,H/2]) // Equalizer mounting screw hole
            cylinder(r = shr, h = H+1, center = true);
        
        translate([type==1 ? -r1 : -r1-r2,0,H/2]) // Horse head screw hole
        rotate([90,0,0])
            cylinder(r = shr, h = W+1, center = true);
    }
}

beam(65, 75, 1.7, 2.3, 2);