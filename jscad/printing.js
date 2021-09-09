const crank = require('./modules/Crank');
const equalizer = require('./modules/Equalizer');
const filler = require('./modules/Filler');
const pitman = require('./modules/Pitman');
const block = require('./modules/Motor');
const beam = require('./modules/WalkingBeam');
const head = require('./modules/HorseHead');
const foot = require('./modules/Foot');

// Model parts with printing layout
const printing = p => [
    {
        part: block({...p, motor:true}),          
        position: [5,10,9],
        rotation: [90,0,0]   
    },
    {
        part: block(p),          
        position: [-45,-10,4.5],
        rotation: [90,0,180]
    },
    {
        part: crank(p),
        position: [5,50,3.5]
    },
    {
        part: crank(p),
        position: [25,70,3.5],
        rotation: [0, 0, 180]
    },
    {
        part: equalizer(p),
        position: [-20, -50, 3.5],
        rotation: [0, 0, 90]
    },
    {
        part: filler(p),
        position: [0,87,1]   
    },
    {
        part: filler(p),        
        position: [20,87,1]
    },
    {
        part: filler(p),        
        position: [40,87,1]
    },
    {
        part: filler(p),        
        position: [60,87,1]
    },
    {
        part: pitman(p),        
        position: [50,-50,2.5]
    },
    {
        part: pitman(p),        
        position: [35,-50,2.5]
    },
    {
        part: beam(p),
        position: [70,0,12],
        rotation: [180,0,-90]
    },
    {
        part: head(p),        
        position: [20,-70,10],
        rotation: [0,0,90]
    },
    {
        part: foot(p),
        position: [85,80,7],
        rotation: [90,180,0]
    }
];

module.exports = printing;