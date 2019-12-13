module crank(){
    H = 10;    // Altura de la palanca (Z)
    // Contrapesa
    R = 100;    // Largo total de la palanca (X)
    Wc = 60;    // Ancho de contrapesa (Y)
    Lc = 25;    // Seccion de contrapesa (X)
    // Palanca 
    Wp = 15;    // Ancho del brazo de la  palanca
    e = 5;     // Sobresaliente opuesta a la contrapesa
    // Orificios para ejes
    rh1 = 3.5;  // Radio orificio eje central
    rh2 = 3.5;  // Radio eje biela
    dh12 = 50;  // Separacion entre orificio central y eje biela

    difference(){
        union(){
            // Contrapesa
            intersection(){
                cylinder(r = R, h = H, center = true);
                translate([R-Lc/2,0,0])
                    cube([Lc,Wc,H+1], center = true);
            }
            translate([(R-Lc-rh1-e)/2,0,0])
                cube([R-Lc+rh1+e,Wp,H], center = true);
            
            // Eje de biela
            translate([dh12,0,H])
                cylinder(r = rh2, h = H, center = true);
        }
        
        // Eje central
        cylinder(r = rh1, h = H, center = true);
    }
}

crank();
