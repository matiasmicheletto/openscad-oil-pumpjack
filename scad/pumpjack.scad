use <modules/Motor.scad>
use <modules/Pulley.scad>
use <modules/Crank.scad>
use <modules/Pitman.scad>
use <modules/WalkingBeam.scad>
use <modules/HorseHead.scad>

$fn = 250;

// Soportes del motor
translate([0,-20,0])
    block(true);
translate([0,10,0])
    block(false);

// Poleas
translate([0,0,8])
rotate([90,0,0])
    pulley(true);
translate([0,0,35])
rotate([90,0,0])
    pulley(false);
    
// Manivelas
translate([0,-35,35])
rotate([90,0,0])
    crank();
translate([0,20,35])
rotate([-90,0,0])
    crank();
    
// Bielas
translate([14,30,70])
rotate([90,-45,0])
    pitman();
translate([14,-45,70])
rotate([90,-45,0])
    pitman();
translate([-21,-7,109])
rotate([90,0,90])
    equalizer();
    
// Brazo superior
translate([-80,-7,115])
rotate([180,0,0])
    beam();

// Cabezal
translate([-150,-7,107.5])
rotate([90,0,0])
    horseHead();