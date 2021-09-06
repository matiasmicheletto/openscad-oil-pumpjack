const getParameterDefinitions = require('./parameters');
const { put } = require('./helpers');
const model = require('./assemble');
//const model = require('./printing');

const main = params => {
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