const { transforms, primitives, booleans } = require('@jscad/modeling');
const { translate } = transforms;
const { cuboid, cylinder } = primitives;
const { subtract, union } = booleans;

const pitman = params => {
    /* The pitman's arms are responsible for converting
    the circular movement from the cranks to the linear 
    movement of the walking beam*/

    const d = params.d; // Arm length
    const W = 13; // Arm width
    const H = 5; // Arm thickness

    const rh = params.psr+0.25;

    return subtract(
        union(
            translate([0,d/2,0],
                cuboid({size:[W-2, d, H]})),
            
            cylinder({radius:W/2, height:H}),
            
            translate([0,d,0],
                cylinder({radius:W/2, height:H}))
        ),        
        cylinder({radius:rh, height:H}),
        
        translate([0,d,0],
            cylinder({radius:rh, height:H}))
    );
};

module.exports = pitman;
