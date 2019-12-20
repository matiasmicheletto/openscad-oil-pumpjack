
module filler(){
    re = 6.5;
    ri = 3.75;
    h = 3;
    
    difference(){
        cylinder(r = re, h = h);
        cylinder(r = ri, h = h);
    }
}

//$fn = 250;
filler();