
module beam(){
    a = [100,10,15];     // Barra
    rh = 2.3;           // Radio orificio para ajuste
    b = [2*rh+2, 2];    // Dims ajuste
    
    module side(){
        difference(){
            union(){ // Envolvente rectangular con terminacion circular
                cube([b.x, b.y, 3*a.z/2], center = true);
                
                translate([0, 0, 3*a.z/4])
                rotate([90, 0, 0])
                    cylinder(r = b.x/2, h = b.y, center = true);
            }        
            translate([0, 0, 3*a.z/4])
            rotate([90, 0, 0])
                cylinder(r = rh, h = b.y+1, center = true);
        }
    }

    
    
    difference(){
        union(){
            cube(a, center = true);

            translate([0, (a.y - b.y)/2, a.z/4])
                side();
            translate([0, -(a.y - b.y)/2, a.z/4])
                side();
        }
        
        translate([(a.x)/2-rh-2,0,0])
            cylinder(r = rh, h = a.z+1, center = true);
        
        translate([-(a.x)/2+rh+2,0,0])
        rotate([90,0,0])
            cylinder(r = rh, h = a.y+1, center = true);
    }
}

beam();