const { transforms, primitives, booleans } = require('@jscad/modeling');
const { translate } = transforms;
const { cuboid, cylinder } = primitives;
const { subtract, union } = booleans;
const { rotate } = require('../helpers');

const beam = params => {
    
    // The walking beam acts as a class I lever transferring the movement from the pitmans arms to the horse head.

    const {r1, r2, shr, msr} = params;
    
    const H = 12;                   // Body height
    const W = 10;                   // Body width    
    const e = 10;                   // Total added extension (beyond mounting points)    

    return subtract(
        union(
            // Walking beam body
            translate([(r2-r1)/2, 0, H/2],
                cuboid({size:[r1+r2+e, W, H]})),
            
            // Fulcrum or pivoting point
            rotate([90, 0, 0],
                cylinder({radius: 2*msr, height: W}))
        ),
        
        // Pivoting point hole        
        rotate([90, 0, 0],
            cylinder({radius: msr, height: W+1})),
        
        // Equalizer mounting screw hole
        translate([r2, 0, H/2],
            cylinder({radius: shr, height: H+1})),
        
        // Horse head screw hole
        translate([-r1, 0, H/2],
            rotate([90, 0, 0],
                cylinder({radius: shr, height: W+1})))
    )
};

module.exports = beam;