-- PAIR PROGRAMMING SIMPLIFICANDO CONSULTAS CON CTEs --

USE northwind;

/* EJERCICIO 1
Extraer en una CTE todos los nombres de las compañias y los id de los clientes.
Para empezar nos han mandado hacer una CTE muy sencilla el id del cliente y el 
nombre de la compañia de la tabla Customers. */


WITH cte_cliente (id_cliente, empresa)
AS ( 
	SELECT customer_id, company_name 
	FROM customers)
SELECT *
FROM cte_cliente;


/* EJERCICIO 2
Ampliemos un poco la query anterior. En este caso, queremos un resultado similar 
al anterior, pero solo queremos los que pertezcan a "Germany".*/

WITH cte_cliente_alemania (id_cliente, empresa)
AS ( 
	SELECT customer_id, company_name 
	FROM customers
    WHERE country = 'Germany')
SELECT *
FROM cte_cliente_alemania;



/* EJERCICIO 3
Extraed el id de las facturas y su fecha de cada cliente.
En este caso queremos extraer todas las facturas que se han emitido a un cliente, su fecha 
la compañia a la que pertenece.
NOTA En este caso tendremos columnas con elementos repetidos(CustomerID, y Company Name). */


WITH cte_cliente (id_cliente, empresa)
AS ( 
	SELECT customer_id, company_name 
	FROM customers)
SELECT order_id, order_date, customer_id, empresa
FROM orders 
INNER JOIN cte_cliente 
ON orders.customer_id = cte_cliente.id_cliente;


/* EJERCICIO 4
Contad el número de facturas por cliente
Mejoremos la query anterior. En este caso queremos saber el número de facturas emitidas por 
cada cliente.*/

WITH cte_cliente (id_cliente, empresa)
AS ( 
	SELECT customer_id, company_name 
	FROM customers)
SELECT COUNT(order_id) AS Numero_facturas, customer_id, empresa
FROM orders 
INNER JOIN cte_cliente 
ON orders.customer_id = cte_cliente.id_cliente
GROUP BY customer_id;



/* EJERCICIO 5
Cuál la cantidad media pedida de todos los productos ProductID.
Necesitaréis extraer la suma de las cantidades por cada producto y calcular la media.*/











