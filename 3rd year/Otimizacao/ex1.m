%Dominio
[w1,w2] = meshgrid(-5:0.01:5,-5:0.01:5);

%Função escalar 
f = w1.^3+2*w1.*w2.^2-w2.^3-20*w1;
%Figura das curvas de nivel
figure; hold on; box on;

%Curvas de nivel (contornos)
contour(w1,w2,f,100,'LineWidth',1.2);

%Eixos coordenados
plot([-5 5], [0 0], 'k--','LineWidth',1); %eixo w2 = 0
plot([0 0],[-5 5], 'k--', 'LineWidth',1); % eixo w1 = 0

%solucao otima
plot(2.580,0,'ko', 'MarkerFaceColor','k','MarkerSize',5);
plot(-2.580,0,'ko', 'MarkerFaceColor','k','MarkerSize',5);
%Rótulo w*

text(2.3,0.3,'$w^*$','Interpreter','latex','FontSize',14,'Color','k');
text(-2.3,0.3,'$w^*$','Interpreter','latex','FontSize',14,'Color','k');

%Rotulos e formatacao
xlabel('$w_1$','Interpreter','latex','FontSize',12);
ylabel('$w_2$','Interpreter','latex','FontSize',12);
title('Curvas de nivel de F');
axis equal; grid on;
xlim([-5 5]); ylim([-5 5]);
xticks(-5:1:5);
yticks(-5:1:5);
hold off

figure
%Plot da superficie
surf(w1,w2,f);

%Melhorias visuais

xlabel('w1')
ylabel('w2')
zlabel('F(w1,w2)')
title('Funcao F(w1,w2)')
colorbar;