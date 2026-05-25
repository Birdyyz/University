-- ============================================================
--  BD-LCC-2526 | PL08 — Script de criação das tabelas MySQL
-- ============================================================

CREATE SCHEMA  entrega_comida;

USE entrega_comida;

-- ------------------------------------------------------------
-- Tabela: Estafeta
-- ------------------------------------------------------------
CREATE TABLE Estafeta (
    idEstafeta  INT          NOT NULL AUTO_INCREMENT,
    nome        VARCHAR(75)  NOT NULL,
    contacto    CHAR(9),
    PRIMARY KEY (idEstafeta)
) ENGINE=InnoDB;

-- ------------------------------------------------------------
-- Tabela: Cliente
-- ------------------------------------------------------------
CREATE TABLE Cliente (
    idCliente      INT           NOT NULL AUTO_INCREMENT,
    nome           VARCHAR(75)   NOT NULL,
    profissao      VARCHAR(75),
    rua            VARCHAR(100),
    localidade     VARCHAR(45),
    cod_postal     CHAR(8),
    cartao_credito VARCHAR(100),
    PRIMARY KEY (idCliente)
) ENGINE=InnoDB;

-- ------------------------------------------------------------
-- Tabela: Prato
-- ------------------------------------------------------------
CREATE TABLE Prato (
    idPrato       INT                              NOT NULL AUTO_INCREMENT,
    designacao    VARCHAR(75)                      NOT NULL,
    tempo_preparo INT,
    preco_dose    DECIMAL(5,2),
    tipo          ENUM('VEGANO', 'CARNE', 'PEIXE')  NOT NULL,
    PRIMARY KEY (idPrato)
) ENGINE=InnoDB;

-- ------------------------------------------------------------
-- Tabela: Pedido
-- ------------------------------------------------------------
CREATE TABLE Pedido (
    idPedido    INT            NOT NULL AUTO_INCREMENT,
    data_pedido DATETIME       NOT NULL,
    preco       DECIMAL(5,2),
    distancia   DECIMAL(4,2),
    suplemento  TINYINT(1)     DEFAULT 0,
    idCliente   INT            NOT NULL,
    idEstafeta  INT,                          -- NULL = estafeta ainda não atribuído
    PRIMARY KEY (idPedido),
    CONSTRAINT fk_pedido_cliente
        FOREIGN KEY (idCliente)  REFERENCES Cliente(idCliente),
    CONSTRAINT fk_pedido_estafeta
        FOREIGN KEY (idEstafeta) REFERENCES Estafeta(idEstafeta)
) ENGINE=InnoDB;

-- ------------------------------------------------------------
-- Tabela: Item_pedido  (relação N:M entre Pedido e Prato)
-- ------------------------------------------------------------
CREATE TABLE Item_pedido (
    idPedido INT           NOT NULL,
    idPrato  INT           NOT NULL,
    dose     DECIMAL(3,1),
    preco    DECIMAL(5,2),
    PRIMARY KEY (idPedido, idPrato),
    CONSTRAINT fk_item_pedido
        FOREIGN KEY (idPedido) REFERENCES Pedido(idPedido),
    CONSTRAINT fk_item_prato
        FOREIGN KEY (idPrato)  REFERENCES Prato(idPrato)
) ENGINE=InnoDB;



INSERT INTO Estafeta (idEstafeta, nome, contacto) VALUES
  (1, 'Ana Rodrigues',  '912345601'),
  (2, 'Carlos Meireles','923456702'),
  (3, 'João Almeida',   '934567803'),
  (4, 'Mariana Sousa',  '945678904');
  
  
