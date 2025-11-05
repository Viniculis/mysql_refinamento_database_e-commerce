-- Mostre o nome e contato de todos os fornecedores cadastrados.
SELECT SocialName, Contact FROM supplier;

-- Mostre os pedidos com valor de envio (sendValue) superior a 50.
SELECT * FROM orders WHERE sendValue > 50;

-- Liste os nomes dos produtos e suas quantidades em cada pedido.
SELECT p.pname, po.poQuantity AS Quantidade 
FROM productOrder po INNER JOIN product p
ON po.idPOproduct = p.idproduct;

-- Mostre a quantidade total de produtos disponíveis nos estoques do rio de janeiro (productStorage), somando todos.
SELECT SUM(quantity) AS Total_Produtos_Rio_de_Janeiro
FROM productStorage 
WHERE storageLocation = 'Rio de Janeiro'
GROUP BY storageLocation;

-- Mostre o número total de pedidos por status (ex: quantos “Confirmado”, “Cancelado”, etc).
SELECT orderStatus, COUNT(*) AS totalPedidos 
FROM orders 
GROUP BY orderStatus;

-- Mostre o produto mais vendido (com maior soma de poQuantity em productOrder).
SELECT p.pName, SUM(po.poQuantity) AS Total_Vendas
FROM productOrder po INNER JOIN product p
ON po.idPOproduct = p.idProduct
GROUP BY p.idProduct
ORDER BY Total_Vendas DESC LIMIT 1;

-- Exiba o nome do cliente, o status do pedido, e uma coluna extra chamada Envio, com: 
-- 'Frete grátis' se sendValue = 0
-- 'Pago' se sendValue > 0
-- (CASE WHEN sendValue = 0 THEN ...)
SELECT CONCAT(c.fname, ' ', c.minit, ' ', c.lname) AS ClientName, o.orderStatus, 
CASE 
WHEN sendValue = 0 OR sendValue IS NULL THEN 'Grátis'
WHEN sendValue > 0 THEN 'Pago' 
END AS Envio
FROM orders o INNER JOIN clients c
ON o.idorderclient = c.idclient
ORDER BY o.orderStatus DESC;

-- Liste o nome dos clientes que ainda não fizeram nenhum pedido.
SELECT CONCAT(c.Fname, ' ', c.Minit, ' ', c.Lname) AS Clientes_sem_Pedidos
FROM orders o RIGHT JOIN clients c
ON o.idOrderClient = c.idClient
WHERE o.idOrderClient IS NULL;

-- Liste os nomes dos fornecedores que fornecem pelo menos 2 produtos diferentes.
SELECT s.SocialName
FROM supplier s INNER JOIN productSupplier p
ON s.idSupplier = p.idPsSupplier
GROUP BY p.idPsSupplier
HAVING COUNT(p.idPsSupplier) >= 2;
