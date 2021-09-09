const crank = require('./modules/Crank');
const equalizer = require('./modules/Equalizer');
const filler = require('./modules/Filler');
const pitman = require('./modules/Pitman');
const block = require('./modules/Motor');
const pulley = require('./modules/Pulley');
const beam = require('./modules/WalkingBeam');
const head = require('./modules/HorseHead');
const foot = require('./modules/Foot');
const { sin, cos } = require('./helpers');
const { getBeamAngle, getPitmansAngle } = require('./parameters');

// Model parts in its positions
const assemble = params => {
    const {a, b, c, r1, r2, r3, t} = params;

    // Calculation of the walking beam angle from angle t and system geometry
    const wba = getBeamAngle(params);
    // Pitman arms angle    
    const pma = getPitmansAngle(params, wba);

    // Points of the system geometry
    const B = [-b, 0, a+c]; // Walking beam pivoting point
    const A = [-b-r1*cos(wba), 0, B[2] + r1*sin(wba)+6]; // Horse head position    
    const C = [r2*cos(wba)-b, 0, B[2] - r2*sin(wba)]; // Equalizer position
    const D = [r3*cos(t), 0, c - r3*sin(t)]; // Crank end position   

    return [
        {
            part: block({...params, motor: true}),  
            p: {motor:true},      
            position: [0, -12, c]   
        },
        {
            part: block(params),          
            position: [0, 16.5, c]   
        },
        {
            part: pulley(params),
            rotation: [90, 0, 0],
            position: [0, 6, c]   
        },
        {
            part: pulley({...params, motor: true}),
            rotation: [90, 0, 0],
            position: [0, 6, c-35]   
        },
        {
            part: crank(params),
            position: [0, -28, c],
            rotation: [90, t, 0]
        },
        {
            part: crank(params),
            position: [0, 28, c],
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
            position: [D[0], 34, D[2]]   
        },
        {
            part: filler(params),
            rotation: [90, 0, 0], 
            position: [D[0], -34, D[2]]   
        },
        {
            part: pitman(params),
            rotation: [90, pma, 0], 
            position: [D[0], 38, D[2]]   
        },
        {
            part: pitman(params),
            rotation: [90, pma, 0], 
            position: [D[0], -38, D[2]]   
        },
        {
            part: head(params),
            rotation: [90, wba, 0], 
            position: A   
        },
        {
            part: beam(params),
            rotation: [0, wba, 0], 
            position: B   
        },
        {
            part: equalizer(params),
            rotation: [0, wba, 0],
            position: C
        },
        {
            part: foot(params),
            position: [-b,0,0]   
        }
    ];
}

module.exports = assemble;