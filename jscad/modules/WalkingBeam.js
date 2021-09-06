const { transforms, primitives, booleans } = require('@jscad/modeling');
const { translate } = transforms;
const { cuboid, cylinder } = primitives;
const { subtract, union } = booleans;
const { rotate } = require('../helpers');

const beam = params => {
    
    // The walking beam acts as a class I lever transferring the movement from the pitmans arms to the horse head.

    const {r1, r2, shr, msr} = params;

    const e = 10;                   // Total added extension (beyond mounting points)
    const dims = [r1+r2+e,10,12];   // Walking beam dimensions        
    const sor = 5;                  // Shaft outer radius    
    const d = -5;                   // Side displacement
    
    return subtract(
        union(
            // Walking beam body
            translate([d, 0, 0],
                cuboid({size:dims})),
            
            // Fulcrum or pivoting point
            translate([0, 0, dims[2]/2],
                rotate([90, 0, 0],
                    cylinder({radius: sor, height: dims[1]})))
        ),
        
        // Pivoting point hole
        translate([0, 0, dims[2]/2],
            rotate([90, 0, 0],
                cylinder({radius: msr, height: dims[1]+1}))),
        
        // Equalizer mounting screw hole
        translate([-r1, 0, 0],
            cylinder({radius: shr, height: dims[2]+1})),
        
        // Horse head screw hole
        translate([r2, 0, 0],
            rotate([90, 0, 0],
                cylinder({radius: shr, height: dims[1]+1})))
    )
};

module.exports = beam;