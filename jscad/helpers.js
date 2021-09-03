const { transforms } = require('@jscad/modeling')
const { translate } = transforms;

const deg2rad = deg => Math.PI*deg/180;

// Equivalent rotate method for using degrees instead of radians
const rotate = (angle, part) => transforms.rotate(
    angle.map(d => deg2rad(d)), part
);

// This is a decorator to position parts in its final place   
const put = (part, position, rotation) => translate(
    position ? position : [0,0,0],
    rotate(
        rotation ? rotation : [0,0,0],
        part
    )
);

module.exports = {put, rotate};