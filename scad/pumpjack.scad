use <modules/Motor.scad>
use <modules/Gear.scad>
use <modules/Crank.scad>
use <modules/Pitman.scad>
use <modules/Equalizer.scad>
use <modules/Foot.scad>
use <modules/WalkingBeam.scad>
use <modules/HorseHead.scad>
use <modules/Filler.scad>

$fn = 50;

module pumpjack(t, r1=65, r2=75, r3=30, a=60, b=50, c=60, d=65, shr=1.7, msr=2.3, psr=3.5) {

    // The following functions allows to determine the angles of the walking beam
    // and pitmans arms depending on the current crank angle "t"
    function get_wba(k, q, denom) = 270 + asin(k/denom) - asin(q/denom);
    function get_pma(a, b) = atan2(a.x-b.x, a.y-b.y);

    // Parameters for compute the angles of moving parts
    p = r3*cos(-t) + b;
    q = r3*sin(-t) - a;
    k = (p*p + q*q + r2*r2 - d*d)/2/r2;
    denom = sqrt(p*p+q*q);    

    // Walking beam angle
    wba = get_wba(k, q, denom);
    // Pitmans arms angle
    pma = get_pma([r2*cos(wba)-b, a + c - r2*sin(wba)], [r3*cos(t), c - r3*sin(t)]);

    B = [-b, 0, a+c]; // Walking beam pivoting point
    A = [-b-r1*cos(wba), 0, B.z + r1*sin(wba)+6]; // Horse head position    
    C = [r2*cos(wba)-b, 0, B.z - r2*sin(wba)]; // Equalizer position
    D = [r3*cos(t), 0, c - r3*sin(t)]; // Crank end position   

    // Motor blocks
    translate([0, -12, c])
        block(true, shr, msr, c);
    translate([0, 16.5, c])
        block(false, shr, msr, c);

    // Gear box
    translate([0, 8, c-35])
    rotate([90, -t/3, 0])
        gear(true);
    translate([0, 8, c])
    rotate([90, t, 0])
        gear(false);
        
    // Cranks
    translate([0, -28, c])
    rotate([90, t,0])
        crank(r3, msr, psr);
    translate([0, 28, c])
    rotate([-90, t, 0])
        crank(r3, msr, psr);
    
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
    translate([D[0], 38, D[2]])
    rotate([90, pma, 0])
        pitman(d, psr);
    translate([D[0], -38, D[2]])
    rotate([90, pma, 0])
        pitman(d, psr);
    
    // Equalizer
    translate(C)
    rotate([0, wba, 0])
        equalizer(shr, psr);
        
    // Walking beam
    translate(B)
    rotate([0, wba, 0])
        beam(r1, r2, shr, msr);

    // Horse head
    translate(A)
    rotate([90, wba, 0])
        horseHead(r1, shr);

    // Samson post
    translate([-b, 0, 0])
        foot(a, c, msr, shr);
}

pumpjack(360*$t, 65, 75, 30, 60, 50, 60, 65, 1.7, 2.3, 3.5);