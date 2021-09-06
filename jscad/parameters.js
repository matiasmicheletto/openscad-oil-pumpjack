const getParameterDefinitions = () => { 
    return [       
        { name: 'print', type: 'checkbox', checked: false, caption: 'Print layout' }, 
        { name: 'r1', type: 'int', initial: 75, caption: 'Walking beam section 1' },
        { name: 'r2', type: 'int', initial: 65, caption: 'Walking beam section 2' },
        { name: 'r3', type: 'int', initial: 30, caption: 'Crank length' },
        { name: 'a', type: 'int', initial: 100, caption: 'Walking beam height' },
        { name: 'b', type: 'int', initial: 50, caption: 'Crank shaft position' },
        { name: 'd', type: 'int', initial: 23, caption: 'Pitmans arms lenght' },
        { name: 'shr', type: 'float', initial: 1.7, caption: 'Screw holes size' },
        { name: 'msr', type: 'float', initial: 2.3, caption: 'Main shaft size' },
        { name: 'psr', type: 'float', initial: 3.5, caption: 'Pitmans shaft size' }
    ]
}
 
module.exports = getParameterDefinitions;