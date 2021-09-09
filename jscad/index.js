const { getParameterDefinitions } = require('./parameters');
const { place } = require('./helpers');
const assemble = require('./assemble');
const printing = require('./printing');

const main = params => {
    const model = params.print ? printing : assemble;
    return model(params).map(m => place(
        m.part, 
        m.position, 
        m.rotation
    ));
}
 
module.exports = { main, getParameterDefinitions }