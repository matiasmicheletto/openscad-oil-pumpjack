const { transforms, primitives, booleans } = require('@jscad/modeling');
const { translate } = transforms;
const { cuboid, cylinder } = primitives;
const { subtract, union } = booleans;
const { rotate } = require('../helpers');

const equalizer = params => {
    /* The equalizer is attached to the walking beam and transfers
    the power from the pitmans arms to it. Its length should match 
    the separation between the cranks. */

    const { shr, psr } = params;
    
    const shl = 11; // Side shafts length

    const L = 85;   // Part total length (Y)
    const W = 7.5;  // Part width (X)
    
    const h = 10;   // walking beam peg height (Z)    
    const w = 10;   // Walking beam width (Y)
    
    const br = h-psr;   // Rounder border radius

    const rnd_border = {
        radius: br, 
        height: W
    }
    
    const side_shaft = () => {
        return rotate([90, 0, 0],
            cylinder({radius: psr-0.1, height: shl}));
    };

    const body = () => union(
        cuboid({size:[W, L-2*shl, 2*psr]}),
        
        cuboid({size:[W, L-2*shl-2*br, br], center:[0, 0, br/2+psr]}),
        
        translate([0, shl-L/2+br, psr],
            rotate([0,90,0],
                cylinder(rnd_border))),
        translate([0, L/2-shl-br, psr],
            rotate([0, 90, 0],
                cylinder(rnd_border))),

        translate([0, (L-shl)/2,0], side_shaft()),
            
        translate([0, (shl-L)/2,0], side_shaft())                
    );
    
    return subtract(
        body(),
        // Walking beam peg
        cuboid({size:[w, W, h], center:[0, 0, h/2]}),
        // Screw hole
        cylinder({radius: shr, height: psr, center:[0, 0, -psr/2]})
    );
};

module.exports = equalizer;