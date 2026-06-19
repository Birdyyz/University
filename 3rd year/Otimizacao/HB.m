function [w_opt,Fval_opt,output]=HB(Fwithgrad,w0,eta,beta,epsilon,Kmax)
%
k=0;  %contador de iterações
wk=w0;
output=[];
mk= zeros(length(w0),1);
while (k <= Kmax)
    [Fk,gradk]=Fwithgrad(wk);
    norma=norm(gradk,inf);
    if (norma <= epsilon)       
        output=[output; k wk' Fk gradk' eta norma];
        break;
    end
    %direção
    sk=-gradk;
    mk = beta * mk + eta*sk;
    
    
    %% para guardar informação
     output=[output;k wk' Fk gradk' eta norma];
    %% novo ponto
    wk=wk+ mk;
    k=k+1;
end
w_opt=wk;
Fval_opt=Fk;
end


