USE hackathon ; 

-- TABLES USED FROM DATABASE 

SELECT * FROM zomato_order_details; 
SELECT * FROM zomato_restaurant_details ;  

### WHICH RESTAURANTS ARE EARNING HIGH PROFITS BUT HAVE KEPT 
### IT EXCLUSIVE WITH NO MORE THAN 5 ORDERS 

-- FIND THE PROFITS OF EACH OF THE ORDERS THAT ARE EARNED BY THE RESTAURANTS
-- THE COMMISION OF EACH OF THE RESTAURANTS ARE GIVEN IN PERCENTAGES

SELECT `Commision %` FROM zomato_restaurant_details ; 

-- FOR GETTING TOTAL PROFIT 
-- COMMISION = (COMMSION  / 100) * ACTUAL VALUE
-- TOTAL_PROFIT = ACTUAL VALUE - (ZOMATO_DISCOUNT + RESTAURANT_DISCOUNT + COMMISION)

-- ADDING COLUMN FOR PROFIT , COMMISION CUTOFF
ALTER TABLE zomato_order_details ADD COLUMN net_value DOUBLE ; 
ALTER TABLE zomato_order_details ADD COLUMN commision_cutoff DOUBLE ; 

-- COMMISION CUTOFF
UPDATE zomato_order_details zo
JOIN zomato_restaurant_details zr
SET commision_cutoff = (zr.`Commision %`/100)*zo.OrderValue ;
 
-- CALCULATING THE NET VALUE  / PROFIT VALUE  
UPDATE 
	zomato_order_details 
SET 
	net_value = OrderValue - (Zomato_Discount+Merchant_Discount+commision_cutoff) ; 
    
-- FINDING THE RESTAURANTS WITH HIGHER PROFIT AND WITH 5 ORDERS

SELECT 
	zo.RestaurantId , 
    zr.RestaurantName , 
    COUNT(orderId) AS NumberOfOrders , 
    SUM(net_value) AS TotalProfit 
FROM 
	zomato_order_details zo 
JOIN 
	zomato_restaurant_details zr
ON 
	zo.RestaurantID = zr.RestaurantID
GROUP BY zo.RestaurantId , zr.RestaurantName 
HAVING COUNT(orderId) <= 5 
ORDER BY TotalProfit DESC; 