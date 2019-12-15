module equalizer(){
    eq = [55,15,7]; // Dimensiones del travesanio
    bm = [10,10]; // Medidas del brazo para el apoyo
    rh = 3.5; // Radio ejes
    rt = 1.7; // Radio tornillo ajuste
    h = 12.5; // Largo de los cilindros de ajuste
    
    difference(){
        union(){
            translate([0,-eq.y/4,0])
                cube([eq.x,eq.y/2,eq.z], center = true);
            translate([0,eq.y/4,0])
                cube([eq.x-eq.y,eq.y/2,eq.z], center = true);
            translate([eq.x/2-eq.y/2,0,0])
                cylinder(r = eq.y/2, h = eq.z, center = true);
            translate([-eq.x/2+eq.y/2,0,0])
                cylinder(r = eq.y/2, h = eq.z, center = true);
            translate([(eq.x+h)/2,-rh,0])
            rotate([0,90,0])
                cylinder(r = rh-0.1, h = h, center = true);
            translate([-(eq.x+h)/2,-rh,0])
            rotate([0,90,0])
                cylinder(r = rh-0.1, h = h, center = true);
        }
        // Apoyo del brazo 
        translate([0,(eq.y-bm.y)/2,0])
            cube([bm.x,bm.y,eq.z], center = true);
        // Orificio para atornillar
        rotate([90,0,0])
            cylinder(r = rt, h = eq.y, center = true);
    }
}

equalizer();
