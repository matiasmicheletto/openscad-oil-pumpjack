const crank = require('./modules/Crank');
const equalizer = require('./modules/Equalizer');
const filler = require('./modules/Filler');
const pitman = require('./modules/Pitman');
const block = require('./modules/Motor');
const beam = require('./modules/WalkingBeam');
const head = require('./modules/HorseHead');
const foot = require('./modules/Foot');
const pulley = require('./modules/Pulley');

// Single piece model
const single = params => [
    {
        part: pulley({motor:false,...params}),
        rotation: [0, 0, 0], 
        position: [0, 0, 0]   
    }
];

module.exports = single;