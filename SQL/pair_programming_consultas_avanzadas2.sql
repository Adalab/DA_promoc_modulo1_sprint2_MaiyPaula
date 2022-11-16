USE northwind;
# Nº de pedidos y máxima cantidad de carga de entre los mismos freight enviados por cada empleado (employee_id)
SELECT COUNT(order_id) AS pedidos, MAX(DISTINCT freight) AS max_carga, employee_id AS empleado
FROM orders
GROUP BY employee_id;

# Descartar pedidos sin fecha de envío y ordenar los resultados según id_empleado
SELECT COUNT(order_id) AS pedidos, MAX(DISTINCT freight) AS max_carga, employee_id AS empleado
FROM orders
WHERE shipped_date IS NOT NULL
GROUP BY employee_id 
ORDER BY employee_id ASC;

# Pedidos por dia: Numeros de pedidos por cada dia mostrando de manera separada el dia, el mes y el año: DAY()), el mes (MONTH()) y el año (YEAR()).
SELECT COUNT(DISTINCT order_id) AS pedidos, DAY(order_date) AS dia, MONTH(order_date) AS mes, YEAR(order_date) AS año
FROM orders
GROUP BY DAY(order_date), MONTH(order_date), YEAR(order_date);

# Numero de pedidos por mes y año:
SELECT COUNT(DISTINCT order_id) AS pedidos, MONTH(order_date) AS mes, YEAR(order_date) AS año
FROM orders
GROUP BY MONTH(order_date), YEAR(order_date) ORDER BY YEAR(order_date);

# Seleccionar las ciudades con 4 o más empleadas
SELECT city AS ciudad, COUNT(employee_id) AS num_empleadas
FROM employees
GROUP BY city
HAVING COUNT(employee_id) >= 4; 

# Necesitamos una consulta que clasifique los pedidos en dos categorías ("Alto" y "Bajo") 
# en función de la cantidad monetaria total que han supuesto: por encima o por debajo de 2000 euros.
SELECT ROUND(unit_price * quantity, 1) AS total,
CASE 
WHEN unit_price * quantity > 2000 THEN "Alto"
ELSE "Bajo"
END AS Categoria
FROM order_details;