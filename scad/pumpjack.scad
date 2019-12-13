use <modules/Motor.scad>
use <modules/Pulley.scad>
use <modules/Crank.scad>
use <modules/Pitman.scad>
use <modules/WalkingBeam.scad>
use <modules/HorseHead.scad>

//$fn = 250;

// Soportes del motor
translate([0,-20,0])
    block(true);
translate([0,8.5,0])
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
translate([0,18.5,35])
rotate([-90,0,0])
    crank();
    
// Bielas
translate([5,28.5,60])
rotate([90,-45,0])
    pitman();
translate([5,-45,60])
rotate([90,-45,0])
    pitman();
translate([25,-7,70])
rotate([90,0,90])
    equalizer();
    
// Balancin
translate([-55,-7,70+7.5])
rotate([180,0,0])
    beam();

// Cabezal
translate([-135,-7,70])
rotate([90,0,0])
    horseHead();