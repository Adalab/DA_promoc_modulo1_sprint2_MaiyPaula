USE northwind;
/*1. Extraed los pedidos con el máximo "order_date" para cada empleado.
Nuestro jefe quiere saber la fecha de los pedidos más recientes que ha gestionado cada empleado. Para eso nos pide que lo hagamos con una query correlacionada.*/
-- Seleccionamos la fecha de pedido, el id del empleado, del cliente y del pedido de la tabla orders donde la fecha de pedido sea mayor o igual al máximo de la query
-- correlacionada de la misma tabla la fecha máxima de pedido.

SELECT o1.order_date, o1.employee_id, o1.customer_id, o1.order_id
FROM orders as o1
WHERE o1.order_date >= (
						SELECT max(o2.order_date)
						FROM orders as o2
						WHERE o2.employee_id = o1.employee_id)
ORDER BY order_date DESC;

/*2.Extraed el precio unitario máximo (unit_price) de cada producto vendido.
Supongamos que ahora nuestro jefe quiere un informe de los productos vendidos y su precio unitario. 
De nuevo lo tendréis que hacer con queries correlacionadas.*/
-- Seleccionamos el precio unitario y el id del producto de la tabla order details y filtramos la consulta a través de la querie correlacionada donde el precio unitario sea 
-- igual al máximo del precio unitario y lo agrupamos por producto.
SELECT unit_price, product_id
FROM order_details as o1
WHERE o1.unit_price = (select max(unit_price)
					from order_details as o2
                    where o1.product_id = o2.product_id)
group by product_id;

/*3.Ciudades que empiezan con "A" o "B".
Por un extraño motivo, nuestro jefe quiere que le devolvamos una tabla con aquelas compañias que están 
afincadas en ciudades que empiezan por "A" o "B". Necesita que le devolvamos la ciudad, 
el nombre de la compañia y el nombre de contacto.*/

-- Seleccionamos el nombre de la empresa, ciudad y nombre de contacto de la tabla customers y filtramos por las ciudades que empiecen por la letra A o B mediante LIKE.
SELECT company_name, city, contact_name
FROM customers
WHERE city LIKE 'A%' or city LIKE 'B%';

/*4. Número de pedidos que han hecho en las ciudades que empiezan con L.
En este caso, nuestro objetivo es devolver los mismos campos que en la query anterior el número de 
total de pedidos que han hecho todas las ciudades que empiezan por "L".*/

-- Seleccionamos el nombre de la empresa, ciudad y nombre de contacto de la tabla customers y la cuenta de los order_id de la tabla orders, uniendo ambas tablas
-- mediante INNER JOIN, filtrando los resultados por las ciudades que empiezan por L y agrupando los resultados por nombre de la compañía.
SELECT company_name, city, contact_name, count(distinct order_id)
FROM customers
INNER JOIN orders
USING (customer_id)
WHERE city LIKE 'L%'
GROUP BY company_name;

/* 5. Todos los clientes cuyo "contact_title" no incluya "Sales".
Nuestro objetivo es extraer los clientes que no tienen el contacto "Sales" en su "contact_title". 
Extraer el nombre de contacto, su posisión (contact_title) y el nombre de la compañia.*/

-- Seleccionamos el nombre de contacto, titulo y nombre de la compañía filtrando el resultado por aquellos nombres de contacto que no tengan la palabra Sales mediante NOT LIKE.
SELECT contact_name, contact_title, company_name
FROM customers
WHERE contact_title NOT LIKE '%Sales%';

/*6. Todos los clientes que no tengan una "A" en segunda posición en su nombre.
Devolved unicamente el nombre de contacto.*/
-- Seleccionamos los nombres de contacto filtrando el resultado por aquellos que no tengan a en la segunda posición mediante NOT LIKE.
SELECT contact_name
FROM customers
WHERE contact_name NOT LIKE '_a%';