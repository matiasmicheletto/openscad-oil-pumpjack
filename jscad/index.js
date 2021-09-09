const getParameterDefinitions = require('./parameters');
const { place } = require('./helpers');
const assemble = require('./assemble');
const printing = require('./printing');
const single = require('./single');

const main = params => {
    const model = params.print ? printing : assemble;
    //const model = single;
    return model(params).map(m => place(
        m.part, 
        m.position, 
        m.rotation
    ));
}
 
module.exports = { main, getParameterDefinitions }