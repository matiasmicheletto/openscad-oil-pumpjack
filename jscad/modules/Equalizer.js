const { transforms, primitives, booleans } = require('@jscad/modeling');
const { translate, rotate } = transforms;
const { cuboid, cylinder } = primitives;
const { subtract, union } = booleans;

const equalizer = params => {
    const { shr, psr } = params;
    const eq = [62,15,7]; // Equalizer dimensions (x,y,z)
    const bm = [10,10];   // Walking beam coupling section
    const h = 13;         // Side shafts length
    const side_shaft = {
        radius: psr-0.1, 
        height: h
    }
    
    return subtract(
        union(
            translate([0,-eq[1]/4,0],
                cuboid({size:[eq[0],eq[1]/2,eq[2]]})),
            translate([0,eq[1]/4,0],
                cuboid({size:[eq[0]-eq[1],eq[1]/2,eq[2]]})),
            translate([eq[0]/2-eq[1]/2,0,0],
                cylinder({radius: eq[1]/2, height: eq[2]})),
            translate([-eq[0]/2+eq[1]/2,0,0],
                cylinder({radius: eq[1]/2, height: eq[2]})),
            translate([(eq[0]+h)/2,-psr,0],
                rotate([0,Math.PI/2,0],
                    cylinder(side_shaft))),
            translate([-(eq[0]+h)/2,-psr,0],
                rotate([0,Math.PI/2,0],
                    cylinder(side_shaft))),
        ),
        
        // Walking beam peg
        translate([0,(eq[1]-bm[1])/2,0],
            cuboid({size:[bm[0],bm[1],eq[2]]})),
        // Screw hole
        rotate([Math.PI/2,0,0],
            cylinder({radius: shr, height: eq[1]}))
    );
};

module.exports = equalizer;