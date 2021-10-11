use <modules/Motor.scad>
use <modules/Gear.scad>
use <modules/Crank.scad>
use <modules/Pitman.scad>
use <modules/Equalizer.scad>
use <modules/Foot.scad>
use <modules/WalkingBeam.scad>
use <modules/HorseHead.scad>
use <modules/Filler.scad>

$fn = 100;

module pumpjack(t, type=1, r1=65, r2=75, r3=30, a=60, b=50, c=60, d=65, shr=1.7, msr=2.3, psr=3.5) {
    
    side = type==1 ? 1 : -1; // Inversion of sign for values of r3 and b
    
    // Parameters for compute the angles of moving parts
    p = side*(r3*cos(t) + b);
    q = -side*r3*sin(t) - a;
    k = (p*p + q*q + r2*r2 - d*d)/2/r2;
    denom = sqrt(p*p + q*q);    
    
    // Walking beam angle
    wba = (type==1 ? 270:90) + side*(asin(k/denom) - asin(q/denom));     
    
    B = [-side*b, 0, a + c]; // Walking beam pivoting point
    C = [side*(r2*cos(wba) - b), 0, a + c - side*r2*sin(wba)]; // Equalizer position
    D = [side*r3*cos(t), 0, c - side*r3*sin(t)]; // Crank shaft position

    // Pitmans arms angle (angle between equalizer and crank shaft)
    pma = atan2(C.x - D.x, C.z - D.z); 

    // Motor blocks
    translate([0, -12, c])
        block(true, shr, msr, c);
    translate([0, 16.5, c])
        block(false, shr, msr, c);

    // Gear box
    translate([0, 8, c-28])
    rotate([90, -t/2, 0])
        gear(true);
    translate([0, 8, c])
    rotate([90, t, 0])
        gear(false);
        
    // Cranks
    translate([0, -28, c])
    rotate([90, t,0])
        crank(r3, msr, psr, type);
    translate([0, 28, c])
    rotate([-90, t, 0])
        crank(r3, msr, psr, type);
    
    // Fillers
    translate([C.x, 34, C.z])
    rotate([90,0,0])
        filler(psr);
    translate([C.x, -34, C.z])
    rotate([90,0,0])
        filler(psr);
    translate([D.x, 34, D.z])
    rotate([90,0,0])
        filler(psr);
    translate([D.x, -34, D.z])
    rotate([90,0,0])
        filler(psr);
    
    // Pitmans arms
    translate([D.x, 38, D.z])
    rotate([90, pma, 0])
        pitman(d, psr);
    translate([D.x, -38, D.z])
    rotate([90, pma, 0])
        pitman(d, psr);
    
    // Equalizer
    translate(C)
    rotate([0, wba, 0])
        equalizer(shr, psr);
        
    // Walking beam and horse head
    translate(B)
    rotate([0, wba, 0])
        union(){
            beam(r1, r2, shr, msr, type);
            translate([type == 1 ? -r1:-r1-r2, 0, 6])
            rotate([90, 0, 0])
                horseHead(type == 1 ? r1:r1+r2, shr); 
        }
    
    // Samson post
    translate([B.x, 0, 0])
    rotate([0,0,type==1 ? 0: 180])
        foot(a, c, msr, shr);
}

// Conventional
translate([0,50,0])
    pumpjack(360*$t, 1, 65, 75, 30, 60, 50, 60, 65, 1.7, 2.3, 3.5);
// Mark II
translate([0,-50,0])
    pumpjack(360*$t, 2, 30, 80, 20, 60, 50, 60, 65, 1.7, 2.3, 3.5);