INSERT INTO Cliente (idCliente, nome, profissao, rua, localidade, cod_postal, cartao_credito) VALUES
  (1, 'Beatriz Lima',    'Engenheira',  'Rua das Flores, 10',    'Braga',           '4700-001', '4111111111111111'),
  (2, 'Daniel Faria',    'Professor',   'Av. Central, 55',       'Braga',           '4715-120', '4222222222222222'),
  (3, 'Filipa Gomes',    'Médica',      'Rua do Comércio, 3',    'Guimarães',       '4800-050', '4333333333333333'),
  (4, 'Hugo Carvalho',   'Advogado',    'Rua Nova, 88',          'Viana do Castelo','4900-215', '4444444444444444'),
  (5, 'Inês Teixeira',   'Estudante',   'Beco do Sol, 2',        'Braga',           '4710-009', '4555555555555555'),
  (6, 'Luís Monteiro',   'Arquiteto',   'Rua das Amoreiras, 14', 'Lisboa',          '1000-001', NULL),   
  (7, 'Sofia Pinto',     'Jornalista',  'Av. Liberdade, 200',    'Porto',           '4050-313', NULL);
  
  INSERT INTO Prato (idPrato, designacao, tempo_preparo, preco_dose, tipo) VALUES
  (1, 'Salada de Grão com Legumes',  10, 5.50,  'VEGANO'),
  (2, 'Sopa de Abóbora e Gengibre',   8, 3.80,  'VEGANO'),
  (3, 'Bife de Vaca Grelhado',        20, 13.50, 'CARNE'),
  (4, 'Frango no Forno com Ervas',    35, 10.90, 'CARNE'),
  (5, 'Bacalhau à Brás',              25, 14.50, 'PEIXE'),
  (6, 'Salmão Grelhado com Limão',    18, 16.00, 'PEIXE');
  
  INSERT INTO Pedido (idPedido, data_pedido, preco, distancia, suplemento, idCliente, idEstafeta) VALUES
  ( 1, '2024-03-15 12:30:00', 46.00, 3.20, 0, 1, 1),
  ( 2, '2024-06-22 19:45:00', 29.80, 1.80, 0, 1, 2),
  ( 3, '2025-01-10 13:00:00', 22.50, 2.50, 1, 1, 3),
  ( 4, '2024-07-05 20:15:00', 13.20, 4.10, 0, 2, 1),
  ( 5, '2025-02-18 21:00:00', 43.50, 5.00, 1, 2, 4), 
  ( 6, '2023-11-12 18:30:00',  7.60, 1.20, 0, 3, NULL), 
  ( 7, '2025-03-05 12:45:00', 35.00, 3.80, 0, 3, 2),
  ( 8, '2024-08-30 20:00:00', 18.00, 2.30, 0, 4, NULL), 
  ( 9, '2025-04-01 13:30:00', 55.20, 6.50, 1, 4, 3), 
  (10, '2024-09-14 19:00:00', 11.50, 1.50, 0, 5, 4);
  
  INSERT INTO Item_pedido (idPedido, idPrato, dose, preco) VALUES
  -- Pedido 1: Bife + Salmão + Salada
  (1, 3, 1.0, 13.50),
  (1, 6, 1.0, 16.00),
  (1, 1, 2.0,  5.50),
  -- Pedido 2: Frango + Sopa
  (2, 4, 1.0, 10.90),
  (2, 2, 1.0,  3.80),
  -- Pedido 3: Bacalhau + Salada
  (3, 5, 1.0, 14.50),
  (3, 1, 1.0,  5.50),
  -- Pedido 4: Frango
  (4, 4, 1.0, 10.90),
  -- Pedido 5: Bife + Bacalhau + Salmão
  (5, 3, 1.0, 13.50),
  (5, 5, 1.0, 14.50),
  (5, 6, 1.0, 16.00),
  -- Pedido 6: Sopa
  (6, 2, 2.0,  3.80),
  -- Pedido 7: Salmão + Frango
  (7, 6, 1.0, 16.00),
  (7, 4, 1.0, 10.90),
  -- Pedido 8: Salada + Sopa
  (8, 1, 1.0,  5.50),
  (8, 2, 1.0,  3.80),
  -- Pedido 9: Bife + Bacalhau
  (9, 3, 2.0, 13.50),
  (9, 5, 1.0, 14.50),
  -- Pedido 10: Frango
  (10, 4, 1.0, 10.90);
  
