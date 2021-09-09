const { transforms } = require('@jscad/modeling')
const { translate } = transforms;

// Angle unit conversions
const deg2rad = deg => Math.PI*deg/180;
const rad2deg = rad => rad/Math.PI*180;

// Trigonometric functions
const sin = deg => Math.sin(deg2rad(deg));
const cos = deg => Math.cos(deg2rad(deg));

// Equivalent rotate method for using degrees instead of radians
const rotate = (angle, part) => transforms.rotate(
    angle.map(d => deg2rad(d)), part
);

// This is a decorator to position parts in their place   
const place = (part, position = [0,0,0], rotation = [0,0,0]) => 
    translate(position, rotate(rotation, part));

module.exports = {place, rotate, sin, cos, deg2rad, rad2deg};