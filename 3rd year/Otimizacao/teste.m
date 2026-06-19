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

vals_w1 = output(:,2);
vals_w2 = output(:,3);

plot(vals_w1, vals_w2,'ro-','LineWidth',1,'MarkerFaceColor','r','MarkerSize',4)

text(vals_w1(1), vals_w2(1)+0.2,'w0')
text(vals_w1(end), vals_w2(end)+0.5,'w*')
title('Trajetória dos pontos HB')
grid on

%% FUNÇÕES (têm de ficar no fim do ficheiro!)
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