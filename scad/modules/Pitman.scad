module pitman(d, psr){
    /* The pitman's arms are responsible for converting
    the circular movement from the cranks to the linear 
    movement of the walking beam*/

    W = 13;
    H = 5;
    rh = psr+0.25;
    
    difference(){
        union(){
            translate([0, d/2, 0])
                cube([W-2, d, H], center = true);
            // Semicircular endings            
            cylinder(r = W/2, h = H, center = true);
            translate([0, d, 0])
                cylinder(r = W/2, h = H, center = true);
        }
        cylinder(r = rh, h = H, center = true);
        
        translate([0, d, 0])
            cylinder(r = rh, h = H, center = true);
    }
}

rotate([0,0,90])
    pitman(65, 3.5);
translate([0,20,0])
rotate([0,0,90])
    pitman(65, 3.5);
