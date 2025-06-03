-- 1. Consulte os nomes dos clientes e as datas dos pedidos, para os clientes que têm pedidos, ordenado por nome do cliente.
SELECT
    c.nome_cliente,
    p.data_pedido
FROM
    CLIENTES c
INNER JOIN
    PEDIDOS p ON c.id_cliente = p.id_cliente
ORDER BY
    c.nome_cliente;

-- 2. Consulte os nomes de clientes que não possuem pedidos.
SELECT
    c.nome_cliente
FROM
    CLIENTES c
LEFT JOIN -- Retorna todos os clientes
    PEDIDOS p ON c.id_cliente = p.id_cliente
WHERE -- Filtra para mostrar apenas clientes que não possuem pedidos
    p.id_pedido IS NULL;

-- 3. Consulte os nomes de clientes que fizeram pedidos em 2023.
SELECT DISTINCT
    c.nome_cliente
FROM
    CLIENTES c
INNER JOIN
    PEDIDOS p ON c.id_cliente = p.id_cliente
WHERE
    YEAR(p.data_pedido) = 2023;

-- 4. Consulte o número de pedidos por cliente, incluindo clientes que não fizeram pedidos.
SELECT
    c.nome_cliente,
    COUNT(p.id_pedido) AS total_pedidos
FROM
    CLIENTES c
LEFT JOIN
    PEDIDOS p ON c.id_cliente = p.id_cliente
GROUP BY -- Agrupa por id e nome de cliente
    c.id_cliente, c.nome_cliente;

-- 5. Consulte os nomes dos clientes, os seus ids de pedidos e o número de itens de cada pedido, exibindo apenas o número de itens maiores que dois e ordenado por cliente descendente.
SELECT
    c.nome_cliente,
    p.id_pedido,
    COUNT(i.id_item) AS total_itens
FROM
    CLIENTES c
INNER JOIN
    PEDIDOS p ON c.id_cliente = p.id_cliente
INNER JOIN
    ITENS i ON p.id_pedido = i.id_pedido
GROUP BY
    c.nome_cliente, p.id_pedido
HAVING
    COUNT(i.id_item) > 2
ORDER BY
    c.nome_cliente DESC;

-- 6. Consulte os nomes dos clientes, os seus ids de pedidos, data do pedido e o valor total de cada pedido, exibindo apenas pedidos com valores maiores que 100 e ordenado por valor do pedido.
SELECT
    c.nome_cliente,
    p.id_pedido,
    p.data_pedido,
    SUM(pr.preco_produto * i.quantidade) AS valor_total -- valor total de cada pedido
FROM
    CLIENTES c
INNER JOIN
    PEDIDOS p ON c.id_cliente = p.id_cliente
INNER JOIN
    ITENS i ON p.id_pedido = i.id_pedido
INNER JOIN -- Conecta clientes, pedidos, itens e produtos
    PRODUTOS pr ON i.id_produto = pr.id_produto
GROUP BY
    c.nome_cliente, p.id_pedido, p.data_pedido
HAVING -- Exibir apenas valores acima de 100
    valor_total > 100
ORDER BY
    valor_total;

-- 7. Consulte o valor total de pedidos em 2023.
SELECT
    SUM(pr.preco_produto * i.quantidade) AS valor_total_2023 -- Calcula o valor total de pedidos
FROM
    PEDIDOS p
INNER JOIN
    ITENS i ON p.id_pedido = i.id_pedido
INNER JOIN
    PRODUTOS pr ON i.id_produto = pr.id_produto
WHERE -- Filtra os pedidos por ano
    YEAR(p.data_pedido) = 2023;

-- 8. Consulte os nomes dos produtos e o valor total vendido de cada um, ordenado por nome do produto.
SELECT
    pr.nome_produto,
    SUM(pr.preco_produto * i.quantidade) AS valor_total_vendido
FROM
    PRODUTOS pr
INNER JOIN
    ITENS i ON pr.id_produto = i.id_produto
GROUP BY
    pr.nome_produto
ORDER BY
    pr.nome_produto;

-- 9. Consulte os nomes dos produtos e o valor total vendido de cada um, e exibir apenas os produtos com vendas acima de 100, ordenado por nome do produto.
SELECT
    pr.nome_produto,
    SUM(pr.preco_produto * i.quantidade) AS valor_total_vendido
