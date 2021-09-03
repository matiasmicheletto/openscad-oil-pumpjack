module block(motor){ 
    /* A block to hold the stepper motor */

    // Outer dimensions
    W = 45;     // Width (X)    
    L = motor ? 18 : 9; // Length (Y)
    H = 40;     // Height (Z)
    
    ww = 14;    // Mounting width
    hh = 5;     // Mounting height

    Rs = 3;     // Shaft radius
    es = 15;    // Excentricity of the shaft hole

    r2 = 1.7;   // Screw hole radius
    
    module envelope() {
        union(){
            cube([W,L,H],center = true); // Envelope        
            
            // Rounded top
            translate([0,0,H/2])
            rotate([90,0,0])
                cylinder(r = W/2, h = L, center = true);    
            
            // Mounting
            translate([0,0,-H/2-hh/2])
                cube([W+ww,L,hh],center = true); 
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
            rotate([90,0,0])
                cylinder(r = Rm, h = L+0.2, center = true);
               
            // Motor screw holes
            translate([-d2/2,0,0])
            rotate([90,0,0])
                cylinder(r = r2, h = L, center = true);    
            translate([d2/2,0,0])
            rotate([90,0,0])
                cylinder(r = r2, h = L, center = true);
            
            // Motor cable cover
            translate([0,0,-xc1])
                cube([lc1,L,wc1], center = true);
            translate([0,0,-xc2])
                cube([lc2,L,wc2], center = true);
            translate([0,0,-xc3])
                cube([lc3,L,wc3], center = true);    
        }
    }
    
    module shaft_hole(){
        translate([0,0,H/2+es])
        rotate([90,0,0])
            cylinder(r = Rs, h = L, center = true);    
    }
    
    module screw_holes(){
        translate([-W/2-ww/4,0,-H/2-hh/2])
            cylinder(r = r2, h = hh, center = true);    
        translate([W/2+ww/4,0,-H/2-hh/2])
            cylinder(r = r2, h = hh, center = true);
    }

    difference(){ 
        envelope();
        if(motor) motor_hole();
        shaft_hole();
        screw_holes();
    }
}

block(true);
translate([0,28.5,0])
    block(false);
