create database if not exists amazon;
use amazon;

create table if not exists sales( 
   invoice_id varchar(30) not null primary key,
   branch varchar(5) not null, 
   city varchar(30) not null,
   customer_type varchar(30) not null,
   gender varchar(10) not null,
   product_line varchar(100) not null,
   unit_price decimal(10,2) not null,
   quantity int not null,
   vat float not null,
   total decimal(12,4) not null,
   date_ datetime not null,
   time_ time not null, 
   payment_method varchar(15) not null,
   cogs decimal(10,2) not null,
   gross_margin_pct float not null,
   gross_income decimal(12,4) not null,
   rating float
   ); 
select * from sales;   

SELECT *
FROM sales
WHERE branch IS NULL;  

select isnull(total) from sales; 
select count(*) from sales; -- total 1000 rows are present in sales table

SELECT count(*) as No_of_Column FROM information_schema.columns 
WHERE table_schema = 'amazon'and  table_name ='sales'; -- count of columns are present 
   
SELECT COUNT(*) AS Total_null FROM sales WHERE rating IS NULL; -- checked if particular column contains null or not 

-- ---- Feature Engineering ----- 
-- --- time_of_day --- 
select time_,
(case 
   when time_ between '00:00:00' and '12:00:00' then 'Morning'
   when time_ between '12:01:00' and '16:00:00' then 'Afternoon'
   else 'Evening'
 end) as time_of_day
from sales; 
 
alter table sales add column time_of_day varchar(20);
update sales 
set time_of_day = (case 
   when time_ between '00:00:00' and '12:00:00' then 'Morning'
   when time_ between '12:01:00' and '16:00:00' then 'Afternoon'
   else 'Evening'
 end);

select * from sales; 

-- -- day_name from date column ----- 
select date_, dayname(date_) 
from sales;
alter table sales add column day_name varchar(10);
select * from sales;
update sales 
set day_name = dayname(date_);

-- --- month_name from date_ column --
select date_, monthname(date_) 
from sales;

alter table sales add column month_name varchar(10);
select * from sales;
update sales 
set month_name = monthname(date_); 

-- -- Business Questions to answer --- 
-- Q1.What is the count of distinct cities in the dataset?
select count(distinct city) as number_of_city from sales;
select distinct city from sales; -- name of the distinct cities 

-- Q2.For each branch, what is the corresponding city?
select distinct branch,city from sales; 

-- Q3.What is the count of distinct product lines in the dataset?
select count(distinct product_line) as cnt_of_productline
from sales;

-- Q4.Which payment method occurs most frequently? 
select payment_method, count(payment_method) as count_of_payment_method
from sales
group by payment_method
order by count_of_payment_method desc
limit 1;

-- Q5.Which product line has the highest sales?
select product_line, count(product_line) as cnt_of_sales 
from sales
group by product_line
order by cnt_of_sales desc
limit 1;

-- Q6.How much revenue is generated each month?
select month_name as month,
sum(total) as revenue
from sales 
group by month 
order by revenue desc;


-- Q7.In which month did the cost of goods sold reach its peak?
select month_name as month,
sum(cogs) as total_cogs 
from sales 
group by month
order by total_cogs desc
limit 1;


-- Q8.Which product line generated the highest revenue?
select product_line, sum(total) as revenue
from sales
group by product_line 
order by revenue desc 
limit 1; 

-- Q9.In which city was the highest revenue recorded?
select city, sum(total) as revenue
from sales 
group by city 
order by revenue desc
limit 1; 

-- Q10.Which product line incurred the highest Value Added Tax?
select product_line, round(sum(vat),2) as total_vat
from sales 
group by product_line 
order by total_vat desc
limit 1;


-- Q11.For each product line, add a column indicating "Good" if its sales are above average, otherwise "Bad."
select * from sales;
select product_line, 
(case 
 when sum(total) > (select avg(total) from sales) then 'Good'
 else 'Bad'
 end) as sales_status
from sales 
group by product_line; 

