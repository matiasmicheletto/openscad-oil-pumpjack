const { transforms, primitives, booleans } = require('@jscad/modeling');
const { translate } = transforms;
const { cuboid, cylinder } = primitives;
const { subtract, union, intersect } = booleans;

const foot = () => {
    // This is the model for the samson post that holds the center of the walking beam in its place

    return subtract(

    )
};

module.exports = foot;
