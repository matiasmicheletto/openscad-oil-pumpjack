module foot(){
    
    a = [7,14,130];     // Poste vertical
    b = [20.5,14,5];    // Pie horizontal largo
    c = [12,14,5];      // Pie horizontal corto
    rh = 2.3;           // Radio de orificio para eje de apoyo
    re = 5;             // Radio exterior de la zona de apoyo
    rv = 1.7;           // Radio para orificios de tornillos
    
    difference(){
        union(){
            translate([0,0,a.z/2])
                cube(a, center = true);
            translate([b.x/2,0,b.z/2])
                cube(b, center = true);
            translate([-c.x/2,0,c.z/2])
                cube(c, center = true);
            // Punto de apoyo
            translate([0,0,a.z])
            rotate([90,0,0])
                cylinder(r = re, h = a.y, center = true);
            // Refuerzo de la base
            translate([0,0,re])
            rotate([90,0,0])
                cylinder(r = re, h = a.y, center = true);
        }
        // Ahuecar zona de ajuste
        translate([0,0,a.z])
            cube([2*re,10,2*re], center = true);
        
        // Orificio para el eje
        translate([0,0,a.z])
        rotate([90,0,0])
            cylinder(r = rh, h = a.y+1, center = true);
        
        // Orificios para tornillos de ajuste del pie al suelo
        translate([b.x-rv-2,0,b.z/2])
            cylinder(r = rv, h = b.z, center = true);
        translate([-c.x+rv+2,0,b.z/2])
            cylinder(r = rv, h = c.z, center = true);
    }
}

foot();