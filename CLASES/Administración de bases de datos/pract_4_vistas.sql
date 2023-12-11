Listar vistas   \dv
DEFINICION      \d <nombre de vista>
modificar:

1. 
CREATE VIEW ClienteEstrella AS
SELECT COUNT(orders.order_id), customers.customer_id, customers.company_name,
customers.contact_name
FROM customers
INNER JOIN orders ON customers.customer_id = orders.customer_id
GROUP BY customers.customer_id
ORDER BY COUNT(orders.order_id) DESC
LIMIT 1;

2.
CREATE OR REPLACE VIEW ClienteEstrella AS
SELECT COUNT(orders.order_id), customers.customer_id, customers.company_name,
customers.contact_name,
customers.phone
FROM customers
INNER JOIN orders ON customers.customer_id = orders.customer_id
GROUP BY customers.customer_id
ORDER BY COUNT(orders.order_id) DESC
LIMIT 1;

3.
ALTER VIEW ClienteEstrella RENAME TO BestClient_Info;

5.
DROP VIEW IF EXISTS BestClient_Info;

6.
CREATE VIEW UK_Clients AS
SELECT 
  C.customer_id AS ID,
  C.country,
  C.city,
  C.postal_code
FROM 
  customers C
WHERE 
  C.country = 'UK';

8.
INSERT INTO uk_clients (ID, country, city, postal_code)
VALUES ('ASGBD', 'UK', 'Liverpool', 'ABC 123');

INSERT INTO customers (customer_id, company_name, country, city, postal_code)
VALUES ('ASGBD', 'Borja Moll', 'UK', 'Liverpool', 'ABC 123');

SELECT * FROM customers WHERE customer_id = 'ASGBD';

9.
DELETE FROM UK_Clients WHERE ID = 'ASGBD';

10.
CREATE MATERIALIZED VIEW TOP3_Countries AS
SELECT 
  country,
  COUNT(order_id) AS total_orders
FROM 
  orders
JOIN 
  customers ON orders.customer_id = customers.customer_id
GROUP BY 
  country
ORDER BY 
  total_orders DESC
LIMIT 3;

REFRESH MATERIALIZED VIEW TOP3_Countries;