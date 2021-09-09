module filler(psr){
    /* Fillers for the pitmans arms shafts */

    re = 6.5;       // Outer radius
    ri = psr+0.25;  // Inner radius
    h = 3;          // Thickness
    
    difference(){
        cylinder(r = re, h = h);
        cylinder(r = ri, h = h);
    }
}

filler();