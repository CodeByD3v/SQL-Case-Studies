CREATE DATABASE swiggy ;
USE swiggy ;

SELECT * FROM orders; 
SELECT * FROM customers ;
SELECT * FROM restaurants ;

--  WHICH ARE THE PREFERRED RESTAURANTS AND CUISINE TYPES AMONG THE PLATINUM CUSTOMERS, 
-- AND WHICH CUSTOMERS SHOW THE HIGHEST LOYALTY TO THESE RESTAURANTS?

WITH PLATINUM_CUSTOMERS AS (
  SELECT
	o.customer_id , 
	c.name ,
	c.membership_status ,
    r.restaurant_id,
	r.restaurant_name , 
    r.cuisine_type,
    r.location , 
	COUNT(order_id) AS total_orders
FROM orders o
JOIN customers c ON c.customer_id = o.customer_id
JOIN restaurants r ON r.restaurant_id = o.restaurant_id
WHERE c.membership_status = 'platinum'
GROUP BY o.customer_id , c.name , c.membership_status ,r.restaurant_id ,r.restaurant_name ,r.cuisine_type,r.location 
),
TOP_RESTAURANTS AS (
SELECT 
	restaurant_id , 
    restaurant_name , 
    location ,
	cuisine_type , 
    SUM(total_orders) AS total_orders
FROM PLATINUM_CUSTOMERS
GROUP BY restaurant_id , restaurant_name , location , cuisine_type 
ORDER BY total_orders DESC 
LIMIT 5 
),
LOYAL_CUSTOMERS AS (
SELECT 
	c.customer_id,
    c.name , 
    o.restaurant_id , 
	r.restaurant_name , 
    COUNT(o.order_id) AS Repeated_orders 
	FROM orders o 
    JOIN customers c ON c.customer_id = o.customer_id
    JOIN restaurants r ON r.restaurant_id = o.restaurant_id
    WHERE c.membership_status = 'platinum'
    GROUP BY c.customer_id , c.name , o.restaurant_id , r.restaurant_name 
    HAVING COUNT(o.order_id) > 1
)
SELECT 
	tr.restaurant_id , 
	tr.restaurant_name , 
    tr.location , 
    tr.cuisine_type , 
    tr.total_orders , 
    lc.customer_id , 
    lc.name , 
    lc.repeated_orders 
FROM TOP_RESTAURANTS tr
JOIN LOYAL_CUSTOMERS lc ON tr.restaurant_id = lc.restaurant_id 
ORDER BY total_orders DESC ;