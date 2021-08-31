const crank = require('./modules/Crank');
const equalizer = require('./modules/Equalizer');

const put = require('./position');

// General model geometry
const geometry = {
    r1: 100,
    r2: 20,
    r3: 30,
    a: 100,
    b: 50,
    d: 23
};

// Radius of circular shapes
const radius = {
    msr: 2.3, // Main shaft radius
    shr: 1.7, // Screw hole radius
    psr: 3.5  // Pitmans arm shaft radius
};

// Model parts and positions
const model = [
    {
        part: crank,
        position: [0, -28, 60],
        rotation: [Math.PI/2, 0, 0]
    },
    {
        part: crank,
        position: [0, 28, 60],
        rotation: [-Math.PI/2, 0, 0]
    },
    {
        part: equalizer,
        rotation: [Math.PI/2, 0, Math.PI/2], 
        position: [25, 0, 73.5+60]
    }
];


const main = () => model.map(m => put(
        m.part({...geometry,...radius}), 
        m.position, 
        m.rotation
    )
);
 
module.exports = { main }