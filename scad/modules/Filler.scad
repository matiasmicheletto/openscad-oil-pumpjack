module filler(){
    /* Fillers for the pitmans arms shafts */

    re = 6.5;  // Outer radius
    ri = 3.75; // Inner radius
    h = 3;     // Thickness
    
    difference(){
        cylinder(r = re, h = h);
        cylinder(r = ri, h = h);
    }
}

filler();