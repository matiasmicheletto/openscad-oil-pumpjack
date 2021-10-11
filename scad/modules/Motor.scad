module block(motor, shr, msr, c){ 
    /* A block to hold the stepper motor and main shaft */

    es = 15;    // Excentricity of the shaft hole
    L = 45;     // Width (X)    
    W = motor ? 18 : 9; // Length (Y)
    hh = 5;     // Mounting height
    H = c-es-hh;     // Height (Z)
    
    module envelope() {
        union(){
            translate([0, 0, -H/2-es])
                cube([L, W, H], center = true); // Envelope        
            
            // Rounded top
            translate([0, 0, -es])
                rotate([90, 0, 0])
                    cylinder(r = L/2, h = W, center = true);    
            
            // Mounting
            translate([0, 0, -H-hh/2-es])
                cube([L + 8*shr, W, hh], center = true); 
        }
    }
    
    module motor_hole() { // Space for motor placement
        Rm = 14 + 0.1;    // Motor radius
        d2 = 35;          // Distance between screw holes
        
        // Motor cable cover
        wc1 = 3 + 0.2;
        lc1 = 17 + 0.2;
        xc1 = sqrt(Rm*Rm-lc1*lc1/4)+wc1/2;
        wc2 = 5 + 0.2;
        lc2 = 14.5 + 0.2;
        xc2 = sqrt(Rm*Rm-lc2*lc2/4)+wc2/2;
        wc3 = 7;
        lc3 = 6;
        xc3 = sqrt(Rm*Rm-lc3*lc3/4)+wc3/2;
        
        union(){
            translate([0,0,-H/2-es])
                rotate([90,0,0])
                    cylinder(r = Rm, h = W+0.2, center = true);
               
            // Motor screw holes
            translate([-d2/2, 0, -H/2-es])
            rotate([90, 0, 0])
                cylinder(r = shr, h = W, center = true);    
            translate([d2/2, 0, -H/2-es])
            rotate([90, 0, 0])
                cylinder(r = shr, h = W, center = true);
            
            // Motor cable cover
            translate([0, 0, -xc1-H/2-es])
                cube([lc1, W, wc1], center = true);
            translate([0, 0, -xc2-H/2-es])
                cube([lc2, W, wc2], center = true);
            translate([0, 0, -xc3-H/2-es])
                cube([lc3, W, wc3], center = true);    
        }
    }
    
    module shaft_hole(){
        rotate([90,0,0])
            cylinder(r = msr+0.7, h = W, center = true);    
    }
    
    module screw_holes(){
        translate([-L/2-2*shr, 0, -H-hh/2-es])
            cylinder(r = shr, h = hh, center = true);    
        translate([L/2+2*shr, 0, -H-hh/2-es])
            cylinder(r = shr, h = hh, center = true);
    }

    difference(){ 
        color([.5,.5,.5])
        envelope();
        if(motor) motor_hole();
        shaft_hole();
        screw_holes();
    }
}

block(true, 1.7, 2.3, 60);
translate([0,28.5,0])
    block(false, 1.7, 2.3, 60);
