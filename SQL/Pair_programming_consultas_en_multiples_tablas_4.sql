-- EJERCICIOS PAIR PROGRAMMING CONSULTAS EN MÚLTIPLES TABLAS 4 --

USE northwind;

/* 1. Extraed información de los productos "Beverages"
En este caso nuestro jefe nos pide que le devolvamos toda la información necesaria para identificar un tipo de producto. 
En concreto, tienen especial interés por los productos con categoría "Beverages". Devuelve el ID del producto, el nombre 
del producto y su ID de categoría.*/

-- Seleccionamos el id y el nombre del producto y la categoria de la tabla products, seguido de una subconsulta seleccionando 
-- la categoria de la tabla categories donde el nombre de la categoria sea Beverage.

SELECT product_id, product_name, category_id
FROM products
WHERE category_id IN (
						SELECT category_id
                        FROM categories
                        WHERE category_name = 'Beverages');
					

/* 2. Extraed la lista de países donde viven los clientes, pero no hay ningún proveedor ubicado en ese país
Suponemos que si se trata de ofrecer un mejor tiempo de entrega a los clientes, entonces podría dirigirse a estos países 
para buscar proveedores adicionales. */

-- Seleccionamos el pais de la tabla customers agrupandolo por paises para no obtener paises por duplicado, seguido de 
-- una subconsulta donde no aparezcan esos paises en la tabla proveedores. 

SELECT country
FROM customers
GROUP BY country
WHERE country NOT IN(
					SELECT country
                    FROM suppliers);


/* 3. Extraer los clientes que compraron mas de 20 articulos "Grandma's Boysenberry Spread"
Extraed el OrderId y el nombre del cliente que pidieron más de 20 artículos del producto "Grandma's Boysenberry Spread" 
(ProductID 6) en un solo pedido.*/

-- Usando el id del producto con una subconsulta:

SELECT  order_id, company_name
FROM customers
INNER JOIN orders
USING (customer_id)
WHERE order_id IN(
					SELECT order_id
					FROM order_details
					WHERE quantity > 20 AND product_id =6);
                                
                                
-- Usando el nombre del producto con subconsultas anidadas: 

SELECT  order_id, company_name
FROM customers
INNER JOIN orders
USING (customer_id)
WHERE order_id IN(
					SELECT order_id
					FROM order_details
					WHERE quantity > 20 AND product_id IN (
															SELECT product_id
                                                            FROM products
                                                            WHERE product_name = "Grandma's Boysenberry Spread"));
                                

/* 4. Extraed los 10 productos más caros
Nos siguen pidiendo más queries correlacionadas. En este caso queremos saber cuáles son los 10 productos más caros.*/

-- Seleccionamos todos los atributos creando una tabla temporal con la subconsulta en la clausula FROM, en la tabla de 
-- products con sus correspondientes alias, ordenándolos de manera descendente y limitandolo a 10.

SELECT* FROM (
SELECT DISTINCT product_name AS 'Nombre del producto' , unit_price AS 'Precio por unidad'
FROM products AS Productos
ORDER BY unit_price DESC) AS Resultado
LIMIT 10;


-- De esta forma sería sencillo obtener lo solicitado:

SELECT product_name, unit_price
FROM products
ORDER BY unit_price DESC
LIMIT 10;


/* BONUS: Qué producto es más popular.
Extraed cuál es el producto que más ha sido comprado y la cantidad que se compró. */

-- Esta consulta tiene en cuenta el producto que más pedidos ha tenido:

SELECT product_name, SUM(quantity)
FROM products
INNER JOIN order_details 
USING (product_id) 
GROUP BY product_name
HAVING COUNT(order_id) >= ALL (
								SELECT COUNT(order_id)
                                FROM order_details
                                GROUP BY product_id);


-- Esta consulta tiene en cuenta el producto que más cantidad ha vendido:

SELECT product_name, SUM(quantity)
FROM products
INNER JOIN order_details 
USING (product_id) 
GROUP BY product_name
HAVING SUM(quantity) >= ALL (
								SELECT SUM(quantity)
                                FROM order_details
                                GROUP BY product_id);

