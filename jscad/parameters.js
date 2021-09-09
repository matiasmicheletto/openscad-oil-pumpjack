const { sin, cos, rad2deg } = require('./helpers');

const getParameterDefinitions = () => { 
    return [       
        { name: 'print', type: 'checkbox', checked: false, caption: 'Print layout' }, 
        { name: 't', type: 'slider', min: 0, max: 360, initial: 10, caption: 'Crank angle' },
        { name: 'r1', type: 'int', min:50, max:100, initial: 65, caption: 'Walking beam front length' },
        { name: 'r2', type: 'int', min:50, max:100, initial: 75, caption: 'Walking beam rear length' },
        { name: 'a', type: 'int', min:50, max:100, initial: 70, caption: 'Walking beam height' },
        { name: 'r3', type: 'int', min:20, max:40, initial: 30, caption: 'Crank length' },
        { name: 'c', type: 'int', min:50, max:70, initial: 60, caption: 'Crank shaft height' },
        { name: 'b', type: 'int', min:40, max:60, initial: 50, caption: 'Samson post position' },
        { name: 'd', type: 'int', min:50, max:70, initial: 65, caption: 'Pitmans arms lenght' },
        { name: 'shr', type: 'float', min:1, max:4, initial: 1.7, caption: 'Screw holes radius' },
        { name: 'msr', type: 'float', min:1, max:4, initial: 2.3, caption: 'Main shaft radius' },
        { name: 'psr', type: 'float', min:1, max:5, initial: 3.5, caption: 'Pitmans shaft radius' }
    ]
};

const getBeamAngle = params => {
    // This function computes the walking beam angle
    // given the system geometry and the angle of the crank
    const {a, b, d, r2, r3, t} = params;
    
    // Auxiliar variables
    const p = r3*cos(-t) + b;
    const q = r3*sin(-t) - a;
    const k = (p*p + q*q + r2*r2 - d*d)/2/r2;
    const denom = Math.sqrt(p*p+q*q);    

    // Final equation
    const wba = 270+rad2deg(Math.asin(k/denom) - Math.asin(q/denom));
    return wba;
};

const getPitmansAngle = (params, wba) => {
    // Given the positions of the equalizer and crank,
    // compute the pitmans angle
    const {a, b, c, t, r2, r3} = params;

    // Coordinates of the points
    const x = [r2*cos(wba)-b, a + c - r2*sin(wba)]; // Equalizer
    const y = [r3*cos(t), c - r3*sin(t)]; // Crank end

    // Angle of line conecting points
    return rad2deg(Math.atan2(x[0]-y[0], x[1]-y[1]));
}
 
module.exports = {getParameterDefinitions, getBeamAngle, getPitmansAngle};