# Liste o nome e o contacto de todos os estafetas, ordenados pelo nome de forma ascendente
SELECT Nome, Contacto FROM Estafeta ORDER BY Nome ASC;

# Apresente a designação e o preço por dose de todos os pratos do tipo 'entrada'.
SELECT designacao, preco_dose FROM Prato  WHERE Tipo = 'CARNE' ;

# Mostre os dados completos dos clientes cujo código postal começa por '47'
SELECT * FROM Cliente WHERE cod_postal LIKE '47%';

# Liste todos os pedidos cujo preço está entre 10€ e 50€, ordenados do mais caro para o mais barato. Apresente apenas os 3 mais caros.
SELECT * FROM Pedido WHERE preco BETWEEN 10 AND 50 ORDER BY preco DESC LIMIT 3;

# Liste os nomes únicos dos clientes que fizeram pelo menos um pedido depois de 1 de janeiro de 2024
SELECT DISTINCT C.nome FROM Cliente C JOIN Pedido P ON P.idCliente = C.idCliente WHERE data_pedido > '2024-01-01';

# Mostre a designação do prato, a dose e o preço de cada item de pedido, apenas para os pratos do tipo 'prato principal' ou 'sobremesa'
SELECT P.designacao, IP.dose, IP.preco FROM item_pedido IP JOIN Prato P ON IP.idPrato = P.idPrato;

# Apresente o nome do cliente, a data do pedido e o nome do estafeta, apenas para pedidos com estafeta atribuído e realizados durante o ano de 2025.
SELECT C.nome, P.data_pedido, E.nome FROM Cliente C JOIN Pedido P ON P.idCliente = C.idCliente
													JOIN Estafeta E ON P.idEstafeta = E.idEstafeta 
                                                    WHERE YEAR(P.data_pedido) = 2025;
# Quantos pedidos existem na base de dados? Apresente o resultado com o alias 'total_pedidos'
SELECT COUNT(idPedido) AS 'total_pedidos' FROM Pedido;

# Qual o preço médio e o preço máximo dos pratos? Use aliases 'preco_medio' e 'preco_maximo'. Arredonde a média a 2 casas decimais.
SELECT ROUND(AVG(preco_dose),2) AS 'preco_medio', MAX(preco_dose) AS 'preco_maximo' FROM Prato;

# Mostre o número de pedidos realizados por cada cliente. Apresente apenas os clientes com mais de 1 pedido.
SELECT C.nome, COUNT(P.idPedido) FROM Pedido P JOIN Cliente C ON C.idCliente = P.idCliente
								     GROUP BY C.nome HAVING COUNT(P.idPedido) > 1;
#  Apresente o valor total faturado por cada estafeta, com o nome do estafeta. Ordene do maior para o menor.
SELECT E.nome, SUM(P.preco) FROM Estafeta E JOIN Pedido P ON  P.idEstafeta = E.idEstafeta
											GROUP BY E.nome  ORDER BY SUM(P.preco) DESC;

# Mostre os dados dos clientes que nunca realizaram nenhum pedido.
SELECT C.*  FROM Cliente C  LEFT JOIN Pedido P ON C.idCliente = P.idCliente WHERE P.idPedido IS NULL;

# Apresente os pratos que já foram incluídos em algum pedido
SELECT DISTINCT Pr.designacao FROM Prato Pr JOIN item_pedido IP ON PR.idPrato = IP.idPrato;

# Apresente uma lista única com as localidades de todos os clientes e as localidades de todos os pedidos. Elimine duplicados
SELECT DISTINCT C.localidade FROM Cliente C JOIN Pedido P ON C.idCliente = P.idCliente;

