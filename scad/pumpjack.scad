use <modules/Motor.scad>
use <modules/Pulley.scad>
use <modules/Crank.scad>
use <modules/Pitman.scad>
use <modules/Equalizer.scad>
use <modules/Foot.scad>
use <modules/WalkingBeam.scad>
use <modules/HorseHead.scad>

//$fn = 250;

// Soportes del motor
translate([0,-12,25])
    block(true);
translate([0,16.5,25])
    block(false);

// Poleas
translate([0,8,33])
rotate([90,0,0])
    pulley(true);
translate([0,8,60])
rotate([90,0,0])
    pulley(false);
    
// Manivelas
translate([0,-27,60])
rotate([90,-10,0])
    crank();
translate([0,27,60])
rotate([-90,-10,0])
    crank();
    
// Bielas
translate([27.5,36.5,98])
rotate([90,-4,0])
    pitman();
translate([27.5,-36.5,98])
rotate([90,-4,0])
    pitman();
translate([25,0,73.5+60])
rotate([90,0,90])
    equalizer();
    
// Balancin
translate([-50,0,70+6+60])
rotate([180,0,180])
    beam();

// Cabezal
translate([-125,0,70+60])
rotate([90,0,0])
    horseHead();

// Pie de soporte del balancin
translate([-50,0,0])
    foot();