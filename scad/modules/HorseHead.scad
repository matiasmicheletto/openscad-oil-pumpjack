module horseHead(r1, shr){
    /* The horse head is placed at the end of the walking
    beam and is responsible for the mechanical transmission 
    of the movement to the piston in the underground pump. */ 
    
    W = 12;     // Width (X) 
    R = r1+W;   // Rotation radius

    L = 70;     // Length (Y)
    H = 20;     // Piece thickness (Z)
    a = 6;      // Base
    b = 5;      // Height

    delta = 6; // Coupling displacement

    // Shape polygon
    poly = [[0,-L/2],
            [W+2,-L/2],
            [W+a,b-L/2],
            [W+a,L/2-b],
            [W+2,L/2],
            [0,L/2]];
            

    module coupling_peg(){
        // Walking beam coupling peg
        a1 = 12.5;  // Width (Y)
        b1 = 10.5;  // Length (Z)        

        translate([(a-W)/2+5, 0, H/2])
            cube([W+a, a1, b1], center = true);
        translate([0, 0, H/2])
            cylinder(r = shr, h = H, center = true);
    }


    translate([0, 0, -H/2]){ 
        difference(){
            linear_extrude(height = H)
                intersection(){
                    translate([R-W, -delta, 0])
                        circle(R);
                    translate([-W, -delta, 0])
                        polygon( points=poly );
                }
            
            coupling_peg();
        }
    }
}

horseHead(65, 1.7);
