% Ecuaciones de movimiento mecanismo principal AIB

clear all; clc; close all;

savegif = 0; % Guardar animacion como gif

if savegif
	delete 'anim.gif' % Borrar animacion si ya existe
end

% Dimensiones en mm del modelo
a = 70; % Altura del punto de apoyo del balancin
b = 55; % Distancia del origen al eje central de la manivela
r1 = b+25; % Longitud entre el apoyo del balancin y el acople a la biela
r2 = 30; % Longitud del balancin
r3 = 70; % Distancia entre el apoyo del balancin y el cabezal
d = 70 % Longitud de la biela

% Parametros de la ecuacion (3 a 5 se calculan con t = 0)
p = [
	-2*a,
	a^2 - r1^2,
	-2*r2*cos(0) - 2*b,
	-2*r2*sin(0),
	r2^2 + b^2 - d^2 + 2*r2*b*cos(0)
];

% Sistema de ecuaciones a resolver
function y = eq_sys(x, p)
	y(1) = x(1)^2 + x(2)^2 + p(1)*x(2) + p(2);
	y(2) = x(1)^2 + x(2)^2 + p(3)*x(1) + p(4)*x(2) + p(5);
endfunction

x0 = [b; a]; % Solucion inicial para el solver

for t=0:0.2:4*pi
	clf;

	% Recalcular parametros dependientes del tiempo
	p(3:5) = [-2*r2*cos(t) - 2*b,-2*r2*sin(t),r2^2 + b^2 - d^2 + 2*r2*b*cos(t)];

	x = fsolve(@(x) eq_sys(x, p), x0); % Resolver sistema de ecuaciones para el instante actual

	% Calcular posicion del cabezal
	th = asin((x(2)-a)/r1); % Angulo 
	y = [-r3*cos(th), a-r3*sin(th)]; % Coordenadas

	% Dibujar puntos	
	plot([0, b, r2*cos(t)+b, x(1), y(1)], [a, 0, r2*sin(t), x(2), y(2)],'o','markerfacecolor','k','markersize',10);
	hold on
	% Dibujar ejes
	plot([b, r2*cos(t)+b], [0, r2*sin(t)],'linewidth',3); % Manivela
	plot([r2*cos(t)+b, x(1)], [r2*sin(t), x(2)],'r','linewidth',3); % Biela
	plot([0, x(1)], [a, x(2)],'g','linewidth',3); % Balancin (extremo posterior)
	plot([0, y(1)], [a, y(2)],'k','linewidth',3); % Balancin (extremo anterior)
	title(['Angulo balancin:  ',num2str(360*th/2/pi),' [deg]']);
	
	% Fijar vista
	axis([-150,150,-50,150]);
	grid;

	pause(0.1);

	if savegif
		saveas (1, 'snap.png'); % Exportar grafico a imagen (se puede pasar a matriz??)
		im = imread('snap.png'); % Importar como matriz
		imwrite(im,'anim.gif','gif','writemode','append','DelayTime',0); % Adjuntar a gif animado
	end
end

if savegif
	delete 'snap.png' % Borrar imagen temporal
end