$fn = 100;

// Brazo
dim = [100,10,5];

e = 2; // Espesor arandelas ajuste
rh = 2.3; // Radio orificio para ajuste
l = 2*rh+2; // Ancho


module side(){
    difference(){
        union(){ // Envolvente rectangular con terminacion circular
            cube([l,e,3*dim.z/2], center = true);
            
            translate([0,0,3*dim.z/4])
            rotate([90,0,0])
                cylinder(r = l/2, h = e, center = true);
        }        
        translate([0,0,3*dim.z/4])
        rotate([90,0,0])
            cylinder(r = rh, h = e+1, center = true);
    }
}

cube(dim, center = true);

translate([0,(dim.y-e)/2,dim.z/4])
    side();
translate([0,-(dim.y-e)/2,dim.z/4])
    side();
