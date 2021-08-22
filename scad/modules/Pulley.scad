module pulley(motor){
    H = 6;                          // Altura
    Rp = 2;                         // Radio de la pista (menor que H/2)
    R = (motor ? 15 : 7)+Rp;        // Radio exterior

    Ra = 2.50;                      // Radio eje
    Rb = 1.55;                      // Achatamiento

    // Orificios
    Nh = 6;                         // Cantidad
    Rh = motor ? 3 : 1;             // Radio 
    Dh = (motor ? R-Rp : R)/2+1;    // Separacion desde el centro

    // Ahuecamiento
    Di = 2;                         // Borde interior
    De = motor ? 4 : 2.5;           // Borde exterior
    e = 2;                          // Profundidad

    difference(){
        cylinder(r = R, h = H);     // Envolvente

        if(motor){                  // Eje achatado
            intersection(){
                cylinder(r = Ra, h = H);
                translate([0,0,H/2])
                    cube([Rb*2,Ra*2,H], center = true);
            }
        }else{
            cylinder(r = Ra, h = H); // Eje
        }

        // Pista para la cuerda convexa
        rotate_extrude(convexity = 10)
        translate([R, H/2, 0])
            circle(r = Rp);  
        
        // Orificios
        for(angle = [0 : 360/Nh : 360])
            translate([Dh*sin(angle),Dh*cos(angle),0])
                cylinder(r = Rh, h = H); 

        // Ahuecamiento superior
        translate([0,0,H-e])
            difference(){
                cylinder(r = R-De, h = e);
                cylinder(r = Ra+Di, h = e);
            }
    }
}

pulley(true);
translate([30,0,0])
    pulley(false);
