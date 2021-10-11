module horseHead(R, shr){
    /* The horse head is placed at the end of the walking
    beam and is responsible for the mechanical transmission 
    of the movement to the piston in the underground pump. */ 
    
    W = 12;     // Width (X) 
    L = 70;     // Length (Y)
    H = 20;     // Part thickness (Z)
    a = 6;      // Base width
    b = 5;      // Height
    
    // Coupling peg dimensions
    delta = 6; // Displacement
    a1 = 12.5;  // Width (Y)
    b1 = 10.5;  // Length (Z)

    // Shape polygon
    poly = [[0,-L/2],
            [W+2,-L/2],
            [W+a,b-L/2],
            [W+a,L/2-b],
            [W+2,L/2],
            [0,L/2]];
            
    module coupling_peg(){
        // Walking beam coupling peg
        translate([(a-W)/2+5, 0, H/2])
            cube([W+a, a1, b1], center = true);
        translate([0, 0, H/2])
            cylinder(r = shr, h = H, center = true);
    }

    translate([0, 0, -H/2]){ 
        difference(){
            linear_extrude(height = H)
                intersection(){
                    translate([R, -b1/2, 0])
                        circle(R+W);
                    translate([-W, -delta, 0])
                        polygon( points=poly );
                }
            
            coupling_peg();
        }
    }
}

horseHead(65, 1.7);