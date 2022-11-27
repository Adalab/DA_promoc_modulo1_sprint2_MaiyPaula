-- EJERCICIOS PAIR PROGRAMMING CONSULTAS EN MULTIPLES TABLAS 1 --

USE northwind;

/* EJERCICIO 1: 
Desde las oficinas en UK nos han pedido con urgencia que realicemos una consulta  a la base de datos con la que podamos conocer cuántos pedidos ha realizado cada 
empresa cliente de UK. Nos piden el ID del cliente y el nombre de la empresa y el número de pedidos.*/

-- Contamos el número de pedidos y seleccionamos el nombre de la empresa de la tabla orders que unimos mediante un INNER JOIN a la tabla de customers para poder filtrar
-- los clientes de UK. Las unimos mediante la columna customer_id y filtramos donde el pais sea UK y agrupamos por el customer_id.

SELECT customers.customer_id AS Nom_cliente, COUNT(order_id) AS Pedidos, company_name AS Empresa
FROM orders
	INNER JOIN customers
	ON orders.customer_id = customers.customer_id
WHERE country = 'UK'
GROUP BY customers.customer_id;

-- Hacemos la misma consulta con Natural Join, ya que las columnas tienen el mismo 
-- nombre y da el mismo resultado con menos código.

SELECT customer_id AS Nom_cliente, COUNT(order_id) AS Pedidos, company_name AS Empresa
FROM orders
	NATURAL JOIN customers
WHERE country = 'UK'
GROUP BY customer_id;

/* EJERCICIO 2 
Desde Reino Unido se quedaron muy contentas con nuestra rápida respuesta a su petición anterior y han decidido pedirnos una serie de consultas adicionales. 
La primera de ellas consiste en una query que nos sirva para conocer cuántos objetos ha pedido cada empresa cliente de UK durante cada año. Nos piden concretamente
conocer el nombre de la empresa, el año, y la cantidad de objetos que han pedido. Para ello hará falta hacer 2 joins.*/

-- Seleccionamos el nombre de la compañía de la tabla customers, el año de la fecha de pedido de la tabla orders la suma de la cantidad de la tabla order_details
-- unimos estas tres tablas emdiante un INNER JOIN, orders con order_details mediante la columna order.id, y orders con customers mediante la columna customer_id.
-- Filtramos la consulta donde el pais de company_name sea UK y agrupamos la consulta por company_name y por año para sacar el numero de pedidos por cliente y por año.

SELECT company_name AS cliente, YEAR(order_date) AS año, SUM(quantity) AS cantidad 
FROM orders
	INNER JOIN  order_details
	ON order_details.order_id = orders.order_id
	INNER JOIN customers
	ON customers.customer_id = orders.customer_id
WHERE country = 'UK'
GROUP BY company_name, año;


/* EJERCICIO 3 
Lo siguiente que nos han pedido es la misma consulta anterior pero con la adición de la cantidad de dinero que han pedido por esa cantidad de objetos, 
teniendo en cuenta los descuentos, etc. Ojo que los descuentos en nuestra tabla nos salen en porcentajes, 15% nos sale como 0.15.*/

-- Repetimos la consulta anterior, añadiendo una columna más que llamamos dinero_total donde calculamos el descuento haciendo la multiplicación del precio unitario
-- por la suma de la cantidad donde le muliplicamos 1- el descuento para tener en cuenta que el discount viene en porcentaje.

SELECT company_name AS cliente, YEAR(order_date) AS año,  SUM(quantity) AS cantidad, 
(unit_price*SUM(quantity))*(1-discount) AS dinero_total
FROM orders
	INNER JOIN  order_details
	ON order_details.order_id = orders.order_id
	INNER JOIN customers
	ON customers.customer_id = orders.customer_id
WHERE country = 'UK'
GROUP BY company_name, año;

/* EJERCICIO 4 **BONUS**:
Después de estas solicitudes desde UK y gracias a la utilidad de los resultados que se han obtenido, desde la central nos han pedido una consulta que indique el 
nombre de cada compañia cliente junto con cada pedido que han realizado y su fecha.*/

-- Seleccionamos el nombre de la compañía de la tabla customers, los pedidos y la fecha de los pedidos de la tabla orders y unimos ambas tablas mediante un NATURAL JOIN
-- ya que ambas tablas tienen la columna employee_id.

SELECT company_name AS cliente, order_id AS pedido, order_date AS fecha
FROM orders NATURAL JOIN customers;
    
    
/* EJERCICIO 5 **BONUS**:
 Ahora nos piden una lista con cada tipo de producto que se han vendido, sus categorías, nombre de la categoría y el nombre del producto, y el total de dinero por 
 el que se ha vendido cada tipo de producto (teniendo en cuenta los descuentos). Usar 3 joins.*/

-- Seleccionamos el nombre de la categoría y el category_id de la tabla categories, el product_name de la tabla products y el dinero total, como en el ejercicio 3,
-- de la tabla order_details. Unimos las tres tablas mediante INNER JOIN, la tabla products y order_detais mediante la columna product_id y prductos con categories mediante
-- la columna category_id. Agrupamos la counsulta por product_name  para saber el dinero total por producto.

SELECT category_name AS categoria, categories.category_id, product_name AS nombre, 
(order_details.unit_price*(quantity))*(1-discount) AS dinero_total
FROM products
	INNER JOIN order_details
    ON products.product_id = order_details.product_id
    INNER JOIN categories
    ON categories.category_id = products.category_id
GROUP BY product_name;