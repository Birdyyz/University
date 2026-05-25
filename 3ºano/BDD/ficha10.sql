USE sakila;

# Cria um índice na coluna payment_date da tabela payment
ALTER TABLE payment ADD COLUMN payment_date DATE;

# Cria um prepared statement que devolve o nome dos clientes de cada loja. Executa o prepared statement para a loja 1.
PREPARE nome_clientes1 FROM 'SELECT first_name,last_name FROM customer WHERE store_id =? ';
SET @loja = 1;
EXECUTE nome_clientes1 USING @loja;
DEALLOCATE PREPARE nome_clientes1;

# Cria um procedimento chamado filmes_por_categoria que recebe o ID de uma categoria
# e devolve os títulos dos filmes dessa categoria. Executa o procedimento para uma categoria à tua escolha.
DELIMITER $$
CREATE PROCEDURE filmes_por_categoria(IN p_categoria_id INT)
BEGIN
    SELECT f.title
    FROM film f
    JOIN film_category fc ON f.film_id = fc.film_id
    WHERE fc.category_id = p_categoria_id;
END $$
DELIMITER ;

# Cria um procedimento que recebe um customer_id e devolve a data do último pagamento
DELIMITER $$
CREATE PROCEDURE ultimo_pagamento(IN c_customer_id INT)
BEGIN
    SELECT 
        MAX(payment_date) AS ultimo_pagamento
    FROM payment
    WHERE customer_id = c_customer_id;
END $$
DELIMITER ;

# Cria uma função total_filmes_ator que recebe um o ID de um ator e devolve o número de filmes desse ator.
# Executa a função para um ator à tua escolha
DELIMITER $$
CREATE FUNCTION total_filmes_ator(a_actor_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT COUNT(film_id)
    INTO total
    FROM film_actor
    WHERE actor_id = a_actor_id;
    RETURN total;
END $$
DELIMITER ;

# Cria um trigger que, após a inserção de um novo registo na tabela payment, atualize automaticamente o campo total_spent na tabela
# customer, somando o valor (amount) do pagamento ao total já existente do respetivo cliente.

DELIMITER $$

CREATE TRIGGER atualiza_total_spent
AFTER INSERT ON payment
FOR EACH ROW
BEGIN
    UPDATE customer
    SET total_spent = total_spent + NEW.amount
    WHERE customer_id = NEW.customer_id;
END $$

DELIMITER ;

# Cria uma transação que atualiza um cliente para active = 1 e insere um pagamento
START TRANSACTION;

UPDATE customer
SET active = 1
WHERE customer_id = 5;

INSERT INTO payment (customer_id, staff_id, rental_id, amount, payment_date)
VALUES (5, 1, NULL, 10.00, NOW());

COMMIT;

START TRANSACTION;

# Cria uma transação que faz update de um cliente mas utiliza ROLLBACK
UPDATE customer
SET active = 0
WHERE customer_id = 10;
ROLLBACK;
