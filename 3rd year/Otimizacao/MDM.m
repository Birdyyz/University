function [w_opt,Fval_opt,output]=MDM(Fwithgrad,w0,eta,epsilon,Kmax)
%
k=0;  %contador de iterações
wk=w0;
output=[];
while (k <= Kmax)
    [Fk,gradk]=Fwithgrad(wk);
    norma=norm(gradk,inf);
    if (norma <= epsilon)       
        output=[output; k wk' Fk gradk' eta norma];
        break;
    end
    %direção
    sk=-gradk;
    %% calcular eta com procura exata: minimizar phi(eta)=F(wk+eta*sk)
    
    %% para guardar informação
     output=[output;k wk' Fk gradk' eta norma];
    %% novo ponto
    wk=wk+eta*sk;
    k=k+1;
end
w_opt=wk;
Fval_opt=Fk;
end


