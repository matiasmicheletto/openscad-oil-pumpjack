const crank = require('./modules/Crank');
const equalizer = require('./modules/Equalizer');
const filler = require('./modules/Filler');
const pitman = require('./modules/Pitman');
const block = require('./modules/Motor');
const beam = require('./modules/WalkingBeam');
const head = require('./modules/HorseHead');
const foot = require('./modules/Foot');

// Model parts in its positions
const printing = [
    {
        part: block,  
        params: {motor:true},      
        position: [5,10,9],
        rotation: [90,0,0]   
    },
    {
        part: block,          
        position: [-45,-10,4.5],
        rotation: [90,0,180]
    },
    {
        part: crank,
        position: [5,50,3.5]
    },
    {
        part: crank,
        position: [25,70,3.5],
        rotation: [0, 0, 180]
    },
    {
        part: equalizer,
        position: [-20, -50, 3.5]        
    },
    {
        part: filler,
        position: [0,87,1]   
    },
    {
        part: filler,        
        position: [20,87,1]
    },
    {
        part: filler,        
        position: [40,87,1]
    },
    {
        part: filler,        
        position: [60,87,1]
    },
    {
        part: pitman,        
        position: [50,-20,2.5]
    },
    {
        part: pitman,        
        position: [35,-20,2.5]
    },
    {
        part: beam,
        position: [70,0,6],
        rotation: [0,0,90]
    },
    {
        part: head,        
        position: [20,-80,0],
        rotation: [0,0,90]
    },
    {
        part: foot,
        position: [85,80,7],
        rotation: [90,180,0]
    }
];

module.exports = printing;