FROM
    PRODUTOS pr
INNER JOIN
    ITENS i ON pr.id_produto = i.id_produto
GROUP BY
    pr.nome_produto
HAVING
    valor_total_vendido > 100
ORDER BY
    pr.nome_produto;

-- 10. Consulte os nomes dos produtos que não foram vendidos.
SELECT
    pr.nome_produto
FROM
    PRODUTOS pr
LEFT JOIN -- Conecta todos os registros de produtos e itens, ou seja, todos que participaram da venda
    ITENS i ON pr.id_produto = i.id_produto
WHERE -- Filtra apenas produtos que não foram vendidos
    i.id_item IS NULL;

-- 11. Consulte os nomes dos fornecedores e os nomes dos produtos fornecidos.
SELECT
    f.nome_fornecedor,
    pr.nome_produto
FROM
    FORNECEDORES f
INNER JOIN
    FORNECEDOR_PRODUTO fp ON f.id_fornecedor = fp.id_fornecedor
INNER JOIN
    PRODUTOS pr ON fp.id_produto = pr.id_produto
ORDER BY -- Ordena por nome do fornecedor e nome do produto
    f.nome_fornecedor, pr.nome_produto;

-- 12. Consulte os nomes dos produtos que não têm fornecedores.
SELECT
    pr.nome_produto
FROM
    PRODUTOS pr
LEFT JOIN -- Conecta produtos com fornecedores de produtos
    FORNECEDOR_PRODUTO fp ON pr.id_produto = fp.id_produto
WHERE -- Filtra produtos que não tem fornecedor associado
    fp.id_fornecedor IS NULL;

-- 13. Consulte o número de fornecedores de cada produto.
SELECT
    pr.nome_produto,
    COUNT(fp.id_fornecedor) AS total_fornecedores
FROM
    PRODUTOS pr
LEFT JOIN -- Conecta produtos com fornecedores de produtos
    FORNECEDOR_PRODUTO fp ON pr.id_produto = fp.id_produto
GROUP BY -- Agrupa por id e nome de produto
    pr.id_produto, pr.nome_produto
ORDER BY
    pr.nome_produto;

-- 14. Consulte os produtos que tem mais de um fornecedor.
SELECT
    pr.nome_produto,
    COUNT(fp.id_fornecedor) AS total_fornecedores
FROM
    PRODUTOS pr
INNER JOIN -- Conecta produtos com fornecedores
    FORNECEDOR_PRODUTO fp ON pr.id_produto = fp.id_produto
GROUP BY -- Agrupa por id e nome de produto
    pr.id_produto, pr.nome_produto
HAVING -- Filtra apenas produtos que possuem mais de um fornecedor
    COUNT(fp.id_fornecedor) > 1
ORDER BY -- Ordena por nome de produto
    pr.nome_produto;

-- 15. Consulte o número de produtos fornecidos por cada fornecedor.
SELECT
    f.nome_fornecedor,
    COUNT(fp.id_produto) AS total_produtos
FROM
    FORNECEDORES f
INNER JOIN
    FORNECEDOR_PRODUTO fp ON f.id_fornecedor = fp.id_fornecedor
GROUP BY
    f.id_fornecedor, f.nome_fornecedor
ORDER BY
    f.nome_fornecedor;

-- 16. Consulte o valor total de pedidos para cada ano.
SELECT
    YEAR(p.data_pedido) AS ano,
    SUM(pr.preco_produto * i.quantidade) AS valor_total_ano
FROM
    PEDIDOS p
INNER JOIN
    ITENS i ON p.id_pedido = i.id_pedido
INNER JOIN
    PRODUTOS pr ON i.id_produto = pr.id_produto
GROUP BY
    ano
ORDER BY
    ano;

-- 17. Consulte o valor total de pedidos para cada ano e cada mês.
SELECT
    YEAR(p.data_pedido) AS ano,
    MONTH(p.data_pedido) AS mes,
    SUM(pr.preco_produto * i.quantidade) AS valor_total_mensal
FROM
    PEDIDOS p
INNER JOIN
    ITENS i ON p.id_pedido = i.id_pedido
INNER JOIN
    PRODUTOS pr ON i.id_produto = pr.id_produto
GROUP BY
    ano, mes
ORDER BY
    ano, mes;
