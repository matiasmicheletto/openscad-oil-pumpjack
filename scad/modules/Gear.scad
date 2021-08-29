use <GearGenerator.scad>

module gear(motor){
    /* Reduction gears for motor and cranks */

    H = 6;                          // Height
    R = (motor ? 15.5 : 7.6)+2;     // External radius
    
    Z = motor ? 20 : 10;            // Number of teeth

    Ra = 2.50;                      // Shaft radius
    Rb = 1.55;                      // Stepper shaft shape

    // Holes
    Nh = 6;                         // Number of holes
    Rh = motor ? 3 : 1;             // Radius
    Dh = R/2;                       // Distance from the center

    difference(){
        union(){ // Envelope
            spur_gear(2*R/Z, Z, H, 0);
            cylinder(r = R-2, h = H);
        }

        if(motor){ // Shaft
            intersection(){
                cylinder(r = Ra, h = H);
                translate([0,0,H/2])
                    cube([Rb*2,Ra*2,H], center = true);
            }
        }else{
            cylinder(r = Ra, h = H); // Shaft
        }
        
        // Holes
        for(angle = [0 : 360/Nh : 360])
            translate([Dh*sin(angle),Dh*cos(angle),0])
                cylinder(r = Rh, h = H);         
    }
}

gear(true);
translate([35,0,0])
    gear(false);
