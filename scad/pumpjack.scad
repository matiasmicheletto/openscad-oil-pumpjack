use <modules/Motor.scad>
use <modules/Gear.scad>
use <modules/Crank.scad>
use <modules/Pitman.scad>
use <modules/Equalizer.scad>
use <modules/Foot.scad>
use <modules/WalkingBeam.scad>
use <modules/HorseHead.scad>
use <modules/Filler.scad>

module pumpjack() {
    // Motor blocks
    translate([0,-12,25])
        block(true);
    translate([0,16.5,25])
        block(false);

    // Gear box
    translate([0,8,33])
    rotate([90,0,0])
        gear(true);
    translate([0,8,60])
    rotate([90,0,0])
        gear(false);
        
    // Cranks
    translate([0,-28,60])
    rotate([90,-10,0])
        crank();
    translate([0,28,60])
    rotate([-90,-10,0])
        crank();
    
    // Fillers
    translate([25.5,34,131])
    rotate([90,0,0])
        filler();
    translate([25.5,-31,131])
    rotate([90,0,0])
        filler();
    translate([30,35,65])
    rotate([90,0,0])
        filler();
    translate([30,-32,65])
    rotate([90,0,0])
        filler();
    
    // Pitmans arms
    translate([27.5,38,98])
    rotate([90,-4,0])
        pitman();
    translate([27.5,-38,98])
    rotate([90,-4,0])
        pitman();
    
    // Equalizer
    translate([25,0,73.5+60])
    rotate([90,0,90])
        equalizer();
        
    // Walking beam
    translate([-50,0,70+6+60])
    rotate([180,0,180])
        beam();

    // Horse head
    translate([-125,0,70+60])
    rotate([90,0,0])
        horseHead();

    // Samson post
    translate([-50,0,0])
        foot();
}

pumpjack();