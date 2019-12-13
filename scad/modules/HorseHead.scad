module horseHead(){
     
    R = 150; // Radio de rotacion
    W = 10; // Ancho (X)
    L = 90; // Largo (Y)
    H = 20; // Espesor de la pieza (Z)
    a = 6; // Cateto base
    b = 5; // Cateto altura
    d = 1; // Espesor de la ranura

    // Acople al brazo
    a1 = 15; // Ancho del cuadrante (Y)
    b1 = H-10; // Largo del cuadrante (Z)
    r2 = 2.3; // Radio del tornillo de ajuste

    // Desplazamiento del acople
    delta = 7.5;

    // Poligono de interseccion
    poly = [[0,-L/2],
            [W,-L/2],
            [W+a,b-L/2],
            [W+a,L/2-b],
            [W,L/2],
            [0,L/2]];
            
     difference(){
        linear_extrude(height = H, center = true)
            intersection(){
                translate([R,0,0])
                    circle(R);
                translate([0,0,0])
                    polygon( points=poly );
            }
        
        // Acople al brazo
        translate([(W+a)/2+5,delta,0])
            cube([W+a,a1,b1], center = true);
        translate([W+a-5,delta,0])
            cylinder(r = r2, h = H, center = true);
    }
}

horseHead();
