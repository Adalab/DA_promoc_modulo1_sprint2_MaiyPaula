-- PAIR PROGRAMMING CONSULTAS EN MÚLTIPLES TABLAS 2 --

USE northwind;

/* EJERCICIO 1 
Qué empresas tenemos en la BBDD Northwind:
Lo primero que queremos hacer es obtener una consulta SQL que nos devuelva el nombre de todas las 
empresas cliente, los ID de sus pedidos y las fechas.*/

-- Seleccionamos el nombre de la empresa, el order_id y la feha del pedido y unimos las tablas 
-- customers y orders con un left join.

SELECT customers.company_name AS empresa, orders.order_id AS ID, orders.order_date AS fecha
FROM customers
	LEFT JOIN orders
	ON customers.customer_id = orders.customer_id;


/* EJERCICIO 2
Pedidos por cliente de UK:
Desde la oficina de Reino Unido (UK) nos solicitan información acerca del número de pedidos que ha realizado 
cada cliente del propio Reino Unido de cara a conocerlos mejor y poder adaptarse al mercado actual. 
Especificamente nos piden el nombre de cada compañía cliente junto con el número de pedidos.*/

-- Seleccionamos el nombre de la empresa y contamos los order_id sin duplicados de la tabla customers, 
-- uniendo con un left join la tabla orders ya que tienen las dos la columna customer_id. 
-- Seleccionamos los clientes de UK y agrupamos por el nombre de la empresa.

SELECT customers.company_name AS empresa, COUNT(distinct orders.order_id) AS num_pedidos
FROM customers
	LEFT JOIN orders
	ON customers.customer_id = orders.customer_id
WHERE customers.country = 'UK'
GROUP BY customers.company_name;


/* EJERCICIO 3 
Empresas de UK y sus pedidos:
También nos han pedido que obtengamos todos los nombres de las empresas cliente de Reino Unido (tengan pedidos o no) 
junto con los ID de todos los pedidos que han realizado, el nombre de contacto de cada empresa y la fecha del pedido.*/

-- Selecionamos el nombre de la empresa, el nombre de la persona de contacto, el order_id y la fecha de pedido de la tabla 
-- customers uniendo con un left joint la tabla orders ya que comparten el customer_id y filtramos por el país UK.

SELECT customers.company_name AS empresa, customers.contact_name AS contacto, orders.order_id AS ID, orders.order_date AS fecha
FROM customers
	LEFT JOIN orders
	ON customers.customer_id = orders.customer_id
WHERE customers.country = 'UK';


/*EJERCICIO 4 
Empleadas que sean de la misma ciudad:
Ejercicio de SELF JOIN: Desde recursos humanos nos piden realizar una consulta que muestre por pantalla los datos 
de todas las empleadas y sus supervisoras. Concretamente nos piden: la ubicación, nombre, y apellido tanto de las 
empleadas como de las jefas. Investiga el resultado, ¿sabes decir quién es el director?*/

-- Seleccionamos de la tabla employees el nombre y apellido uniéndolo en una misma columna y la ciudad utilizando alias  A
-- para volver a seleccionar la misma información con el alias B y poder filtrar en el where la jerarquia. 

SELECT concat(A.first_name, " ", A.last_name) AS nombre_empleada, A.city AS ciudad_empleada, concat(B.first_name, " ", B.last_name) AS nombre_supervisora, B.city AS ciudad_supervisora
FROM employees AS A, employees AS B
WHERE  A.reports_to = B.employee_id;

-- Andrew Fuller es el Director


/* BONUS: 
FULL OUTER JOIN Pedidos y empresas con pedidos asociados o no:
Selecciona todos los pedidos, tengan empresa asociada o no, y todas las empresas tengan pedidos asociados o no. 
Muestra el ID del pedido, el nombre de la empresa la fecha del pedido (si existe).*/

-- Seleccionamos la información solicitada de las tablas customers y orders, haciendo un outer join para muestre 
-- en la misma línea los resultados asociados o no. 

SELECT customers.company_name AS empresa, orders.order_id AS ID , orders.order_date AS fecha  
FROM customers  
LEFT JOIN orders  
ON customers.customer_id = orders.customer_id  
UNION  
SELECT customers.company_name AS empresa, orders.order_id AS ID , orders.order_date AS fecha  
FROM customers  
RIGHT JOIN orders  
ON customers.customer_id = orders.customer_id;




