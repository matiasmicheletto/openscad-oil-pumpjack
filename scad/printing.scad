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

module pumpjack(r1=65, r2=75, r3=30, a=60, b=50, c=60, d=65, shr=1.7, msr=2.3, psr=3.5) {
    // Motor blocks
    translate([0, -25, 9])
    rotate([90, 0, 0])
        block(true, shr, msr, c);
    translate([-50, 20, 4.5])
    rotate([90, 0, 180])
        block(false, shr, msr, c);
        
    // Cranks
    translate([5, 50, 3.5])
        crank(r3, msr, psr);
    translate([25, 70, 3.5])
    rotate([0, 0, 180])
        crank(r3, msr, psr);
        
    // Pitmans arms
    translate([50,-50,2.5])
        pitman(d, psr);
    translate([35,-50,2.5])
        pitman(d, psr);

    // Fillers
    translate([0, 87, 0])
        filler(psr);
    translate([20, 87, 0])
        filler(psr);
    translate([40, 87, 0])
        filler(psr);
    translate([60, 87, 0])
        filler(psr);

    // Equalizer
    translate([-20, -50, 3.5])
    rotate([0, 0, 90])
        equalizer(shr, psr);
        
    // Walking beam
    translate([70, 0, 12])
    rotate([180, 0, -90])
        beam(r1, r2, shr, msr);

    // Horse head
    translate([20, -70, 10])
    rotate([0, 0, 90])
        horseHead(r1, shr);

    // Samson post
    translate([85, 80, 7])
    rotate([90, 180, 0])
        foot(a, c, msr, shr);
        
    // Gear box
    translate([-50, 55, 0])
        gear(true);
    translate([0, 10, 0])
        gear(false);
}

pumpjack(65, 75, 30, 60, 50, 60, 65, 1.7, 2.3, 3.5);