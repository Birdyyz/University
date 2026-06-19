clear, clc, close all;

%% PARÂMETROS
c = 1;
w0 = [20;1];
epsilon = 0.0001;
Kmax = 200;
eta = 0.01;
beta = 0.9;

%% EXECUÇÃO
[w_opt,Fval_opt,output] = HB(@F1withgrad,w0,eta,beta,epsilon,Kmax);

%% GRÁFICO
[w1,w2] = meshgrid(-5:0.01:10, -5:0.01:5);
vals_F = w1.^2 + c*w2.^2;

figure
contour(w1,w2,vals_F,10);
colorbar;
xlabel('w_1'); ylabel('w_2');
hold on

plot(output(:,2), output(:,3),'ro-','LineWidth',1)

grid on


%% =========================
%      FUNÇÃO HB
%% =========================
function [w_opt,Fval_opt,output]=HB(Fwithgrad,w0,eta,beta,epsilon,Kmax)

k=0;
wk=w0;
output=[];
mk=zeros(length(w0),1);

while (k <= Kmax)
    [Fk,gradk]=Fwithgrad(wk);
    norma=norm(gradk,inf);

    if (norma <= epsilon)
        output=[output; k wk' Fk gradk' eta norma];
        break;
    end

    sk = -gradk;
    mk = beta*mk + eta*sk;

    output=[output; k wk' Fk gradk' eta norma];

    wk = wk + mk;
    k = k + 1;
end

w_opt = wk;
Fval_opt = Fk;
end


%% =========================
%   FUNÇÃO OBJETIVO
%% =========================
function [f,gradf] = F1withgrad(w)

syms w1 w2

fun = (w1^2 + 20*w2^2)/2;
grad = gradient(fun,[w1 w2]);

f = double(subs(fun,[w1 w2],[w(1) w(2)]));
gradf = double(subs(grad,[w1 w2],[w(1) w(2)]));

end