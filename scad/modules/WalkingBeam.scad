
module beam(){
    r1 = 75; // Distancia del cabezal al apoyo
    r3 = 65; // Distancia del ecualizador al apoyo
    e = 10; // Extension adicional total
    a = [r1+r3+e,10,12];  // Dimensiones del balancin
    rh = 1.7;           // Radio orificios para ajuste
    b = [5, 2.3];       // Dims ajuste (radio exterior e interior
    d = -5;              // Desplazamiento lateral respecto del punto de apoyo
    
    difference(){
        union(){
            // Barra
            translate([d,0,0])
                cube(a, center = true);                       
            
            // Punto de apoyo
            translate([0,0,a.z/2])
            rotate([90,0,0])
                cylinder(r = b.x, h = a.y, center = true);
        }
        
        // Agujero para el eje del punto de apoyo
        translate([0,0,a.z/2])
        rotate([90,0,0])
            cylinder(r = b.y, h = a.y+1, center = true);
        
        // Tornillo ajuste ecualizador
        translate([-r1,0,0])
            cylinder(r = rh, h = a.z+1, center = true);
        
        // Tornillo ajuste del cabezal
        translate([r3,0,0])
        rotate([90,0,0])
            cylinder(r = rh, h = a.y+1, center = true);
    }
}

beam();