--Explorar la tabla “menu_items” para conocer los productos del menú.

SELECT * FROM menu_items;

--Encontrar el número de artículos en el menú
--El numero de platillos del menu es de 32

SELECT COUNT(*) FROM menu_items;

--¿Cuál es el artículo menos caro y el más caro en el menú?
--"Edamame"	5.00
--"Shrimp Scampi"	19.95

SELECT 
	MIN(price) AS menos_caro,
	MAX (price) AS mas_caro
FROM menu_items
LIMIT 1;

SELECT item_name, price FROM menu_items
ORDER BY price ASC
LIMIT 1;

SELECT item_name, price FROM menu_items
ORDER BY price DESC
LIMIT 1;

--¿Cuántos platos americanos hay en el menú?
--Existen 4 Categorias de Platos, de los cuales 6 son americanos

SELECT DISTINCT category
FROM menu_items;

SELECT COUNT (category) AS "platos americanos"
FROM menu_items WHERE category IN ('American');

SELECT item_name AS "platos americanos"
FROM menu_items WHERE category IN ('American');

--¿Cuál es el precio promedio de los platos?
--El precio promedio de los platillos es de $13.29

SELECT ROUND(AVG(price),2) AS "precio promedio"
FROM menu_items;



--Explorar la tabla “order_details” para conocer los datos que han sido recolectados.

SELECT * FROM order_details;

--¿Cuántos pedidos únicos se realizaron en total? 5,370

SELECT COUNT(DISTINCT order_id)
FROM order_details;

--¿Cuáles son los 5 pedidos que tuvieron el mayor número de artículos?

SELECT * FROM order_details

SELECT order_id, COUNT(item_id)
FROM order_details
GROUP BY order_id
ORDER BY COUNT(item_id) DESC
LIMIT 7;

--¿Cuándo se realizó el primer pedido y el último pedido?

--Primer pedido "2023-01-01"	"11:38:36"	109

SELECT order_date, order_time, item_id FROM order_details
ORDER BY order_date ASC, order_time ASC
LIMIT 1;

--Último pedido "2023-03-31"	"22:15:48"	122

SELECT order_date, order_time, item_id FROM order_details
ORDER BY order_date DESC, order_time DESC
LIMIT 1;

--¿Cuántos pedidos se hicieron entre el '2023-01-01' y el '2023-01-05'?
--702 pedidos

SELECT order_id, order_date, item_id FROM order_details
WHERE order_date BETWEEN '2023-01-01' AND '2023-01-05';
	
SELECT COUNT(order_id) FROM order_details
WHERE order_date BETWEEN '2023-01-01' AND '2023-01-05';


--Realizar un left join entre entre order_details y menu_items con el identificador
--item_id (tabla order_details) y menu_item_id(tabla menu_items).

SELECT * FROM menu_items;

SELECT * FROM order_details

SELECT *
FROM order_details AS od
LEFT JOIN menu_items AS mi
ON od.item_id=mi.menu_item_id;

--( 1 ) Cual es la categoria mas pedida

SELECT COUNT(od.order_id), mi.category
FROM order_details AS od
LEFT JOIN menu_items AS mi
ON od.item_id=mi.menu_item_id
WHERE mi.category IS NOT NULL
GROUP BY mi.category
ORDER BY COUNT(od.order_id) DESC;


--( 2 ) Cuales son los 10 platillos mas pedidos

SELECT COUNT(od.order_id), mi.item_name,mi.category
FROM order_details AS od
LEFT JOIN menu_items AS mi
ON od.item_id=mi.menu_item_id
GROUP BY mi.item_name, mi.category
ORDER BY COUNT(od.order_id) DESC
LIMIT 10;

--( 3 ) Cuales son los 10 platillos menos pedidos

SELECT COUNT(od.order_id), mi.item_name,mi.category
FROM order_details AS od
LEFT JOIN menu_items AS mi
ON od.item_id=mi.menu_item_id
WHERE mi.category IS NOT NULL
GROUP BY mi.item_name, mi.category
ORDER BY COUNT(od.order_id) ASC
LIMIT 10;


--( 4 ) ¿Cuantos pedidos hubo del platillo menos caro y del mas caro?
--"Edamame"	5.00 620 pedidos
--"Shrimp Scampi"	19.95 239 pedidos

SELECT COUNT(od.order_details_id), mi.item_name, mi.price
FROM order_details AS od
LEFT JOIN menu_items AS mi
ON od.item_id=mi.menu_item_id
WHERE mi.item_name='Edamame'
GROUP BY mi.item_name, mi.price
ORDER BY COUNT(od.order_details_id);

SELECT COUNT(od.order_details_id), mi.item_name, mi.price
FROM order_details AS od
LEFT JOIN menu_items AS mi
ON od.item_id=mi.menu_item_id
WHERE mi.item_name='Shrimp Scampi'
GROUP BY mi.item_name, mi.price
ORDER BY COUNT(od.order_details_id);

--( 5 ) En la primer y ultima semana, ¿Cuales fueron los 5 platillos mas pedidos?

--Primera Semana
	
SELECT COUNT(od.order_details_id), od.order_date, mi.item_name,mi.category
FROM order_details AS od
LEFT JOIN menu_items AS mi
ON od.item_id=mi.menu_item_id
WHERE od.order_date BETWEEN '2023-01-01' AND '2023-01-07'
GROUP BY od.order_date, mi.item_name, mi.category
ORDER BY COUNT(od.order_details_id) DESC
LIMIT 5;

--Ultima Semana

SELECT COUNT(od.order_details_id), od.order_date, mi.item_name,mi.category
FROM order_details AS od
LEFT JOIN menu_items AS mi
ON od.item_id=mi.menu_item_id
WHERE od.order_date BETWEEN '2023-03-25' AND '2023-03-31'
GROUP BY od.order_date, mi.item_name, mi.category
ORDER BY COUNT(od.order_details_id) DESC
LIMIT 7;

