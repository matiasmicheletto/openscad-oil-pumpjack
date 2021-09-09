module crank(r3, msr, psr){
    /* The crank is the piece that transfers the motor torque to 
    the walking beam. It is composed of an arm and a counterweight. */
    
    R = r3*11/6; // Crank total radius
    H = 7;       // Part thickness (Z)    
    Lc = 20;     // Counterweigth section (X)
    
    module arm(){
        Wp = 15;    // Arm width
        e = r3/5;   // Arm extension opposite to the counterweight        

        difference(){
            translate([(R-Lc-msr-e)/2, 0, 0])
                cube([R-Lc+msr+e, Wp, H], center = true);
            cylinder(r = msr, h = H, center = true);
        }
    }
    
    module counterweight(){
        Wc = 50;    // Counterweight width (Y)

        intersection(){
            cylinder(r = R, h = H, center = true);
            translate([R-Lc/2, 0, 0])
                cube([Lc, Wc, H+1], center = true);
        }
    }

    module pitmans_shaft(){
        hp = 11;  // Altura eje de biela
        
        translate([r3, 0, (H+hp)/2])
            cylinder(r = psr-0.1, h = hp, center = true);
    }

    union(){
        arm();
        counterweight();
        pitmans_shaft();
    }
}

crank(30, 2.3, 3.5);
