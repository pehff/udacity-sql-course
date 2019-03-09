-- ========== primeira JOIN ==========

-- 1 - Tente puxar todos os dados da tabela accounts, e todos os dados da tabela orders.
SELECT accounts.*, orders.*
FROM accounts
JOIN orders
ON accounts.id = orders.account_id;

-- 2 - Tente puxar standard_qty, gloss_qty e poster_qty da tabela orders, e o site e o primary_poc da tabela accounts.
SELECT orders.standard_qty, orders.gloss_qty, orders.poster_qty, accounts.website, accounts.primary_poc
FROM orders
JOIN accounts
ON orders.account_id = accounts.id;



-- ========== Perguntas sobre JOINS - Parte 1 ==========

-- 1 - Forneça uma tabela com todos os web_events associados com o name (nome) de conta do Walmart. Deve haver três colunas. Tenha certeza de incluir a primary_poc, o horário do evento e o channel (canal) para cada evento. Além disso, você pode escolher adicionar uma quarta coluna para garantir que apenas eventos do Walmart sejam escolhidos.
SELECT a.primary_poc, w.occurred_at, w.channel, a.name
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
WHERE a.name = 'Walmart';

-- 2 - Forneça uma tabela que dê a region (região) para cada sales_rep (representante de vendas) junto de suas respectivas accounts (contas). Sua tabela final deve incluir três colunas: o nome da região, o nome do representante de vendas e o nome da conta. Organize as contas alfabeticamente (A-Z) de acordo com os nomes das contas.
SELECT r.name region, s.name rep, a.name account
FROM sales_reps s
JOIN region r
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
ORDER BY a.name;

-- 3 - Forneça o nome de cada região de cada pedido, bem como o nome da conta e o preço da unidade que pagaram (total_amt_usd/total) para o pedido. Sua tabela final deve ter 3 colunas: nome da região, nome da conta e preço da unidade. Algumas contas tem 0 como total, então eu dividi por (total + 0.01) para assegurar que não dividiríamos por zero.
SELECT r.name region, a.name account, 
       o.total_amt_usd/(o.total + 0.01) unit_price
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id;



-- ========== Última verificação ==========

-- 1 - Forneça uma tabela que dê a region (região) para cada sales_rep (representante de vendas) junto de suas respectivas accounts (contas). Desta vez apenas para a região Midwest. Sua tabela final deve incluir três colunas: o nome da região, o nome do representante de vendas e o nome da conta. Organize as contas alfabeticamente (A-Z) de acordo com os nomes das contas.
SELECT r.name region, s.name rep, a.name account
FROM sales_reps s
JOIN region r
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
WHERE r.name = 'Midwest'
ORDER BY a.name;

-- 2 - Forneça uma tabela que dê a region (região) para cada sales_rep (representante de vendas) junto de suas respectivas accounts (contas). Desta vez apenas para contas onde o representante de vendas tem um primeiro nome começando com S e na região Midwest. Sua tabela final deve incluir três colunas: o nome da região, o nome do representante de vendas e o nome da conta. Organize as contas alfabeticamente (A-Z) de acordo com os nomes das contas.
SELECT r.name region, s.name rep, a.name account
FROM sales_reps s
JOIN region r
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
WHERE r.name = 'Midwest' AND s.name LIKE 'S%'
ORDER BY a.name;

-- 3 - Forneça uma tabela que dê a region (região) para cada sales_rep (representante de vendas) junto de suas respectivas accounts (contas). Desta vez apenas para contas onde o representante de vendas tem um sobrenome começando com K e na região Midwest. Sua tabela final deve incluir três colunas: o nome da região, o nome do representante de vendas e o nome da conta. Organize as contas alfabeticamente (A-Z) de acordo com os nomes das contas.
SELECT r.name region, s.name rep, a.name account
FROM sales_reps s
JOIN region r
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
WHERE r.name = 'Midwest' AND s.name LIKE '% K%'
ORDER BY a.name;

-- 4 - Forneça o nome de cada região de cada pedido, bem como o nome da conta e o preço da unidade que pagaram (total_amt_usd/total) para o pedido. No entanto, você deve fornecer os resultados apenas se a standard order quantity (quantidade de pedido de padrão) exceder 100. Sua tabela final deve ter 3 colunas: nome da região, nome da conta e preço da unidade. A fim de evitar uma divisão por zero erro, adicionar .01 ao denominador aqui é útil total_amt_usd/(total+0.01).
SELECT r.name region, a.name account, o.total_amt_usd/(o.total + 0.01) unit_price
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
WHERE o.standard_qty > 100;

-- 5 - Forneça o nome de cada região de cada pedido, bem como o nome da conta e o preço da unidade que pagaram (total_amt_usd/total) para o pedido. Contudo, você deve fornecer os resultados apenas se a standard order quantity (quantidade de pedido de padrão) exceder 100 e a poster order quantity (quantidade de pedido de pôster) exceder 50. Sua tabela final deve ter 3 colunas: nome da região, nome da conta e preço da unidade. Classifique pelo menor unit price (preço de unidade) primeiro. A fim de evitar uma divisão por zero erro, adicionar .01 ao denominador aqui é útil total_amt_usd/(total+0.01).
SELECT r.name region, a.name account, o.total_amt_usd/(o.total + 0.01) unit_price
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
WHERE o.standard_qty > 100 AND o.poster_qty > 50
ORDER BY unit_price;

-- 6 - Forneça o nome de cada região de cada pedido, bem como o nome da conta e o preço da unidade que pagaram (total_amt_usd/total) para o pedido. Contudo, você deve fornecer os resultados apenas se a standard order quantity (quantidade de pedido de padrão) exceder 100 e a poster order quantity (quantidade de pedido de pôster) exceder 50. Sua tabela final deve ter 3 colunas: nome da região, nome da conta e preço da unidade. Classifique pelo maior unit price (preço de unidade) primeiro. A fim de evitar uma divisão por zero erro, adicionar .01 ao denominador aqui é útil total_amt_usd/(total+0.01).
SELECT r.name region, a.name account, o.total_amt_usd/(o.total + 0.01) unit_price
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
WHERE o.standard_qty > 100 AND o.poster_qty > 50
ORDER BY unit_price DESC;

-- 7 - Quais são os diferentes channels (canais) usados pela account id 1001? Sua tabela final deve ter apenas 2 colunas: account name e os diferentes channels. Você pode experimentar SELECT DISTINCT para restringir os resultados a apenas valores únicos.
SELECT DISTINCT a.name, w.channel
FROM accounts a
RIGHT JOIN web_events w
ON a.id = w.account_id
WHERE a.id = '1001';

-- 8 - Encontre todos os pedidos feitos em 2015. Sua tabela final deve ter 4 colunas: occurred_at, account name, order total e order total_amt_usd.
SELECT o.occurred_at, a.name, o.total, o.total_amt_usd
FROM accounts a
JOIN orders o
ON o.account_id = a.id
WHERE o.occurred_at BETWEEN '01-01-2015' AND '01-01-2016'
ORDER BY o.occurred_at DESC;