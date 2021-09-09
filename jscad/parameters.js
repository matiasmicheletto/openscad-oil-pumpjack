const getParameterDefinitions = () => { 
    return [       
        { name: 'print', type: 'checkbox', checked: false, caption: 'Print layout' }, 
        { name: 't', type: 'int', initial: -10, caption: 'Crank angle' },
        { name: 'r1', type: 'int', initial: 65, caption: 'Walking beam front length' },
        { name: 'r2', type: 'int', initial: 75, caption: 'Walking beam rear length' },
        { name: 'r3', type: 'int', initial: 30, caption: 'Crank length' },
        { name: 'a', type: 'int', initial: 70, caption: 'Walking beam position' },
        { name: 'b', type: 'int', initial: 50, caption: 'Crank shaft X' },
        { name: 'c', type: 'int', initial: 60, caption: 'Crank shaft Y' },
        { name: 'd', type: 'int', initial: 65, caption: 'Pitmans arms lenght' },
        { name: 'shr', type: 'float', initial: 1.7, caption: 'Screw holes size' },
        { name: 'msr', type: 'float', initial: 2.3, caption: 'Main shaft size' },
        { name: 'psr', type: 'float', initial: 3.5, caption: 'Pitmans shaft size' }
    ]
}
 
module.exports = getParameterDefinitions;