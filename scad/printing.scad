use <modules/Motor.scad>
use <modules/Pulley.scad>
use <modules/Crank.scad>
use <modules/Pitman.scad>
use <modules/Equalizer.scad>
use <modules/Foot.scad>
use <modules/WalkingBeam.scad>
use <modules/HorseHead.scad>
use <modules/Filler.scad>

//$fn = 250;

// Soportes del motor
translate([25,10,9])
rotate([90,0,0])
    block(true);
translate([-25,-10,4.5])
rotate([90,0,180])
    block(false);
    
// Manivelas
translate([25,50,3.5])
    crank();
translate([45,70,3.5])
rotate([0,0,180])
    crank();
    
// Bielas
translate([55,-20,2.5])
    pitman();
translate([70,-20,2.5])
    pitman();

// Arandelas de relleno
translate([20,87,0])
    filler();
translate([40,87,0])
    filler();
translate([60,87,0])
    filler();
translate([80,87,0])
    filler();

// Ecualizador
translate([0,-50,3.5])
    equalizer();
    
// Balancin
translate([90,0,6])
rotate([0,0,90])
    beam();

// Cabezal
translate([40,-80,10])
rotate([0,0,90])
    horseHead();

// Pie de soporte del balancin
translate([105,80,6])
rotate([90,180,0])
    foot();
    
// Poleas
translate([-30,55,0])
    pulley(true);
translate([25,10,0])
    pulley(false);
