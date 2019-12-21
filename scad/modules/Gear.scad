use <GearGenerator.scad>

module gear(motor){
    H = 6;                          // Altura
    R = (motor ? 15.5 : 7.6)+2;        // Radio exterior
    
    Z = motor ? 20 : 10;            // Cantidad de dientes

    Ra = 2.50;                      // Radio eje
    Rb = 1.55;                      // Achatamiento

    // Orificios
    Nh = 6;                         // Cantidad
    Rh = motor ? 3 : 1;             // Radio 
    Dh = R/2;                       // Separacion desde el centro

    difference(){
        
        union(){ // Envolvente
            spur_gear(2*R/Z, Z, H, 0);
            cylinder(r = R-2, h = H);
        }

        if(motor){// Eje achatado
            intersection(){
                cylinder(r = Ra, h = H);
                translate([0,0,H/2])
                    cube([Rb*2,Ra*2,H], center = true);
            }
        }else{
            cylinder(r = Ra, h = H); // Eje
        }
        
        // Orificios
        for(angle = [0 : 360/Nh : 360])
            translate([Dh*sin(angle),Dh*cos(angle),0])
                cylinder(r = Rh, h = H); 

        
    }
}


//$fn = 250;
gear(true);
translate([35,0,0])
    gear(false);
