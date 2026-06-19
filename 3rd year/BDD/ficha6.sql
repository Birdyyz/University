# PL-06
# 1. Quais são os aparelhos com preço de venda superior a 100€?
SELECT * FROM Aparelhos WHERE PrecoVenda > 100;

#2. Quais são os nomes dos técnicos com função "Revisor"?
SELECT Nome FROM Técnicos WHERE Função = 'Revisor';

#3. Quais são as peças da família 1?
SELECT Designação FROM Peças WHERE Familia = 1;

#4. Quais são as operações com custo hora superior ou igual a 20€?
SELECT Designação FROM Operações WHERE CustoHora >= 20;

#5. Quais são os aparelhos com preço de venda > 100€ e nr de peças inferior a 10?
SELECT PrecoVenda, NrPecas FROM Aparelhos WHERE PrecoVenda > 100 AND NrPecas < 10;

#6. Quais são os registos de produção iniciadas nos anos de 2025 e 2024?
SELECT * FROM Produção WHERE YEAR(InicioProdução) IN (2024,2025);

#7. Quais são os nomes dos técnicos que realizaram operações?
SELECT DISTINCT T.Nome FROM Técnicos T JOIN TécnicosOperações O ON T.Id = O.Técnico;

#8. Qual a designação dos aparelhos que utilizam a peça 1?
SELECT DISTINCT A.Designação FROM Aparelhos A JOIN Montagem M ON A.Id = M.Aparelho WHERE M.Peça = 1;

#9. Qual a designação das peças da família 1 usadas em montagens com custo superior a 50€?
SELECT P.Designação FROM Peças P JOIN Montagem M ON P.Id = M.Peça WHERE P.Familia = 1 AND M.Custo > 50;

#10. Quais são os nomes dos técnicos que trabalharam em operações com custo > 20€?
SELECT DISTINCT T.Nome FROM Técnicos T JOIN TécnicosOperações Op ON T.Id = Op.Técnico 
									   JOIN Montagem M ON Op.Operação = M.Operação WHERE M.Custo >20;

#11. Quais são os aparelhos produzidos após 01/01/2025 com quantidade > 50?
SELECT DISTINCT A.Designação FROM Aparelhos A JOIN Produção P ON A.Id = P.Aparelho WHERE P.InicioProducao > '01-01-2025'
																				   AND P.Quantidade > 50;
                                                                                   
#12. Quais são os técnicos que trabalharam em aparelhos com preço > 200€?
SELECT DISTINCT T.Nome FROM Técnicos T JOIN TécnicosOperações Op ON T.Id = Op.Técnicos 
									   JOIN MONTAGEM M ON Op.Operação = M.Operação 
                                       JOIN Aparelhos A ON A.Id = M.Aparelho
                                       WHERE A.PreçoVenda > 200;

#13. Quais são os aparelhos que NÃO têm produção registada?
SELECT A.Designação FROM Aparelho A WHERE NOT EXISTS (SELECT 1 FROM Produção P WHERE A.Id = P.Aparelho);
									

#14. Quais são os técnicos que NÃO realizaram nenhuma operação?
SELECT DISTINCT T.Nome FROM Técnicos T WHERE NOT EXISTS(SELECT 1 FROM TécnicosOperações Op WHERE T.Id = Op.Técnico);

#15. Quais são as operações comuns à montagem e aos técnicos?
SELECT O.Designação FROM Operações O JOIN TénicosOperações Op ON O.Id = Op.Operações 
									 JOIN Montagem M ON O.Id = M.Operação;
                                     
#16. Quais são os nomes dos técnicos que trabalharam em operações com custo > 20€ em aparelhos com preço > 100€?
SELECT DISTINCT T.nome FROM Tecnicos T JOIN TécnicosOperações OP ON T.Id = Op.Técnico
							  JOIN Montagem M ON M.Operação = Op.Operação
                              JOIN Aparelhos A ON A.Id = M.Aparelho
                              WHERE M.custo > 20 AND A.PreçoVenda > 100;
                              
# Quais são os aparelhos que utilizam peças da família 1 e também da família 2?
SELECT DISTINCT A.Designação FROM Aparaelhos A JOIN Montagem M ON M.Aparelho = A.Id
											   JOIN Peças P ON P.Id = M.Peça
                                               WHERE P.Familia IN (1,2)
                                               GROUP BY A.Id, A.Designacao
                                               HAVING COUNT(DISTINCT P.Familia) = 2;

# Quais são os técnicos que NÃO trabalharam em operações com custo > 30€?
SELECT DISTINCT T.Nome FROM Técnicos T WHERE NOT EXISTS( SELECT * FROM TécnicosOperações Op
														JOIN Montagem M on M.Operação = Op.Operação
                                                        WHERE Op.Técnico = T.Id AND M.Custo > 30);

# Quantas peças existem?
SELECT COUNT(Id) FROM Peças;

# Quais são os aparelhos cuja quantidade total produzida é superior a 100?
SELECT A.Designação FROM Aparelhos A JOIN Produção P ON P.Aparelho = A.Id
									 GROUP BY A.Id, A.Designação
                                     HAVING SUM(P.Quantidade) > 100;

# Qual o custo médio das montagens de cada peça, mostrando as peças com maiores médias primeiro?
SELECT P.Designação, AVG(M.Custo) FROM Peças P JOIN Montagem M ON M.Peça = P.Id
									GROUP BY P.Id, P.Designação
									ORDER BY AVG(M.Custo) DESC;

# Quais são os técnicos que participaram em montagens de aparelhos cuja produção total é superior a 100?

SELECT DISTINCT T.Nome FROM Técnicos T JOIN TécnicosOperações Op ON Op.Técnico = T.Id
									   JOIN Montagem M ON M.Operação = Op.Operação
									   JOIN Aparelhos A ON M.Aparelho = A.Id
                                       JOIN Producao P ON P.Aparelho = A.Id
                                       GROUP BY T.Id, T.Nome, A.Id
                                       HAVING SUM(P.Quantidade) > 100;