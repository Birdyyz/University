syms w1 w2 w3 l1
w_opt= [2.5;-1.5;-1]
F = w1^2 - 2*w1 + w2^2 - w3^2 + 4*w3;
c1 = w1-w2+2*w3-2;
%defenir func lagrangiana
L = F - l1 * c1;
%verificar que o ponto é admissivel
c1ad = subs(c1, [w1 w2 w3], [w_opt(1) w_opt(2) w_opt(3)]);
% verificar se w_opt é ponto regular, como neste caso so tem uma restricao
gradC1 = gradient(c1, [w1 w2 w3]);
gradC1ad = subs(gradC1,[w1 w2 w3], [w_opt(1) w_opt(2) w_opt(3)]);

%Verifica  as condições de optimalidade
%1 gradL no ponto w =0 e c1(w)= =0
gradL = gradient(L,[w1 w2 w3 l1])
v0 = [0;0;0;0];

[ws1 ws2 ws3 ls1]= solve(gradL == v0,[w1 w2 w3 l1])
%gradLad= subs(gradL,[w1 w2 w3], [w_opt(1) w_opt(2) w_opt(3)]);

%calcular hessiana de L
hessLw= hessian(L,[w1 w2 w3])

%Determinar o nucleo no ponto base gerador do pontos admissiveis
Z = null(gradC1')

%2 condi
hessLw_opt= subs(hessLw,[w1 w2 w3 l1], [w_opt(1) w_opt(2) w_opt(3) 3])
Z' * hessLw_opt * Z