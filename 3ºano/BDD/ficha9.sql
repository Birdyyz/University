# SAKILA
USE sakila;

#Cria um utilizador chamado user_leitura e outro chamado analista que apenas se
#podem ligar ao servidor MySQL a partir do localhost e define a palavra-passe de cada um como 1234.
CREATE USER 'user_leitura'@'localhost' IDENTIFIED BY '1234';

# Altera o user_leitura de forma a definir uma nova palavra-passe mais segura e expiração ao fim de 90 dias. 
ALTER USER 'user_leitura'@'localhost' IDENTIFIED BY '1234' PASSWORD EXPIRE INTERVAL 90 DAY;
#Escreve uma instrução SQL que permita listar todos os utilizadores existentes no sistema MySQL.
SELECT user, host FROM mysql.user;

# Cria duas roles com os nomes leitor e editor.
CREATE ROLE 'leitor';
DROP USER 'editor';
CREATE ROLE 'editor';

# Atribui a role leitor ao utilizador user_leitura
GRANT 'leitor' to 'user_leitura'@'localhost';

# Atribui permissões de leitura sobre toda a base de dados sakila à role leitor.
GRANT SELECT ON sakila.* TO 'leitor';

#Atribui à role editor permissões de leitura, inserção e atualização apenas nas tabelas customer e rental
GRANT SELECT, INSERT, UPDATE ON sakila.customer TO 'editor';
GRANT SELECT, INSERT, UPDATE ON sakila.rental   TO 'editor';

# Atribui a role editor ao utilizador analista
CREATE USER 'analista'@'localhost' IDENTIFIED BY '5678';
GRANT 'editor' TO 'analista'@'localhost';

# Define a role editor como role ativa por defeito do utilizador analista
SET DEFAULT ROLE 'editor' TO 'analista'@'localhost';

# Remove a permissão de atualização da role editor garantindo que deixa de poder alterar dados na tabela customer
REVOKE UPDATE ON sakila.customer FROM 'editor';

#Cria uma view chamada vw_clientes que apresente o identificador do cliente, o primeiro nome, o último nome e o email a partir da tabela customer
CREATE VIEW vw_clientes AS SELECT customer_id,first_name,last_name,email FROM customer;
SELECT * FROM vw_clientes;

#Cria uma view chamada vw_filmes que apresente o título do filme e a respetiva categoria utilizando as tabelas necessárias
CREATE VIEW vw_filmes AS SELECT F.title, C.name FROM film F JOIN film_category FM ON FM.film_id = F.film_id
															JOIN Category C ON C.category_id = FM.category_id;
SELECT * FROM vw_filmes;

# Cria uma view chamada vw_rentals_ativos que mostre todos os alugueres que ainda não foram devolvidos
CREATE VIEW vw_rentals_ativos AS SELECT R.rental_id FROM rental R WHERE R.return_date IS NULL;
SELECT * FROM vw_rentals_ativos;

#Cria uma view chamada vw_top_clientes que apresente o identificador do cliente, o nome e o número total de alugueres realizados, ordenando do maior para o menor
CREATE VIEW vw_top_clientes AS SELECT C.customer_id,C.first_name,C.last_name, COUNT(R.rental_id) AS total_alugueres FROM customer C
												JOIN rental R ON R.customer_id = C.customer_id
                                                GROUP BY C.customer_id,C.first_name,C.last_name ORDER BY total_alugueres DESC;
SELECT * FROM vw_top_clientes;

# Cria uma role chamada relatorio e atribui-lhe permissões de leitura apenas sobre a view vw_clientes. De seguida, atribui essa role ao utilizador viewer.
CREATE ROLE 'relatorio';
GRANT SELECT ON sakila.vw_clientes TO 'relatorio';
CREATE USER 'viewer'@'localhost' IDENTIFIED BY '9101112';
GRANT 'relatorio' TO 'viewer'@'localhost';