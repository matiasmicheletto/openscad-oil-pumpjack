const crank = require('./modules/Crank');
const equalizer = require('./modules/Equalizer');
const filler = require('./modules/Filler');
const pitman = require('./modules/Pitman');
const block = require('./modules/Motor');
const beam = require('./modules/WalkingBeam');
const head = require('./modules/HorseHead');
const foot = require('./modules/Foot');

// Model parts in its positions
const assemble = [
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
    },
    {
        part: beam,
        rotation: [180, 0, 180], 
        position: [-50,0,70+6+60]   
    },
    {
        part: head,
        rotation: [90,0,0], 
        position: [-127,10,130]   
    },
    {
        part: foot,
        position: [-50,0,0]   
    }
];

module.exports = assemble;