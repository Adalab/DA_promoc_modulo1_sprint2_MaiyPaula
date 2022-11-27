-- PAIR PROGRAMMING CONSULTAS CONSULTAS AVANZADAS --

USE northwind;

/* EJERCICIO 1 
Desde logística nos piden el número de pedidos y la máxima cantidad de carga de entre los mismos (freight) que han sido enviados por cada empleado 
(mostrando el ID de empleado en cada caso). */

-- Hacemos una selección en la que contamos el order_id para saber el número de pedidos, el máximo del freight de cada uno y el employee_id  de la tabla orders 
-- agrupamos la consulta por employee_id para identificar cual ha sido enviado por cada empleado.

SELECT COUNT(order_id) AS pedidos, MAX(DISTINCT freight) AS max_carga, employee_id AS empleado
FROM orders
GROUP BY employee_id;

/* EJERCICIO 2 
Una vez han revisado los datos de la consulta anterior, nos han pedido afinar un poco más el "disparo". En el resultado anterior se han incluido muchos pedidos 
cuya fecha de envío estaba vacía, por lo que tenemos que mejorar la consulta en este aspecto. También nos piden que ordenemos los resultados según el ID de empleado
para que la visualización sea más sencilla.*/

-- Repetimos la consulta anterior pero filtramos a través del WHERE aquellos donde la fecha de envío es NULL para que no aparezcan en la consulta, además ordenamos la
-- consulta por employee_id mediante ORDER BY.

SELECT COUNT(order_id) AS pedidos, MAX(DISTINCT freight) AS max_carga, employee_id AS empleado
FROM orders
WHERE shipped_date IS NOT NULL
GROUP BY employee_id 
ORDER BY employee_id ASC;

/*EJERCICIO 3 
El siguiente paso en el análisis de los pedidos va a consistir en conocer mejor la distribución de los mismos según las fechas. Por lo tanto, tendremos que 
generar una consulta que nos saque el número de pedidos para cada día, mostrando de manera separada el día (DAY()), el mes (MONTH()) y el año (YEAR()).*/ 

-- Hacemos la consulta contando los order_id y la fecha separandola mediante DAY, MONTH y YEAR de la tabla orders

SELECT COUNT(DISTINCT order_id) AS pedidos, DAY(order_date) AS dia, MONTH(order_date) AS mes, YEAR(order_date) AS año
FROM orders
GROUP BY DAY(order_date), MONTH(order_date), YEAR(order_date);

/* EJERCICIO 4 
La consulta anterior nos muestra el número de pedidos para cada día concreto, pero esto es demasiado detalle. Genera una modificación de la consulta anterior 
para que agrupe los pedidos por cada mes concreto de cada año.*/

-- Repetimos la consulta anterior pero agrupamos los resultados por mes y año mediante GRUOP BY y ordenamos la consulta por año con ORDER BY.

SELECT COUNT(DISTINCT order_id) AS pedidos, MONTH(order_date) AS mes, YEAR(order_date) AS año
FROM orders
GROUP BY MONTH(order_date), YEAR(order_date) ORDER BY YEAR(order_date);

/*EJERCICIO 5 
Desde recursos humanos nos piden seleccionar los nombres de las ciudades con 4 o más empleadas de cara a estudiar la apertura de nuevas oficinas.*/

-- En la consulta seleccionamos city y contamos el employee_id para saber el número de empleadas de la tabla employees y agrupamos la selección por ciudad para saber
-- cuantas hay por ciudad. Filtramos el resultado por aquellas que tienen 4 o más empleadas mediante HAVING para mostrar el resultado que solicitan.

SELECT city AS ciudad, COUNT(employee_id) AS num_empleadas
FROM employees
GROUP BY city
HAVING COUNT(employee_id) >= 4; 

/* EJERCICIO 6 
Necesitamos una consulta que clasifique los pedidos en dos categorías ("Alto" y "Bajo") en función de la cantidad monetaria total que han supuesto:
 por encima o por debajo de 2000 euros.*/
 
 -- Seleccionamos el order_id y hacemos la multiplicación del precio unitario por la cantidad para saber la cantidad monetaria total que ha supuesto cada pedido
 -- de la tabla orders_details y lo redondeamos a 1 decimal. Mediante un CASE WHEN filtramos creando una nueva columna llamada categoría donde cuando esta cantidad 
-- total sea mayor a 2000 se etiquete como Alto y si no como Bajo
 
SELECT order_id as num_pedido, ROUND(unit_price * quantity, 1) AS total,
CASE 
WHEN unit_price * quantity > 2000 THEN "Alto"
ELSE "Bajo"
END AS Categoria
FROM order_details;