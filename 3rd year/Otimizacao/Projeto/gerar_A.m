function A = gerar_A(d,m,L)

A = randn(d,d);
[Q,~] = qr(A);

D = rand(d,1);
D = 10.^D;

D = (D - min(D)) / (max(D)-min(D));
D = m + D*(L-m);

A = Q' * diag(D) * Q;

end