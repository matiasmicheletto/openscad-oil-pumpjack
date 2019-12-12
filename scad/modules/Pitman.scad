$fn = 100;

module pitman(){
    pt = [12,100,5]; // Dimensiones de los brazos
    rh = 3.5; // Radio ejes
    
    difference(){
        union(){
            cube(pt, center = true);
            translate([0,-pt.y/2,0])
                cylinder(r = pt.x/2, h = pt.z, center = true);
            translate([0,pt.y/2,0])
                cylinder(r = pt.x/2, h = pt.z, center = true);
        }
        translate([0,-pt.y/2,0])
            cylinder(r = rh, h = pt.z, center = true);
        translate([0,pt.y/2,0])
            cylinder(r = rh, h = pt.z, center = true);
    }
}

module equalizer(){
    eq = [100,15,7]; // Dimensiones del travesanio
    bm = [10,5]; // Medidas del brazo para el apoyo
    rh = 3.5; // Radio ejes
    rt = 2.3; // Radio tornillo ajuste
    h = 10; // Largo de los cilindros de ajuste
    
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

translate([0,20,0])
rotate([0,0,90])
    pitman();
translate([0,40,0])
rotate([0,0,90])
    pitman();
equalizer();