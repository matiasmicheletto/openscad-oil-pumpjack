function x = step(t, params)

    % Constantes de la ecuacion
	p = [
		-2*params(1),
		params(1)^2 - params(3)^2,
		-2*params(4)*cos(t) - 2*params(2),
		-2*params(4)*sin(t),
		params(4)^2 + params(2)^2 - params(5)^2 + 2*params(4)*params(2)*cos(t)
	];

	x0 = [params(2); params(1)]; % Solucion inicial para el solver

	[x, fvec, info, output, fjac] = fsolve(@(x) eq_sys(x, p), x0); % Resolver sistema de ecuaciones

endfunction
