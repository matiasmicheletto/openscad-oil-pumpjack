const { transforms, primitives, booleans } = require('@jscad/modeling');
const { translate } = transforms;
const { cuboid, cylinder } = primitives;
const { subtract, union, intersect } = booleans;

const arm = params => {
    const {R, H, Lc, r3, msr} = params;
    const Wp = 15; // Arm width
    const e = r3/5; // Arm extension opposite to the counterweight    

    return subtract(
        translate([(R - Lc - msr - e)/2, 0, 0],
            cuboid({size:[R - Lc + msr + e, Wp, H]}),
        ),
        cylinder({radius: msr, height: H})
    );
};

const counterweight = params => {
    const {R, H, Lc} = params;
    const Wc = 50; // Counterweight width (Y)
    
    return intersect(
        cylinder({radius: R, height: H }),
        translate([R-Lc/2, 0, 0],
            cuboid({size:[Lc, Wc, H+1]}),
        )
    );
};

const pitmans_shaft = params => {
    const { H, psr, r3 } = params;    
    const hp = 9.5; // Shaft length
    
    return translate([r3, 0, (hp+H)/2],  
        cylinder({radius: psr-0.1, height:hp})
    );
};

const crank = params => {    
    const p = {
        ...params,
        H: 7,   // Part thickness
        R: 55,  // Crank total radius
        Lc: 20  // Counterweight section
    }

    return union(
        arm(p),
        counterweight(p),
        pitmans_shaft(p) 
    );
};

module.exports = crank;
