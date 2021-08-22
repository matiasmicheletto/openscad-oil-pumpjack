const { transforms, primitives, booleans } = require('@jscad/modeling')

const { translate } = transforms // https://openjscad.xyz/docs/module-modeling_transforms.html

const { cuboid, cylinder } = primitives // https://openjscad.xyz/docs/module-modeling_primitives.html
const  cube = cuboid // in jscad cube is just cube (w=h=l)

const { subtract, union, intersect } = booleans // https://openjscad.xyz/docs/module-modeling_booleans.html
const difference = subtract
const intersection = intersect

function crank(){
    H = 7;    // Altura de la palanca (Z)
    // Contrapesa
    R = 55;    // Largo total de la palanca (X)
    Wc = 50;    // Ancho de contrapesa (Y)
    Lc = 20;    // Seccion de contrapesa (X)
    // Palanca 
    Wp = 15;    // Ancho del brazo de la  palanca
    e = 6;     // Sobresaliente opuesta a la contrapesa
    // Orificios para ejes
    rh1 = 2.3;  // Radio orificio eje central
    rh2 = 3.5;  // Radio eje biela
    hp = 12.5; // Altura eje de biela
    dh12 = 30;  // Separacion entre orificio central y eje biela

    return difference(
        union(
            // Contrapesa
            intersection(
                cylinder({radius: R, height: H }),// primitieves are centered by default in jscad
                translate([R-Lc/2,0,0],
                    cube({size:[Lc,Wc,H+1]}),
                )
            ),
            translate([(R-Lc-rh1-e)/2,0,0],
                cube({size:[R-Lc+rh1+e,Wp,H]}),
            ),
            
            // Eje de biela
            translate([dh12,0,H],
                cylinder({radius:rh2, height:hp})
            ),
        ),
        
        // Eje central
        cylinder({radius:rh1, height: H}),
    )
}

module.exports = crank
