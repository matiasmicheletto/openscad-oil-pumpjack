const crank = require('./modules/Crank');
const equalizer = require('./modules/Equalizer');
const filler = require('./modules/Filler');
const pitman = require('./modules/Pitman');
const block = require('./modules/Motor');
const pulley = require('./modules/Pulley');
const beam = require('./modules/WalkingBeam');
const head = require('./modules/HorseHead');
const foot = require('./modules/Foot');

// Model parts with printing layout
const printing = params => [
    {
        part: block({...params, motor:true}),          
        position: [0,-25,9],
        rotation: [90,0,0]   
    },
    {
        part: block(params),          
        position: [-50,20,4.5],
        rotation: [90,0,180]
    },
    {
        part: pulley(params),        
        position: [0, 10, 0]   
    },
    {
        part: pulley({...params, motor: true}),        
        position: [-50, 50, 0]   
    },
    {
        part: crank(params),
        position: [5,50,3.5]
    },
    {
        part: crank(params),
        position: [25,70,3.5],
        rotation: [0, 0, 180]
    },
    {
        part: equalizer(params),
        position: [-20, -50, 3.5],
        rotation: [0, 0, 90]
    },
    {
        part: filler(params),
        position: [0,87,1]   
    },
    {
        part: filler(params),        
        position: [20,87,1]
    },
    {
        part: filler(params),        
        position: [40,87,1]
    },
    {
        part: filler(params),        
        position: [60,87,1]
    },
    {
        part: pitman(params),        
        position: [50,-50,2.5]
    },
    {
        part: pitman(params),        
        position: [35,-50,2.5]
    },
    {
        part: beam(params),
        position: [70,0,12],
        rotation: [180,0,-90]
    },
    {
        part: head(params),        
        position: [20,-70,10],
        rotation: [0,0,90]
    },
    {
        part: foot(params),
        position: [85,80,7],
        rotation: [90,180,0]
    }
];

module.exports = printing;