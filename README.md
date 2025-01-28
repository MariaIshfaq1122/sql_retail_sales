# sql_retail_sales
#Database and Table creation
...sql
CREATE DATABASE retail_db;

CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT

select * from retail_sales
limit 100;

select * from retail_sales
where transactions_id is null
or sale_date is null 
or sale_time is null
or customer_id is null
or gender is null
or category is null
or quantiy is null
or price_per_unit is null
or cogs is null
or total_sale is null
;

Delete from retail_sales
where transactions_id is null
or sale_date is null 
or sale_time is null
or customer_id is null
or gender is null
or category is null
or quantiy is null
or price_per_unit is null
or cogs is null
or total_sale is null
;
...
**-- How many sales do we have?
select count(*) as Total_sales from retail_sales;

-- How many total customers do we have?

Select count(distinct customer_id) as Total_customers from retail_sales;
