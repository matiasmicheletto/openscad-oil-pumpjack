const { transforms, primitives, booleans, extrusions } = require('@jscad/modeling');
const { translate } = transforms;
const { cuboid, cylinder, circle } = primitives;
const { subtract, intersect } = booleans;
const { extrudeRotate } = extrusions;
const { sin, cos } = require('../helpers');

const pulley = params => {
    const S = 30;   // Number of segments

    const H = 6;                          // Pulley thickness
    const Rp = 2;                         // Groove radius
    const R = (params.motor ? 15 : 7)+Rp; // Outer radius

    const Ra = 2.50;                      // Shaft radius
    const Rb = 1.55;                      // 

    // Holes
    const Nh = 6;                               // Number
    const Rh = params.motor ? 3 : 1;            // Radius 
    const Dh = (params.motor ? R-Rp : R)/2+1;   // Distance from center

    const Di = 2;                         // Inner border
    const De = params.motor ? 4 : 2.5;    // Outer border
    const e = 5;                          // Depth

    const holes = () => {
        let holes = [];
        for(let angle = 0; angle < 360; angle += 360/Nh)
            holes.push(cylinder({
                radius: Rh, 
                height: H, 
                center:[Dh*sin(angle), Dh*cos(angle), H/2]
            }));
        return holes;
    }

    return subtract(
        cylinder({ // Envelope
            radius: R, 
            height: H, 
            center:[0,0,H/2], 
            segments:S
        }),

        params.motor?
            intersect( // Motor shaft
                cylinder({radius: Ra, height: H, center:[0, 0, H/2]}),
                cuboid({size:[Rb*2, Ra*2, H], center:[0, 0, H/2]})
            )
        :
            cylinder({radius: Ra, height: H, center:[0,0,H/2]}), // Simple round shaft
        

        // Pulley groove
        extrudeRotate({segments: S},
            translate([R, H/2, 0], circle({radius: Rp}))),  

        // Orificios
        holes(),

        // Ahuecamiento superior
        translate([0,0,H],
            subtract(
                cylinder({radius: R-De, height: e}),
                cylinder({radius: Ra+Di, height: e})
            )
        )
    );
}

module.exports = pulley;