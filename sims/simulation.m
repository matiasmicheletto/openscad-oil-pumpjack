% Ecuaciones de movimiento mecanismo principal AIB

clear all; clc; close all;
delete 'anim.gif' % Borrar animacion si ya existe


% Dimensiones en mm
a = 100; % Alto del soporte brazo principal
b = 75; % Distancia del origen al eje motor
r1 = 75; % Longitud del brazo principal
r2 = 25; % Longitud del brazo motor
d = sqrt(a^2+r2^2); % Longitud de la biela

% Parametros de la ecuacion (con t = 0)
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

	% Parametros dependientes del tiempo
	p(3:5) = [-2*r2*cos(t) - 2*b,-2*r2*sin(t),r2^2 + b^2 - d^2 + 2*r2*b*cos(t)];

	x = fsolve(@(x) eq_sys(x, p), x0); % Resolver sistema de ecuaciones para el instante actual

	% Dibujar puntos	
	plot([0, b, r2*cos(t)+b, x(1)], [a, 0, r2*sin(t), x(2)],'o','markerfacecolor','k','markersize',10);
	hold on
	% Dibujar ejes
	plot([b, r2*cos(t)+b], [0, r2*sin(t)],'linewidth',3);
	plot([r2*cos(t)+b, x(1)], [r2*sin(t), x(2)],'r','linewidth',3);
	plot([0, x(1)], [a, x(2)],'g','linewidth',3);
	
	% Fijar
	axis([-50,150,-50,150]);
	grid;

	saveas (1, 'snap.png'); % Exportar grafico a imagen (se puede pasar a matriz??)
	im = imread('snap.png'); % Importar como matriz
	imwrite(im,'anim.gif','gif','writemode','append','DelayTime',0); % Adjuntar a gif animado
end

delete 'snap.png' % Borrar imagen temporal