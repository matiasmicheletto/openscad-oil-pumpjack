%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%          Oil pumpjack mechanism simulation          %
%                                                     %
% This simulation allows to test different dimensions %
% for the pumpjack mechanism.                         %
%                                                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all; close all;

savegif = 0; % Change to 1 to save the animation as gif

if savegif
	delete 'anim.gif' % Delete animation if already exist
end

% Model dimensions (mm)
a = 70; % Height of the foot (samson post), from the crank shaft to the walking beam's center bearing.
b = 50; % Separation between the samson post and the crank shaft.
r1 = 65; % Distance from the walking beam's center bearing to the horse head mount point.
r2 = 75; % Distance from the center bearing to the equalizer bearing.
r3 = 30; % Crank length.
d = 65; % Pitman's length.

% Equation's parameters (3 to 5 are initially calculated for t = 0)
p = [
	-2*a,
	a^2 - r2^2,
	-2*r3*cos(0) - 2*b,
	-2*r3*sin(0),
	r3^2 + b^2 - d^2 + 2*r3*b*cos(0)
];

% System of equations to solve
function y = eq_sys(x, p)
	y(1) = x(1)^2 + x(2)^2 + p(1)*x(2) + p(2);
	y(2) = x(1)^2 + x(2)^2 + p(3)*x(1) + p(4)*x(2) + p(5);
endfunction

x0 = [b; a]; % Solver's initial value

for t = 4*pi:-0.2:0 % Time goes backward to achieve clockwise rotation
	clf;

	% Update time-dependent parameters
	p(3:5) = [-2*r3*cos(t) - 2*b,-2*r3*sin(t),r3^2 + b^2 - d^2 + 2*r3*b*cos(t)];

	x = fsolve(@(x) eq_sys(x, p), x0); % Solve the system equations for the current time

	% Update the horse head position
	th = asin((x(2)-a)/r2); % Angle 
	y = [-r1*cos(th), a-r1*sin(th)]; % Coordinates

	% Draw points
	plot([0, b, r3*cos(t)+b, x(1), y(1)], [a, 0, r3*sin(t), x(2), y(2)],'o','markerfacecolor','k','markersize',10);
	hold on
	% Sraw axis
	plot([b, r3*cos(t)+b], [0, r3*sin(t)],'r','linewidth',3); % Crank
	plot([r3*cos(t)+b, x(1)], [r3*sin(t), x(2)],'b','linewidth',3); % Pitman
	plot([0, x(1)], [a, x(2)],'g','linewidth',3); % Walking beam (rear end)
	plot([0, y(1)], [a, y(2)],'g','linewidth',3); % Walking beam (front end)
	title(['Walking beam current inclination angle:  ',num2str(360*th/2/pi),' [deg]']);
	
	% Fix axis view
	axis([-150,150,-50,150]);
	grid;

	pause(0.1);

	if savegif
		% (Is it possible to convert image to matrix??)
		saveas (1, 'snap.png'); % Export graphics to image
		im = imread('snap.png'); % Import as a matrix
		imwrite(im,'anim.gif','gif','writemode','append','DelayTime',0); % Add snapshot to animated gif
	end
end

if savegif
	delete 'snap.png' % Delete current image
end