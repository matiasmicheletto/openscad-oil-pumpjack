const { transforms, primitives, booleans, extrusions } = require('@jscad/modeling');
const { translate } = transforms;
const { cuboid, cylinder, circle, polygon } = primitives;
const { subtract, union, intersect } = booleans;
const { extrudeLinear } = extrusions;

const head = params => {
    // The horse head is placed at the end of the walking beam and is responsible for the mechanical transmission of the movement to the piston in the underground pump.

    const W = 12;     // Width (X) 
    const R = params.r1+W;   // Rotation radius

    const L = 70;     // Length (Y)
    const H = 20;     // Piece thickness (Z)
    const a = 6;      // Base
    const b = 5;      // Height

    const { shr } = params;

    // Coupling displacement
    const delta = 6;

    // Shape polygon
    const poly = [[0,-L/2],
            [W+2,-L/2],
            [W+a,b-L/2],
            [W+a,L/2-b],
            [W+2,L/2],
            [0,L/2]];
            
    const coupling_peg = () => {
        // Walking beam coupling peg
        const a1 = 12.5;  // Width (Y)
        const b1 = 10.5;  // Length (Z)        

        return union(
            translate([(a-W)/2+5, 0, H/2],
                cuboid({size:[W+a,a1,b1]})),
            translate([0, 0, H/2],
                cylinder({radius: shr, height: H}))
        );
    };

    return translate([0, 0, -H/2],
            subtract(
                extrudeLinear({height: H},
                    intersect(
                        translate([R-W, -delta, 0],
                            circle({radius:R})),
                        translate([-W, -delta, 0],
                            polygon( {points:poly} ))
                    )),
                coupling_peg()
            )
    );
};

module.exports = head;