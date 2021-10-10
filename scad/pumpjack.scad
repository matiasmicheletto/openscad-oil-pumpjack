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

module pumpjack(t, type=1, r1=65, r2=75, r3=30, a=60, b=50, c=60, d=65, shr=1.7, msr=2.3, psr=3.5) {

    // The following functions allows to determine the angles of the walking beam
    // and pitmans arms depending on the current crank angle "t"
    function get_wba(k, q, denom) = 270 + asin(k/denom) - asin(q/denom);
    function get_pma(a, b) = atan2(a.x - b.x, a.y - b.y);

    // Parameters for compute the angles of moving parts
    p = r3*cos(-t) + (type == 1 ? 1 : -1)*b;
    q = r3*sin(-t) - a;
    k = (p*p + q*q + r2*r2 - d*d)/2/r2;
    denom = sqrt(p*p + q*q);    
    
    wba = get_wba(k, q, denom); // Walking beam angle
    
    // Horse head position 
    ax = type == 1 ? -b-r1*cos(wba) : b-(r1+r2)*cos(wba);
    az = a + c + (type == 1 ?r1:r1+r2)*sin(wba)+6;
    // Equalizer position
    cx = (type == 1 ? 1 : -1)*(r2*cos(wba) - b);
    cz = a + c - (type == 1 ? 1 : -1)*r2*sin(wba);
    // Crank shaft position
    dx = (type == 1 ? 1 : -1)*r3*cos(t);
    dz = c - (type == 1 ? 1 : -1)*r3*sin(t);
    
    // Pitmans arms angle
    pma = get_pma([cx, cz], [dx, dz]);

    A = [ax, 0, az]; // Horse head position    
    B = [type==1 ? -b : b, 0, a + c]; // Walking beam pivoting point
    C =  [cx, 0, cz]; // Equalizer position
    D = [dx, 0, dz]; // Crank shaft position

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
        beam(r1, r2, shr, msr, type);

    // Horse head
    translate(A)
    rotate([90, wba, 0])
        horseHead(r1, shr);

    // Samson post
    translate([B[0], 0, 0])
        foot(a, c, msr, shr);
}

pumpjack(360*$t, 1, 65, 75, 30, 60, 50, 60, 65, 1.7, 2.3, 3.5);