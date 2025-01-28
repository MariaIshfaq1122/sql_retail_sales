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

-- How many sales do we have?
select count(*) as Total_sales from retail_sales;

-- How many total customers do we have?

Select count(distinct customer_id) as Total_customers from retail_sales;

-- Data Analysis and Business key problems answers
-- My Analysis and Findings
-- Q1: Write a SQL query to retrieve all columns for sales made on '2022-11-05:

Select * from retail_sales
where sale_date = '2022-11-05';

-- Q2: Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:
Select * from retail_sales
where category = 'Clothing'
and quantiy >= 4
and  sale_date between '2022-11-01' and '2022-11-30'
order by sale_date ASC;

-- Q3: Write a SQL query to calculate the total sales (total_sale) for each category.:
Select  Sum(total_sale) as Total_sale, category 
from retail_sales
group by category; 

-- Q4: Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
Select ROUND(AVG(age), 2) as Avg_Age from retail_sales
where category = 'Beauty';

--Q5 : Write a SQL query to find all transactions where the total_sale is greater than 1000.:
Select * from retail_sales
where total_sale > 1000; 

--Q6 : Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
Select Count(transactions_id) as Total_Transactions, gender, category
from retail_sales
group by gender, category
order by 1; 
-- Q7: Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
Select Avg_sale, month, year
From(
	Select Avg(total_sale) as Avg_sale,
	Extract(MONTH from sale_date) as month, 
	Extract(YEAR from sale_date)as year,
	rank() over (partition by Extract(YEAR from sale_date) order by Avg(total_sale) DESC) as rank
	from retail_sales
	group by 2, 3
)
where rank = 1;

--Q8 **Write a SQL query to find the top 5 customers based on the highest total sales
Select customer_id, Sum(total_sale) as Total_sale
from retail_sales
group by 1
order by 2
DESC
Limit 5;

--Q9 Write a SQL query to find the number of unique customers who purchased items from each category.:



Select category, count(Distinct customer_id) as Unique_customer
from retail_sales 
Group by category;

-- Q10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
With hourly_sales
As

(Select *,
		case
			When Extract(Hour from sale_time) < 12 then 'Morning'
			when Extract(Hour from sale_time) between 12 and 17 then 'Afternoon'
			else 'Evening'
		end as shifts
from retail_sales)

Select Count(*) as Total_orders, shifts
from hourly_sales
group by shifts
order by 1
ASC  ;

