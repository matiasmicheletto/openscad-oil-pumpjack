const { transforms, primitives, booleans } = require('@jscad/modeling');
const { translate } = transforms;
const { cuboid, cylinder } = primitives;
const { subtract, union } = booleans;
const { rotate } = require('../helpers');

const envelope = params => {
    const {W,L,H,hh,ww} = params;
    return union(
        cuboid({size:[W,L,H]}), // Envelope        
        
        // Rounded top
        translate([0,0,H/2],
            rotate([90,0,0],
                cylinder({radius: W/2, height: L}))),
        
        // Mounting base
        translate([0,0,-H/2-hh/2],
            cuboid({size:[W + ww, L, hh]})) 
    );
};

const motor_hole = params => {
    const {L, r2} = params;

    const Rm = 14 + 0.1;    // Motor radius
    const d2 = 35;          // Distance between screw holes
    
    // Motor cable cover
    const wc1 = 3 + 0.2;
    const lc1 = 17 + 0.2;
    const xc1 = Math.sqrt(Rm*Rm-lc1*lc1/4)+wc1/2;
    const wc2 = 5 + 0.2;
    const lc2 = 14.5 + 0.2;
    const xc2 = Math.sqrt(Rm*Rm-lc2*lc2/4)+wc2/2;
    const wc3 = 7;
    const lc3 = 6;
    const xc3 = Math.sqrt(Rm*Rm-lc3*lc3/4)+wc3/2;
        
    return union(
            rotate([90,0,0],
                cylinder({radius: Rm, height: L+0.2})),
               
            // Motor screw holes
            translate([-d2/2,0,0],
                rotate([90,0,0],
                    cylinder({radius: r2, height: L}))),
            translate([d2/2,0,0],
                rotate([90,0,0],
                    cylinder({radius: r2, height: L}))),
            
            // Motor cable cover
            translate([0,0,-xc1],
                cuboid({size:[lc1,L,wc1]})),
            translate([0,0,-xc2],
                cuboid({size:[lc2,L,wc2]})),
            translate([0,0,-xc3],
                cuboid({size:[lc3,L,wc3]})),   
    );
};

const shaft_hole = params => {
    const {H, Rs, L, es} = params;
    return translate([0, 0, H/2+es],
        rotate([90, 0, 0],
            cylinder({radius: Rs, height: L}))
    );
};

const screw_holes = params => {
    const {W, ww, H, hh, r2} = params;
    return union(
        translate([-W/2-ww/4, 0, -H/2-hh/2],
            cylinder({radius: r2, height: hh})),
        translate([W/2+ww/4, 0, -H/2-hh/2],
            cylinder({radius: r2, height: hh}))
    );
};

const block = params => {
    // A block to hold the stepper motor

    // Outer dimensions
    const p = {
        ...params,
        W: 45,     // Width (X)    
        L: params.motor ? 18 : 9, // Length (Y)
        H: 40,     // Height (Z)
        ww: 14,    // Mounting width
        hh: 5,     // Mounting height
        Rs: 3,     // Shaft radius
        es: 15,    // Excentricity of the shaft hole
        r2: 1.7,   // Screw hole radius
    }

    return subtract(
        envelope(p),
        p.motor ? motor_hole(p) : cuboid(),
        shaft_hole(p),
        screw_holes(p)
    );
};

module.exports = block;
