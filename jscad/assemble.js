const crank = require('./modules/Crank');
const equalizer = require('./modules/Equalizer');
const filler = require('./modules/Filler');
const pitman = require('./modules/Pitman');
const block = require('./modules/Motor');
const beam = require('./modules/WalkingBeam');
const head = require('./modules/HorseHead');
const foot = require('./modules/Foot');

// Model parts in its positions
const assemble = params => {

    const {a, b, c, d, r1, r2, r3, t} = params;

    // Walking beam angle
    const wba = -10; // This needs to be calculated

    // Walking beam pivoting point
    const B = [0, a+c];

    // Horse head position
    const Ap = [Math.cos(wba*Math.PI/180), -Math.sin(wba*Math.PI/180)];
    const A = [-b-r1*Ap[0], 0, B[1] - r1*Ap[1]+6];    
    // Equalizer position    
    const C = [r2*Ap[0]-b, 0, B[1] + r2*Ap[1]];    

    // Crank end position
    const Dp = [Math.cos(t*Math.PI/180), Math.sin(t*Math.PI/180)];
    const D = [r3*Dp[0], c - r3*Dp[1]];

    return [
        {
            part: block({...params, motor:true}),  
            p: {motor:true},      
            position: [0,-12,25]   
        },
        {
            part: block(params),          
            position: [0,16.5,25]   
        },
        {
            part: crank(params),
            position: [0, -28, 60],
            rotation: [90, t, 0]
        },
        {
            part: crank(params),
            position: [0, 28, 60],
            rotation: [-90, t, 0]
        },
        {
            part: filler(params),
            rotation: [90, 0, 0], 
            position: [C[0], 34, C[2]]   
        },
        {
            part: filler(params),
            rotation: [90, 0, 0], 
            position: [C[0], -34, C[2]]   
        },
        {
            part: filler(params),
            rotation: [90, 0, 0], 
            position: [D[0], 34, D[1]]   
        },
        {
            part: filler(params),
            rotation: [90, 0, 0], 
            position: [D[0], -34, D[1]]   
        },
        {
            part: pitman(params),
            rotation: [90, 0, 0], 
            position: [D[0], 38, D[1]]   
        },
        {
            part: pitman(params),
            rotation: [90, 0, 0], 
            position: [D[0], -38, D[1]]   
        },
        {
            part: beam(params),
            rotation: [0, wba, 0], 
            position: [-b, 0, a+c]   
        },
        {
            part: head(params),
            rotation: [90, wba, 0], 
            position: A   
        },
        {
            part: equalizer(params),
            rotation: [0, wba, 0],
            position: C
        },
        {
            part: foot(params),
            position: [-50,0,0]   
        }
    ];
}

module.exports = assemble;