-- Q12.Identify the branch that exceeded the average number of products sold.
select branch,
sum(quantity) as qty
from sales 
group by branch 
having sum(quantity) > (select avg(quantity) from sales)
order by qty desc
limit 1;

-- Q13.Which product line is most frequently associated with each gender?
select gender, product_line, cnt_product_line 
from 
(select gender, product_line, cnt_product_line, 
dense_rank() over(partition by gender order by cnt_product_line desc) as dr_rank
from
(select gender,product_line, count(product_line) as cnt_product_line 
from sales 
group by gender, product_line
order by cnt_product_line desc) as t1) as t2 where dr_rank = 1;


-- Q14.Calculate the average rating for each product line.
select product_line, 
round(avg(rating),2) as average_rating 
from sales 
group by product_line
order by average_rating desc;

-- Q15.Count the sales occurrences for each time of day on every weekday.
select time_of_day,
count(total) as total_sales 
from sales
where day_name NOT IN('saturday','sunday')
group by time_of_day; 

-- Q16.Identify the customer type contributing the highest revenue.
select customer_type, 
sum(total) as revenue 
from sales 
group by customer_type
order by revenue desc
limit 1;

-- Q17.Determine the city with the highest VAT percentage.
select * from sales;

select city,  round(((sum(vat)/ sum(total)) * 100),2)
as vat_percentage 
from sales 
group by city 
order by vat_percentage desc;

-- Q18.Identify the customer type with the highest VAT payments.
select customer_type, sum(vat) as total_vat 
from sales 
group by customer_type
order by total_vat desc
limit 1;
 
select * from sales;
-- Q19.What is the count of distinct customer types in the dataset?
select count(distinct customer_type) as cnt_customer_type 
from sales; 
select distinct customer_type from sales;

-- Q20.What is the count of distinct payment methods in the dataset?

select distinct payment_method from sales; -- name of the distinct payment methods
select count(distinct payment_method) as cnt_payment_method
from sales; 

-- Q21.Which customer type occurs most frequently? 
select customer_type, 
count(customer_type) as count_customer_type
from sales 
group by customer_type 
order by count_customer_type desc
limit 1;

-- Q22.Identify the customer type with the highest purchase frequency.
select customer_type, count(*) as cnt_of_purchase
from sales 
group by customer_type
order by cnt_of_purchase desc
limit 1;

select * from sales;

-- Q23.Determine the predominant gender among customers.
select gender, count(*) as gen_count 
from sales 
group by gender 
order by gen_count desc
limit 1;

-- Q24.Examine the distribution of genders within each branch.
select branch, gender, count(gender) as cnt_of_gen 
from sales 
group by branch, gender
order by branch;

-- Q25.Identify the time of day when customers provide the most ratings.
select time_of_day, cnt_rating from
(select time_of_day, cnt_rating, dense_rank() over(order by cnt_rating desc) as dr_rank 
from (select time_of_day, count(rating) as cnt_rating  
from sales 
group by time_of_day) as t1) as t2 where dr_rank= 1;

-- Q26.Determine the time of day with the highest customer ratings for each branch.
select branch, time_of_day, high_rating from 
(select branch, time_of_day, high_rating, dense_rank() 
over(partition by branch order by high_rating desc) as d_rank 
from (select  branch,time_of_day, max(rating) as high_rating
from sales 
group by branch, time_of_day 
order by high_rating desc) as new_table) as new2 where d_rank = 1;


-- Q27.Identify the day of the week with the highest average ratings.
select day_name, avg_rating from 
(select day_name, avg_rating, dense_rank() over(order by avg_rating desc) as d_rank
from (select day_name, round(avg(rating),2) as avg_rating
from sales 
group by day_name
order by avg_rating desc) as t1) as t2  where d_rank= 1;


-- Q28.Determine the day of the week with the highest average ratings for each branch.
select branch, day_name, avg_rating from 
(select branch, day_name, avg_rating, dense_rank() 
over(partition by branch order by avg_rating desc) as d_rank 
from (select  branch,day_name, avg(rating) as avg_rating
from sales 
group by branch, day_name 
order by avg_rating desc) as new_table) as new2 where d_rank = 1;

select * from sales;