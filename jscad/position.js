const { transforms } = require('@jscad/modeling')
const { translate, rotate } = transforms;

const put = (part, position, rotation) => {
    // This is a decorator to position parts in its final place    
    return translate(
        position?position:[0,0,0],
        rotate(
            rotation?rotation:[0,0,0],
            part
        )
    );
}

module.exports = put;