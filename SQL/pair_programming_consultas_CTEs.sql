-- PAIR PROGRAMMING SIMPLIFICANDO CONSULTAS CON CTEs --

USE northwind;

/* EJERCICIO 1
Extraer en una CTE todos los nombres de las compañias y los id de los clientes.
Para empezar nos han mandado hacer una CTE muy sencilla el id del cliente y el 
nombre de la compañia de la tabla Customers. */

-- Creamos una CTE con la sintáxis WITH y AS dándola el nombre cliente y renombrando 
-- las columnas. Extraemos la información solicitada de la tabla customers.

WITH cte_cliente (id_cliente, empresa)
AS ( 
	SELECT customer_id, company_name 
	FROM customers)
SELECT *
FROM cte_cliente;


/* EJERCICIO 2
Ampliemos un poco la query anterior. En este caso, queremos un resultado similar 
al anterior, pero solo queremos los que pertezcan a "Germany".*/

-- Creamos una CTE dándola el nombre cliente_alemania y renombrando las columnas,
-- extrayendo la información de la tabla customers, filtrando por el país Germany.

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

-- Creamos una CTE con la información solicitada de la tabla customers, utilizando un 
-- INNER JOIN para conectar y ampliar la información con la tabla orders, compartiendo 
-- las dos el mismo id de cliente.

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

-- Añadimos a la consulta un group by para que nos agrupe las facturas/orders por cliente.

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
Cuál es la cantidad media pedida de todos los productos ProductID.
Necesitaréis extraer la suma de las cantidades por cada producto y calcular la media.*/

-- Con Id_producto como referencia del producto

WITH suma_cantidad (id_producto, suma)
AS (
	SELECT product_id, SUM(quantity)
    FROM order_details
    GROUP BY product_id)
SELECT id_producto, AVG(suma)
FROM suma_cantidad
GROUP BY id_producto;                                     


-- Con Product_name como referencia del producto

WITH suma_cantidad (id_producto, suma, numero_pedidos)
AS (
	SELECT product_id, SUM(quantity), COUNT(DISTINCT order_id)
    FROM order_details
    GROUP BY product_id)
SELECT product_name, AVG(suma)
FROM suma_cantidad
INNER JOIN products
ON suma_cantidad.id_producto = products.product_id
GROUP BY numero_pedidos;








