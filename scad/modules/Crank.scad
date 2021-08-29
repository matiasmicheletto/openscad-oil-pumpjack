module crank(){
    /* The crank is the piece that transfers the motor torque to 
    the walking beam. It is composed of an arm and a counterweight. */
    

    $fn = 50;
    
    H = 7;      // Part thickness (Z)
    R = 55;     // Total crank lenght (X)
    Lc = 20;    // Counterweigth section (X)
    
    module arm(){
        Wp = 15;    // Arm width
        e = 6;      // Arm extension opposite to the counterweight
        rh1 = 2.3;  // Shaft hole radius

        difference(){
            translate([(R-Lc-rh1-e)/2, 0, 0])
                cube([R-Lc+rh1+e, Wp, H], center = true);
            cylinder(r = rh1, h = H, center = true);
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
        rh2 = 3.5;  // Radio eje biela
        hp = 12.5;  // Altura eje de biela
        dh12 = 30;  // Separacion entre orificio central y eje biela
        
        translate([dh12, 0, H])
            cylinder(r = rh2, h = hp, center = true);
    }

    union(){
        counterweight();
        arm();
        pitmans_shaft();
    }
}

crank();
