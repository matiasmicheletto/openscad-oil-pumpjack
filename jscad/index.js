const crank = require('./modules/Crank');
const equalizer = require('./modules/Equalizer');
const filler = require('./modules/Filler');
const pitman = require('./modules/Pitman');
const block = require('./modules/Motor');

const { put } = require('./helpers');


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
        part: block,  
        params: {motor:true},      
        position: [0,-12,25]   
    },
    {
        part: block,          
        position: [0,16.5,25]   
    },
    {
        part: crank,
        position: [0, -28, 60],
        rotation: [90, -10, 0]
    },
    {
        part: crank,
        position: [0, 28, 60],
        rotation: [-90, -10, 0]
    },
    {
        part: equalizer,
        rotation: [90, 0, 90], 
        position: [25, 0, 73.5+60]
    },
    {
        part: filler,
        rotation: [90, 0, 0], 
        position: [25.5, 34, 131]   
    },
    {
        part: filler,
        rotation: [90, 0, 0], 
        position: [25.5,-34,131]   
    },
    {
        part: filler,
        rotation: [90, 0, 0], 
        position: [30,34,65]   
    },
    {
        part: filler,
        rotation: [90, 0, 0], 
        position: [30,-34,65]   
    },
    {
        part: pitman,
        rotation: [90, -4, 0], 
        position: [27.5,38,98]   
    },
    {
        part: pitman,
        rotation: [90, -4, 0], 
        position: [27.5,-38,98]   
    }
];


const main = () => model.map(m => put(
        m.part({
            ...geometry,
            ...radius,
            ...m.params}
        ), 
        m.position, 
        m.rotation
    )
);
 
module.exports = { main }