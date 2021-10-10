const { primitives, booleans } = require('@jscad/modeling');
const { cuboid, cylinder } = primitives;
const { subtract, union, intersect } = booleans;

const crank = params => {      
    /* The crank is the part that transfers the motor torque to 
    the walking beam. It is composed of an arm and a counterweight. */

    const { r3, msr, psr } = params;

    const R = r3*11/6;  // Crank total radius
    const H = 7;        // Part thickness        
    const Lc = 20;      // Counterweight section

    const arm = () => {
        const Wp = 15;  // Arm width
        const e = r3/5; // Arm extension opposite to the counterweight    
    
        return subtract(
            cuboid({size:[R - Lc + msr + e, Wp, H], center: [(R - Lc - msr - e)/2, 0, 0]}),
            cylinder({radius: msr, height: H})
        );
    };
    
    const counterweight = () => {        
        const Wc = 50; // Counterweight width (Y)
        
        return intersect(
            cylinder({radius: R, height: H, segments: 100 }),
            cuboid({size:[Lc, Wc, H+1], center:[R-Lc/2, 0, 0]}),
        );
    };
    
    const pitmans_shaft = () => {        
        const hp = 11; // Shaft length
        
        return cylinder({
            radius: psr-0.1, 
            height:hp, 
            center:[r3, 0, (hp+H)/2]
        });
    };

    return union(
        arm(),
        counterweight(),
        pitmans_shaft() 
    );
};

module.exports = crank;
