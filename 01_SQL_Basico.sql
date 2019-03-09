-- ========== PRIMEIRA CONSULTA ========== 

-- Tente escrever sua própria consulta para selecionar apenas as colunas id, account_id e occurred_at para todos os pedidos na tabela orders. 
SELECT id, account_id, occurred_at
FROM orders



-- ========== LIMIT ========== 

-- Tente você mesmo(a) abaixo escrevendo uma consulta que limita a resposta a apenas as 15 primeiras linhas e inclua os campos occurred_at, account_id e channel na tabela web_events. 
SELECT occurred_at, account_id, channel
FROM web_events
LIMIT 15;



-- ========== ORDER BY ========== 

-- 1 - Escreva uma consulta que retorna os 10 primeiros pedidos na tabela orders. Inclua id, occurred_at e total_amt_usd. 
SELECT id, occurred_at, total_amt_usd
FROM orders
ORDER BY occurred_at
LIMIT 10;

-- 2 - Escreva uma consulta para retornar os top 5 pedidos ordenados pelo maior total_amt_usd. Inclua id, account_id e total_amt_usd. 
SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY total_amt_usd DESC 
LIMIT 5;

-- 3 - Escreva uma consulta para retornar os últimos 20 pedidos ordenados pelo menor total. Inclua id, account_id e total. 
SELECT id, account_id, total
FROM orders
ORDER BY total
LIMIT 20;



-- ========== WHERE ========== 

-- 1 - Puxe as primeiras 5 linhas e todas as colunas da tabela orders que possuem uma quantia em dólares de gloss_amt_usd maior que ou igual a 1000. 
SELECT *
FROM orders
WHERE gloss_amt_usd >= 1000
LIMIT 5;

-- 2 - Puxe as primeiras 10 linhas e todas as colunas da tabela orders que possuem uma total_amt_usd menor que 500. 
SELECT *
FROM orders
WHERE total_amt_usd < 500
LIMIT 10;



-- ========== WHERE com dados não numéricos ========== 

-- Filtre a tabela de contas para incluir o name(nome) da empresa, o website o ponto inicial de contato (primary_poc) para Exxon Mobil na tabela accounts. 
SELECT name, website, primary_poc
FROM accounts
WHERE name = 'Exxon Mobil';



-- ========== Operadores aritméticos ========== 

-- 1 - Crie uma coluna que divida a standard_amt_usd pela standard_qty para encontrar o preço por unidade para papel padrão em cada pedido. Limite os resultados para os 10 primeiros pedidos e inclua os campos id e account_id. 
SELECT id, account_id, standard_amt_usd/standard_qty AS unit_price
FROM orders
LIMIT 10;

-- 2 - Escreva uma consulta que encontra a percentagem de receita que vem de papel pôster para cada pedido. Você vai precisar usar apenas as colunas que terminam com _usd. (Tente fazer isso sem usar a coluna de total). Inclua os campos id e account_id. OBSERVAÇÃO - você receberá um erro com a solução correta para essa pergunta. Este erro ocorre pois acontece uma divisão por zero. Você vai aprender como chegar a uma solução sem um erro para essa consulta quando você aprender sobre declarações CASE em uma seção, mais a frente. Por enquanto, você pode só adicionar algum valor muito pequeno ao seu denominador como uma solução alternativa. 
SELECT id, account_id, 
       poster_amt_usd/(standard_amt_usd + gloss_amt_usd + poster_amt_usd) AS post_per
FROM orders;



-- ========== LIKE ========== 

-- 1 - Todas as empresas cujos nomes começam com 'C'. 
SELECT name
FROM accounts
WHERE name LIKE 'C%';

-- 2 - Todas as empresas que possuem a string 'one' em algum lugar no nome. 
SELECT name
FROM accounts
WHERE name LIKE '%one%';

-- 3 - Todas as empresas cujos nomes terminam com 's'. 
SELECT name
FROM accounts
WHERE name LIKE '%s';



