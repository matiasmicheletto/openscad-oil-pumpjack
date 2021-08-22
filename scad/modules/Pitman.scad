module pitman(){
    pt = [13,65,5]; // Dimensiones de los brazos
    rh = 3.75;      // Radio ejes
    
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

rotate([0,0,90])
    pitman();
translate([0,20,0])
rotate([0,0,90])
    pitman();
