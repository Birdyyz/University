# Quais são os pacientes que não registaram qualquer consulta? (a solução deve usar o operador EXISTS ou NOT EXISTS)
SELECT *
FROM PACIENTE p 
WHERE NOT EXISTS (
    SELECT 1
    FROM CONSULTA c
    WHERE c.id_paciente = p.id_paciente);
    
    
# Quais são os pacientes que não foram a qualquer consulta em 2024?
SELECT p.* FROM PACIENTE p LEFT JOIN CONSULTA c ON p.id_paciente = c.id_paciente 
    AND YEAR(c.data_hora) = 2024 WHERE c.id_paciente IS NULL;

# Quais são as médias de idade dos médicos por especialidade (considere o id_medico suficiente para caracterizar o médico)
SELECT E.designacao, AVG(M.id_medico) AS media_espec FROM MEDICO M JOIN ESPECIALIDADE E
									ON M.especialiadade = E.id_especialidade
                                    GROUP BY E.designacao;
                                    
# Qual é o nome e a idade do(s) médico(s) que deu(deram) o maior número de consultas em 2024?
SELECT 
    M.nome,
    M.idade,
    COUNT(C.data_hora) AS consultas
FROM medico M
JOIN consulta C ON M.id_medico = C.id_medico
WHERE YEAR(C.data_hora) = 2024
GROUP BY M.id_medico, M.nome, M.idade
ORDER BY consultas DESC
LIMIT 1;

# Apresente o número de médicos diferentes que deram consultas em 2024 por cada especialidade
SELECT 
    e.nome_especialidade,
    COUNT(DISTINCT c.id_medico) AS medicos_ativos_2024
FROM consulta c
JOIN medico m ON c.id_medico = m.id_medico
JOIN especialidade e ON m.id_especialidade = e.id_especialidade
WHERE YEAR(c.data_hora) = 2024
GROUP BY e.nome_especialidade;

# Qual é o nome dos pacientes que já foram a consultas de todas as especialidades?
SELECT p.nome
FROM paciente p
JOIN consulta c ON p.id_paciente = c.id_paciente
JOIN medico m ON c.id_medico = m.id_medico
JOIN especialidade e ON m.id_especialidade = e.id_especialidade
GROUP BY p.id_paciente, p.nome
HAVING COUNT(DISTINCT e.id_especialidade) = (
    SELECT COUNT(*) FROM especialidade
);
/*
ontem() é uma função que recebe como parâmetro uma data e verifica se essa data corresponde ao dia de
ontem. Devolve o valor TRUE ou FALSE.
Admitindo que a função ontem() já está implementada no sistema de base de dados, escreva o comando
SQL necessário para responder à seguinte questão:
Quais foram os pacientes que residem em Braga que tiveram consulta ontem com o médico
Jorge Sousa?
*/
SELECT p.nome
FROM paciente p
JOIN consulta c ON p.id_paciente = c.id_paciente
JOIN medico m ON c.id_medico = m.id_medico
WHERE p.cidade = 'Braga'
  AND m.nome = 'Jorge Sousa'
  AND ontem(c.data_hora) = TRUE;
