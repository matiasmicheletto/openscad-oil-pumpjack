const { primitives, booleans } = require('@jscad/modeling');
const { cylinder } = primitives;
const { subtract } = booleans;

const filler = params => {
    // Fillers for the pitmans arms shafts 

    const re = 6.5;                 // Outer radius
    const ri = params.psr+0.25;     // Inner radius
    const h = 3;                    // Thickness

    return subtract(
        cylinder({radius: re, heigth: h}),
        cylinder({radius: ri, heigth: h})
    );
};

module.exports = filler;
