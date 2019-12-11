function y = eq_sys(x, p)

	y(1) = x(1)^2 + x(2)^2 + p(1)*x(2) + p(2);
	y(2) = x(1)^2 + x(2)^2 + p(3)*x(1) + p(4)*x(2) + p(5);

endfunction