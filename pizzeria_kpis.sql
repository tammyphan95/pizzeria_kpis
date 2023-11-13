/* KPI's */

-- Find the total revenue

select SUM(total_price) as total_revenue
from pizza_sales ps 

-- Find average order value

select SUM(total_price) / COUNT(distinct order_id) as avg_order_value
from pizza_sales ps 

-- Find total pizzas sold

select SUM(quantity) as total_pizza_sold
from pizza_sales ps 

-- Find total orders placed

select COUNT(DISTINCT order_id) as total_orders
from pizza_sales ps 

-- Find average number of pizzas sold per order

select CAST(CAST(SUM(quantity) as DECIMAL(10,2)) / CAST(COUNT(DISTINCT order_id) as DECIMAL(10,2)) as DECIMAL(10,2)) as avg_pizza_per_order
from pizza_sales ps 

-- Daily trend for pizzas sold

SELECT DATENAME(DW, CONVERT(DATE, order_date, 105)) AS order_day,
       COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales ps
GROUP BY DATENAME(DW, CONVERT(DATE, order_date, 105))

-- Hourly trend for pizzas sold

select DATEPART(HOUR, order_time) as order_hour, SUM(quantity) as total_pizza_sold
from pizza_sales ps 
group by DATEPART(HOUR, order_time)
order by DATEPART(HOUR, order_time)

-- Weekly trend for pizzas sold

SELECT DATEPART(ISO_WEEK, CONVERT(DATE, order_date, 105)) AS week_number,
       YEAR(CONVERT(DATE, order_date, 105)) AS order_year,
       COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales ps
GROUP BY DATEPART(ISO_WEEK, CONVERT(DATE, order_date, 105)), YEAR(CONVERT(DATE, order_date, 105))
ORDER BY week_number, order_year;

-- Find percentage of sales by pizza category

select pizza_category, CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales ps) AS DECIMAL(10,2)) as percentage_total_sales
from pizza_sales ps2 
group by pizza_category
order by percentage_total_sales desc

-- Find percentage of sales by pizza size 

select pizza_size, CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales ps) AS DECIMAL(10,2)) as percentage_total_sales
from pizza_sales ps2 
group by pizza_size
order by percentage_total_sales desc

-- Find 5 best-selling pizza types by sales

select top 5 pizza_name, CAST(SUM(total_price) AS DECIMAL (10,2)) as total_revenue
from pizza_sales ps 
group by pizza_name
order by total_revenue desc

-- Find 5 least-selling pizza types by sales

select top 5 pizza_name, CAST(SUM(total_price) AS DECIMAL (10,2)) as total_revenue
from pizza_sales ps 
group by pizza_name
order by total_revenue asc

-- Find 5 best-selling pizza types by quantiy

select top 5 pizza_name, SUM(quantity) as total_orders
from pizza_sales ps 
group by pizza_name
order by total_orders desc

-- Find 5 least-selling pizza types by quantity

select top 5 pizza_name, SUM(quantity) as total_orders
from pizza_sales ps 
group by pizza_name
order by total_orders asc

