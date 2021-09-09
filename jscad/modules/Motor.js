const { transforms, primitives, booleans } = require('@jscad/modeling');
const { translate } = transforms;
const { cuboid, cylinder } = primitives;
const { subtract, union } = booleans;
const { rotate } = require('../helpers');


const block = params => {
    // A block to hold the stepper motor

    const {shr, msr, motor, c} = params;
    
    const es = 15;      // Excentricity of the shaft hole
    const L = 45;       // Length (X)    
    const W = motor ? 18 : 9; // Width (Y)
    const hh = 5;       // Mounting base height
    const H = c-es-hh;  // Height (Z)
    
    const envelope = () => {        
        return union(
            cuboid({size:[L, W, H], center:[0,0,-H/2-es]}),
            
            // Rounded top
            translate([0,0,-es],
                rotate([90,0,0],
                    cylinder({radius: L/2, height: W, segments: 50}))),
            
            // Mounting base
            cuboid({size:[L + 8*shr, W, hh], center: [0,0,-H-hh/2-es]}) 
        );
    };
    
    const motor_hole = () => {
        const Rm = 14 + 0.1;    // Motor radius
        const d2 = 35;          // Distance between screw holes
        
        // Motor cable cover
        const wc1 = 3 + 0.2;
        const lc1 = 17 + 0.2;
        const xc1 = Math.sqrt(Rm*Rm-lc1*lc1/4)+wc1/2;
        const wc2 = 5 + 0.2;
        const lc2 = 14.5 + 0.2;
        const xc2 = Math.sqrt(Rm*Rm-lc2*lc2/4)+wc2/2;
        const wc3 = 7;
        const lc3 = 6;
        const xc3 = Math.sqrt(Rm*Rm-lc3*lc3/4)+wc3/2;
            
        return union(
                translate([0,0,-H/2-es],
                    rotate([90,0,0],
                        cylinder({radius: Rm, height: W+0.2}))),
                   
                // Motor screw holes
                translate([-d2/2,0,-H/2-es],
                    rotate([90,0,0],
                        cylinder({radius: shr, height: W}))),
                translate([d2/2,0,-H/2-es],
                    rotate([90,0,0],
                        cylinder({radius: shr, height: W}))),
                
                // Motor cable cover
                cuboid({size:[lc1, W, wc1], center: [0,0,-xc1-H/2-es]}),
                cuboid({size:[lc2, W, wc2], center: [0,0,-xc2-H/2-es]}),
                cuboid({size:[lc3, W, wc3], center: [0,0,-xc3-H/2-es]}),   
        );
    };
    
    const shaft_hole = () => {        
        return rotate([90, 0, 0],
            cylinder({radius: msr+0.7, height: W})
        );
    };
    
    const screw_holes = () => {        
        return union(
            cylinder({radius: shr, height: hh, center: [-L/2-2*shr, 0, -H-hh/2-es]}),
            cylinder({radius: shr, height: hh, center: [ L/2+2*shr, 0, -H-hh/2-es]})
        );
    };    

    return subtract(
        envelope(),
        motor ? motor_hole():cuboid(),
        shaft_hole(),
        screw_holes()
    );    
};

module.exports = block;