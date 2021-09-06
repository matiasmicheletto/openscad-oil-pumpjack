module horseHead(){
    /* The horse head is placed at the end of the walking
    beam and is responsible for the mechanical transmission 
    of the movement to the piston in the underground pump. */ 
    
    W = 11;     // Width (X) 
    R = 65+W;   // Rotation radius

    L = 70;     // Length (Y)
    H = 20;     // Piece thickness (Z)
    a = 6;      // Base
    b = 5;      // Height

    // Coupling displacement
    delta = 6;

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
        r2 = 1.7;   // Screw hole radius

        translate([(W+a)/2+5,delta,0])
            cube([W+a,a1,b1], center = true);
        translate([W,delta,0])
            cylinder(r = r2, h = H, center = true);
    }


     difference(){
        linear_extrude(height = H, center = true)
            intersection(){
                translate([R,0,0])
                    circle(R);
                translate([0,0,0])
                    polygon( points=poly );
            }
        
        coupling_peg();
    }
}

horseHead();