-- ========== IN ========== 

-- 1 - Use a tabela accounts para encontrar o name, primary_poc e sales_rep_id da conta para Walmart, Target e Nordstrom. 
SELECT name, primary_poc, sales_rep_id
FROM accounts
WHERE name IN ('Walmart', 'Target', 'Nordstrom');

-- 2 - Use a tabela web_events para encontrar todas as informações sobre indivíduos que foram contactados pelo channel organic ou adwords. 
SELECT *
FROM web_events
WHERE channel IN ('organic', 'adwords');



-- ========== NOT ========== 

-- 1 - Use a tabela accounts para encontrar o nome da conta, contato primário e id de representante de vendas para todas as lojas exceto Walmart, Target e Nordstrom. 
SELECT name, primary_poc, sales_rep_id
FROM accounts
WHERE name NOT IN ('Walmart', 'Target', 'Nordstrom');

-- 2 - Use a tabela web_events para encontrar todas as informações sobre indivíduos que foram contactados por quaisquer métodos, exceto os métodos organic ou adwords. 
SELECT *
FROM web_events
WHERE channel NOT IN ('organic', 'adwords');

-- Use a tabela accounts para descobrir:

3 - Todas as empresas cujos nomes não começam com 'C'. 
SELECT name
FROM accounts
WHERE name NOT LIKE 'C%';

-- 4 - Todas as empresas que não possuem a string 'one' em nenhum lugar no nome. 
SELECT name
FROM accounts
WHERE name NOT LIKE '%one%';

-- 5 - Todas as empresas cujos nomes não terminam com 's'. 
SELECT name
FROM accounts
WHERE name NOT LIKE '%s';



-- ========== AND e BETWEEN ==========

-- 1 - Escreva uma consulta que retorna todos os pedidos nos quais standard_qty é maior que 1000, a poster_qty é 0, e a gloss_qty é 0. 
SELECT *
FROM orders
WHERE standard_qty > 1000 AND poster_qty = 0 AND gloss_qty = 0;


-- 2 - Usando a tabela accounts encontre todas as empresas cujos nomes não começam com 'C' e terminam com 's'. 
SELECT name
FROM accounts
WHERE name NOT LIKE 'C%' AND name LIKE '%s';


-- 3 - Use a tabela web_events para encontrar todas as informações sobre indivíduos que foram contactados via organic ou adwords e começaram suas contas em qualquer momento em 2016, do mais recente ao mais antigo. 
SELECT *
FROM web_events
WHERE channel IN ('organic', 'adwords') AND occurred_at >= '2016-01-01' AND occurred_at < '2017-01-01'
ORDER BY occurred_at DESC;

SELECT *
FROM web_events
WHERE channel IN ('organic', 'adwords') AND occurred_at BETWEEN '2016-01-01' AND '2017-01-01'
ORDER BY occurred_at DESC;



-- ========== OR ========== 

-- 1- Encontre lista de ids de pedidos nos quais gloss_qty or poster_qty são maiores que 4000. Inclua apenas o campo id na tabela resultante. 
SELECT id
FROM orders
WHERE gloss_qty > 4000 OR poster_qty > 4000;


-- 2 - Escreva uma consulta que retorna todos uma lista dos pedidos nos quais standard_qty é zero e ou gloss_qty ou poster_qty é maior que 1000.
SELECT *
FROM orders
WHERE standard_qty = 0 AND (gloss_qty > 1000 OR poster_qty > 1000);


-- 3 - Encontre todos os nomes de empresas que começam com um 'C' ou 'W', e o contato primário contém 'ana' or 'Ana', mas não contém 'eana'.
SELECT name
FROM accounts
WHERE (name LIKE 'C%' OR name LIKE 'W%') AND ((primary_poc LIKE '%ana%' OR primary_poc LIKE '%Ana%') AND primary_poc NOT LIKE '%eana%');
