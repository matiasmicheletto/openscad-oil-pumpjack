const getParameterDefinitions = require('./parameters');
const { put } = require('./helpers');
const assemble = require('./assemble');
const printing = require('./printing');

const main = params => {
    const model = params.print ? printing : assemble;
    return model.map(m => put(
        m.part({            
            ...m.params,
            ...params
        }), 
        m.position, 
        m.rotation
    ));
}
 
module.exports = { main, getParameterDefinitions }