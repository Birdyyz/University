syms w1 w2 w3 y1

F = w1^2 - 2*w1 + w2^2 - w3^2 + 4*w3;
c1 = w1 - w2 + 2*w3 - 2;

L = F - y1*c1;

gradL = gradient(L, [w1 w2 w3 y1]);

sol = solve(gradL == 0, [w1 w2 w3 y1]);

w_opt = [sol.w1 sol.w2 sol.w3];
y_opt = sol.y1;

hessLw = hessian(L, [w1 w2 w3]);

hessLw_opt = subs(hessLw, [w1 w2 w3 y1], [w_opt y_opt]);

gradC1 = gradient(c1, [w1 w2 w3]);
gradC1_opt = subs(gradC1, [w1 w2 w3], w_opt);

Z = null(gradC1_opt');

Z' * hessLw_opt * Z