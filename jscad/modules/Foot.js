const { transforms, primitives, booleans } = require('@jscad/modeling');
const { translate } = transforms;
const { cuboid, cylinder } = primitives;
const { subtract, union } = booleans;
const { rotate } = require('../helpers');

const foot = params => {
    // This is the model for the samson post that holds the center of the walking beam in its place

    const {msr, shr} = params;
    const sp = [7,14,130];     // Samson post
    const lf = [20.5,14,5];    // Long horizontal foot
    const sf = [12,14,5];      // Short horizontal foot    
    const sor = 5;            // Mounting point outer radius

    return subtract(
        union(
            translate([0, 0, sp[2]/2], 
                cuboid({size:sp})),
            translate([lf[0]/2, 0, lf[2]/2], 
                cuboid({size:lf})),
            translate([-sf[0]/2, 0, sf[2]/2], 
                cuboid({size:sf})),
            
            // Mounting point
            translate([0, 0, sp[2]],
                rotate([90, 0, 0],
                    cylinder({radius: sor, height: sp[1]}))),
            
            // Foot reinforcement
            translate([0, 0, sor],
                rotate([90, 0, 0],
                    cylinder({radius: sor, height: sp[1]})))
        ),

        // Mounting point peg
        translate([0, 0, sp[2]], 
            cuboid({size:[2*sor, 10, 2*sor]})),
        
        // Mounting point hole
        translate([0, 0, sp[2]],
            rotate([90, 0, 0],
                cylinder({radius: msr, height: sp[1]+1}))),
        
        // Ground screw holes
        translate([lf[0]-shr-2, 0, lf[2]/2],
            cylinder({radius: shr, height: lf[2]})),
        translate([-sf[0]+shr+2, 0, lf[2]/2],
            cylinder({radius: shr, height: sf[2]}))
    );
};

module.exports = foot;
