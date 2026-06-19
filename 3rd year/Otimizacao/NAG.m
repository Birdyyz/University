function [w_opt,Fval_opt,output]=NAG(Fwithgrad,w0,eta,beta,epsilon,Kmax)

k=0;  
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
    
    [Fi, gradi]= Fwithgrad(wk + beta * mk);
    si = -gradi;
    
    mk = beta * mk + eta * si;

    output=[output;k wk' Fk gradk' eta norma];

    wk = wk + mk;
    k = k + 1;
end

w_opt=wk;
Fval_opt=Fk;
end