-- EJERCICIOS PAIR PROGRAMMING CONSULTAS EN MULTIPLES TABLAS 3 --

USE northwind;

/* 1) Extraer toda la información sobre las compañias que tengamos en la BBDD
Nuestros jefes nos han pedido que creemos una query que nos devuelva todos los clientes y proveedores 
que tenemos en la BBDD. Mostrad la ciudad a la que pertenecen, el nombre de la empresa y el nombre del 
contacto, además de la relación (Proveedor o Cliente). Pero importante! No debe haber duplicados en 
nuestra respuesta. La columna Relationship no existe y debe ser creada como columna temporal. Para 
ello añade el valor que le quieras dar al campo y utilizada como alias Relationship.
Nota: Deberás crear esta columna temporal en cada instrucción SELECT 
[Código:(SELECT 'Hola!' AS tipo_nombre FROM customers)];*/

-- Seleccionamos el nombre de la compañia y el nombre de contacto atribuyendo alias a las columnas, 
-- creando la columna temporal de Relationship, utilizando la instrucción union para combinar los 
-- resultados de los selects de las tablas customers y suppliers sin que haya duplicados.

SELECT company_name AS 'Nombre empresa' , contact_name AS 'Nombre contacto', 'Cliente' AS Relationship
FROM customers
UNION
SELECT company_name AS 'Nombre empresa' , contact_name AS 'Nombre contacto', 'Proveedor' AS Relationship
FROM suppliers;


/* 2 Extraer todos los pedidos gestinados por "Nancy Davolio"
En este caso, nuestro jefe quiere saber cuantos pedidos ha gestionado "Nancy Davolio", una de nuestras 
empleadas. Nos pide todos los detalles tramitados por ella.*/

-- Seleccionamos todos los resultados de la tabla orders combinando con la tabla employees con la instrucción 
-- where que no devuelve duplicados, filtrando por el nombre de Nancy Davolio.

SELECT* 
FROM orders
WHERE employee_id IN(
		SELECT first_name = 'Nancy' AND last_name = 'Davolio'
        FROM employees);
        

/* 3) Extraed todas las empresas que no han comprado en el año 1997
Para extraer el año de una fecha, podemos usar el estamento year */

-- Seleccionamos las empresas de la tabla customers combinando con la tabla orders con la instrucción not in 
-- para filtar por las que no han hecho pedidos en el año 1997. Utilizamos la función agregada year para 
-- extraer el año de la fecha.

SELECT company_name AS Empresas
FROM customers
WHERE customer_id NOT IN(
	SELECT customer_id
	FROM orders WHERE YEAR(order_date) = 1997);
	

/* 4) Extraed toda la información de los pedidos donde tengamos "Konbu"
Estamos muy interesados en saber como ha sido la evolución de la venta de Konbu a lo largo del tiempo. 
En esta query tendremos que combinar conocimientos adquiridos en las lecciones anteriores como por ejemplo 
el INNER JOIN. */

-- Seleccionamos toda la información de la tabla orders, combinando con un inner join con la tabla order_details 
-- y con using para no duplicar y filtrar por el id_order donde el nombre del producto sea Konbu.

SELECT*
FROM orders
INNER JOIN order_details
USING (order_id)
WHERE product_id IN(
	SELECT product_id
    FROM products WHERE product_name = 'Konbu');







