CREATE DATABASE IF NOT EXISTS ecommerce;
USE ecommerce;

DROP TABLE IF EXISTS fornecedor_produto;
DROP TABLE IF EXISTS itens;
DROP TABLE IF EXISTS pedidos;
DROP TABLE IF EXISTS produtos;
DROP TABLE IF EXISTS fornecedores;
DROP TABLE IF EXISTS clientes;

-- Cria a tabela clientes
CREATE TABLE IF NOT EXISTS CLIENTES (
    id_cliente       INT PRIMARY KEY AUTO_INCREMENT,
    nome_cliente     VARCHAR(255) NOT NULL,
    email            VARCHAR(255) NOT NULL,
    telefone         VARCHAR(20) NOT NULL UNIQUE,
    endereco         VARCHAR(255) NOT NULL
);

-- Cria a tabela PEDIDOS
CREATE TABLE IF NOT EXISTS PEDIDOS (
    id_pedido        INT PRIMARY KEY AUTO_INCREMENT,
    data_pedido      DATETIME NOT NULL,
    id_cliente       INT NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES CLIENTES(id_cliente)
);

CREATE TABLE IF NOT EXISTS PRODUTOS (
    id_produto           INT PRIMARY KEY AUTO_INCREMENT,
    nome_produto         VARCHAR(255) NOT NULL,
    descricao_produto    VARCHAR(255) NOT NULL,
    preco_produto        DECIMAL(10, 2) NOT NULL
);

-- Cria a tabela ITENS
CREATE TABLE IF NOT EXISTS ITENS (
    id_item          INT PRIMARY KEY AUTO_INCREMENT,
    id_pedido        INT NOT NULL,
    id_produto       INT NOT NULL,
    quantidade       INT NOT NULL CHECK (quantidade > 0),
    FOREIGN KEY (id_pedido)  REFERENCES PEDIDOS(id_pedido),
    FOREIGN KEY (id_produto) REFERENCES PRODUTOS(id_produto)
);

-- Cria a tabela FORNECEDORES
CREATE TABLE IF NOT EXISTS FORNECEDORES (
    id_fornecedor     INT PRIMARY KEY AUTO_INCREMENT,
    nome_fornecedor   VARCHAR(255) NOT NULL
);

-- Cria a tabela FORNECEDOR_PRODUTO
CREATE TABLE IF NOT EXISTS FORNECEDOR_PRODUTO (
    id_fornecedor     INT NOT NULL,
    id_produto        INT NOT NULL,
    PRIMARY KEY (id_fornecedor, id_produto),
    FOREIGN KEY (id_fornecedor) REFERENCES FORNECEDORES(id_fornecedor),
    FOREIGN KEY (id_produto)    REFERENCES PRODUTOS(id_produto)
); 

-- Insere dados a tabela CLIENTES
INSERT INTO CLIENTES (nome_cliente, email, telefone, endereco) VALUES
('Cliente 1', 'cliente1@email.com', '(90) 99999-9999', 'Rua Sqlítio, 12, São Paulo'),
('Cliente 2', 'cliente2@email.com', '(91) 88888-8888', 'Av. Brasil, 350, Rio de Janeiro'),
('Cliente 3', 'cliente3@email.com', '(92) 77777-7777', 'Paço da Liberdade, 16, Manaus'),
('Cliente 4', 'cliente4@email.com', '(93) 66666-6666', 'Avenida das Torres, 184, Manaus'),
('Cliente 5', 'cliente5@email.com', '(94) 55555-5555', 'Sítio Pomodoro, 25, Xique Xique');


-- Insere dados a tabela PRODUTOS
INSERT INTO PRODUTOS (nome_produto, descricao_produto, preco_produto) VALUES
('Produto1', 'Descrição do Produto1', 19.99),
('Produto2', 'Descrição do Produto2', 39.99),
('Produto3', 'Descrição do Produto3', 59.99),
('Produto4', 'Descrição do Produto4', 24.99),
('Produto5', 'Descrição do Produto5', 9.99),
('Produto6', 'Descrição do Produto6', 99.99),
('Produto7', 'Descrição do Produto7', 199.99);

-- Insere dados a tabela PEDIDOS
INSERT INTO PEDIDOS (data_pedido, id_cliente) VALUES
('2022-12-17', 1),
('2022-12-26', 2),
('2023-01-27', 3),
('2023-02-14', 4),
('2023-01-14', 1),
('2023-02-14', 2);

-- Insere dados a tabela ITENS

INSERT INTO ITENS (id_pedido, id_produto, quantidade) VALUES
(1, 1, 2),
(1, 3, 1),
(2, 2, 1),
(3, 4, 3),
(3, 5, 5),
(3, 6, 2),
(4, 1, 1),
(4, 2, 1),
(4, 4, 2),
(4, 5, 3),
(5, 3, 1),
(6, 1, 1);

-- Insere dados a tabela FORNECEDORES
-- INSERTS: FORNECEDORES
INSERT INTO FORNECEDORES (nome_fornecedor) VALUES
('Fornecedor1'),
('Fornecedor2'),
('Fornecedor3'),
('Fornecedor4');

-- Insere dados a tabela FORNECEDOR_PRODUTO
INSERT INTO FORNECEDOR_PRODUTO (id_fornecedor, id_produto) VALUES
(1, 1), (1, 2), (1, 4),
(2, 3), (2, 4), (2, 5),
(3, 1), (3, 3), (3, 6);