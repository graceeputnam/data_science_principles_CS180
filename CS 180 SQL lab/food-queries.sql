-- #### SECTION 1: Special Operators ####

-- Q1) Find the names of all juice items (menu table).

SELECT*
FROM menu
LIMIT 5;

-- menu_id,menu_name,category_id,unit_price
-- 1,Plain Milk,1,50.0
-- 2,Chocolate Milk,1,50.0
-- 3,Strawberry Milk,1,50.0
-- 4,Pepsi,2,55.0
-- 5,Dr Pepper,2,55.0


-- Q2) Find all orders (order table) between August 1 and 9, 2022

SELECT *
FROM orders
WHERE orderdate 
BETWEEN '2022-08-01' AND '2022-08-09'
LIMIT 5;

--orderid,orderdate,menu_id,quantity,customer_id,delivery_platform,emp_id
--1,2022-08-01,1,1,4,Grabfood,1
--2,2022-08-01,6,2,1,Lineman,1
--3,2022-08-02,2,2,2,Robinhood,2
--4,2022-08-03,3,1,5,Grabfood,3
--5,2022-08-04,1,1,2,Robinhood,2


-- Q3) Find the orders (order table) where the delivery platform contains the substring 'ood'

SELECT*
FROM orders
WHERE delivery_platform LIKE '%ood%'
LIMIT 5;

--orderid,orderdate,menu_id,quantity,customer_id,delivery_platform,emp_id
--1,2022-08-01,1,1,4,Grabfood,1
--3,2022-08-02,2,2,2,Robinhood,2
--4,2022-08-03,3,1,5,Grabfood,3
--5,2022-08-04,1,1,2,Robinhood,2
--6,2022-08-05,6,1,4,Grabfood,1


-- Q4) Find the unique delivery order companies from the order table. Get only the name, no other data.

SELECT DISTINCT delivery_platform
FROM orders 
LIMIT 5;

-- delivery_platform
-- Grabfood
-- Lineman
-- Robinhood


-- Q5) Sort the orders table by quantity, largest to smallest

SELECT*
FROM orders
ORDER BY quantity
LIMIT 5;

--orderid,orderdate,menu_id,quantity,customer_id,delivery_platform,emp_id
--1,2022-08-01,1,1,4,Grabfood,1
--4,2022-08-03,3,1,5,Grabfood,3
--5,2022-08-04,1,1,2,Robinhood,2
--6,2022-08-05,6,1,4,Grabfood,1
--7,2022-08-05,10,1,3,Grabfood,3


-- #### SECTION 2: Functions ####

-- Q6) Find minimum, maximum, and average unit price from the menu table (run as a single query).

SELECT min(unit_price), max(unit_price), avg(unit_price)
FROM menu;

--min(unit_price),max(unit_price),avg(unit_price)
--50.0,60.0,55.0


-- Q7) Select order id, date, and delivery platform, but change any occurrence of the substring "Grab" to "Cougar";
-- HINT: Use the REPLACE function (https://app.datacamp.com/learn/tutorials/sql-replace)

SELECT orderid, orderdate, delivery_platform, REPLACE(delivery_platform, 'Grab', 'Cougar')
FROM orders
LIMIT 5;

-- orderid,orderdate,delivery_platform,"REPLACE(delivery_platform, 'Grab', 'Cougar')"
-- 1,2022-08-01,Grabfood,Cougarfood
-- 2,2022-08-01,Lineman,Lineman
-- 3,2022-08-02,Robinhood,Robinhood
-- 4,2022-08-03,Grabfood,Cougarfood
-- 5,2022-08-04,Robinhood,Robinhood


-- #### SECTION 3: Group By ####

-- Q8) Find the average, min, max order quantity by delivery platform

SELECT delivery_platform, avg(quantity), min(quantity), max(quantity) 
FROM orders
GROUP BY delivery_platform;

-- delivery_platform,avg(quantity),min(quantity),max(quantity)
-- Grabfood,1.5,1,3
-- Lineman,2.0,1,3
-- Robinhood,1.16666666666667,1,2


-- Q9) Find the number of orders by delivery platform, but filter to the delivery platform(s) with a count greater than five

SELECT delivery_platform, Count(orderid)
FROM orders
GROUP BY delivery_platform
HAVING Count(orderid) >5;

-- delivery_platform,Count(orderid)
-- Grabfood,12
-- Robinhood,6


-- Q10) Find the total number of units sold by the delivery platform

SELECT delivery_platform, SUM(quantity)
FROM orders
GROUP BY delivery_platform;

-- delivery_platform,SUM(quantity)
-- Grabfood,18
-- Lineman,10
-- Robinhood,7


-- #### SECTION 4: Joins ####

-- Q11) Get the order id, order quantity, customer id, customer first name, and customer last name for all orders

SELECT orders.orderid, orders.quantity, orders.customer_id, customers.firstname, customers.lastname
FROM orders
LEFT JOIN customers 
ON orders.customer_id = customers.customer_id
LIMIT 5;

-- orderid,quantity,customer_id,firstname,lastname
-- 1,1,4,Jeno,Lee
-- 2,2,1,Mark,Lee
-- 3,2,2,Johnny,Suh
-- 4,1,5,Karina,Yoo
-- 5,1,2,Johnny,Suh


-- Q12) Get the order id, order quantity, delivery platform, unit price and revenue (quantity * unit price) for all orders

SELECT orders.orderid, orders.quantity, orders.delivery_platform, menu.unit_price, (orders.quantity * menu.unit_price)
FROM orders
INNER JOIN menu
ON orders.menu_id = menu.menu_id
LIMIT 5;

-- orderid,quantity,delivery_platform,unit_price,(orders.quantity * menu.unit_price)
-- 1,1,Grabfood,50.0,50.0
-- 2,2,Lineman,55.0,110.0
-- 3,2,Robinhood,50.0,100.0
-- 4,1,Grabfood,50.0,50.0
-- 5,1,Robinhood,50.0,50.0