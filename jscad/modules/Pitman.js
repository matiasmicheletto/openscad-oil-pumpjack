const { transforms, primitives, booleans } = require('@jscad/modeling');
const { translate } = transforms;
const { cuboid, cylinder } = primitives;
const { subtract, union } = booleans;

const pitman = () => {
    // This is the model for the samson post that holds the center of the walking beam in its place

    const pt = [13, 65, 5];
    const rh = 3.75;

    return subtract(
        union(
            translate([0,pt[1]/2,0],
                cuboid({size:pt})),
            
            cylinder({radius:pt[0]/2, height:pt[2]}),
            
            translate([0,pt[1],0],
                cylinder({radius:pt[0]/2, height:pt[2]}))
        ),        
        cylinder({radius:rh, height:pt[2]}),
        
        translate([0,pt[1],0],
            cylinder({radius:rh, height:pt[2]}))
    );
};

module.exports = pitman;
