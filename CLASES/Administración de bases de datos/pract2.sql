3-------------------
create table countries (
  countries_id varchar(25) primary key,
  countries_name varchar(50),
  region_id int,
  foreign key (region_id) references region(region_id)
);

4------------

select
	count(*)
from
	customers;

5------------

SELECT contact_name
from customers
where contact_name LIKE 'C%'

6--------------

SELECT contact_name
from customers
where contact_name LIKE '%s%'

7---------------

ALTER TABLE customers
ADD contains_s boolean NULL;

8---------------

Update customers
set contains_s = TRUE
where 
contact_name
like '%s%';

9. Muestra una lista de productos (id, nombre y precio de unidad) 
    donde los  productos tengan un coste de entre $12 y $24.  

SELECT
P.product_id,
P.product_name,
P.unit_price
FROM
Products P
where 
p.unit_price BETWEEN '12' AND '24'
ORDER BY P.unit_price ASC;

10. Muestra una lista de productos (id, name, unite price)
     de los 10 que tengan  un coste más caro. 

  
SELECT
P.product_id,
P.product_name,
P.unit_price
FROM
Products P
ORDER BY P.unit_price DESC
limit 10;

11. Muestra el número total de unidades pedidas del producto 
      con ID = 60.  
      
  SELECT 
    count(OD.product_id) as TotalSales
        FROM
    Products P,
    Orders O,
    Order_Details OD
    WHERE
    P.Product_ID = OD.Product_ID
    AND
    O.Order_ID = OD.Order_ID
    AND
    OD.product_ID = '60';


12. ¿Quién ha sido el cliente (id del cliente, 
      nombre de la compañía, nombre de  contacto) que ha comprado más?  

SELECT
    C.customer_id,
    C.company_name,
    C.contact_title,
    COUNT(O.order_id) AS total_orders
FROM
    customers C
JOIN
    orders O ON C.customer_id = O.customer_id
GROUP BY
    C.customer_id,
    C.company_name,
    C.contact_title
ORDER BY
    total_orders DESC
    LIMIT 1;

13. Muestra a los clientes que no han realizado ninguna compra desde 
      el año  1996.  

SELECT
    C.contact_name
FROM
    customers C
LEFT JOIN
    orders O ON C.customer_id = O.customer_id
WHERE
    O.order_date IS NULL OR O.order_date < '1996-01-01'
ORDER BY
    C.customer_id;


14. Muestra información (nombre de la compañía, título de contacto, phone,
       city,  country) de todos los clientes de Argentina o de cualquier 
       ciudad de España  menos Barcelona.  
  
    SELECT
    C.customer_id,
    C.company_name,
    C.contact_title,
    C.city,
    C.country
    FROM
    Customers C
    WHERE
    (c.country = 'Argentina') 
	OR (c.country = 'Spain' 
	AND c.city <> 'Barcelona');
  

15. Muestra la ID del orden, el nombre de la compañía que hizo el pedido y 
        los  apellidos de los empleados asociados. Sólo muestra las órdenes 
        solicitadas  entre 1995 y 1998 que se enviaron antes de ser solicitadas 
        (pista:  comprobar las fechas).

SELECT
    O.order_id,
    C.company_name,
    E.last_name
FROM
    orders O
JOIN
    customers C ON O.customer_id = C.customer_id
JOIN
    employees E ON O.employee_id = E.employee_id
WHERE
    EXTRACT(YEAR FROM O.order_date) BETWEEN 1995 AND 1998
    AND O.required_date < O.shipped_date;


16. ¿Cuál es el valor medio de la venta de órdenes (sales order)?  



17. Muestra 
        la cantidad total de productos pedidos (desde la tabla de detalles  de pedido).
         Sólo muestra los registros por productos (nombre de producto) 
          donde su cantidad pedida es menor que 200. 

      SELECT 
P.product_name,
SUM(OD.quantity) AS cantidad_total
FROM 
order_details OD
JOIN products P ON OD.product_id = P.product_id
WHERE 
OD.quantity < 200
GROUP 
BY P.product_name;


18. Muestra una lista de clientes que no realizaron ninguna compra en el año  1996.
SELECT C.contact_name,
 C.customer_id,
   C.company_name
FROM 
customers C
LEFT JOIN orders O ON C.customer_id = O.customer_id 
AND 
EXTRACT(YEAR FROM O.order_date) = 1996
WHERE 
O.order_id IS NULL;

19.
SELECT
P.product_name,
SUM(O.unit_price-O.unit_price*(1-0.discount)) profit
FROM
products P,
order_details O
WHERE
O.product_id= P.product-Id
group by P.product_name
order by profit desc limit 1;

20. Muestra el nombre de los tres países a los que se han enviado más  órdenes

SELECT ship_country, COUNT(*) AS total_ordenes_enviadas
FROM orders
GROUP BY ship_country
ORDER BY total_ordenes_enviadas DESC
LIMIT 3;
