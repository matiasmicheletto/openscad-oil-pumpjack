%%
% Ecuaciones de movimiento mecanismo AIB

clear all; clc;

% Parametros
a = 100;
b = 75;
r1 = 75;
r2 = 25;
d = 110;

params = [a,b,r1,r2,d];

for t=0:0.1:4*pi

	x = step(t, params);

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

	pause(0.1);
	clf;
end

close all;