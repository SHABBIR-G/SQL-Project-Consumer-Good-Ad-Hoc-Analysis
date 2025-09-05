-- 7. Get the complete report of the Gross sales amount for the customer “Atliq
-- Exclusive” for each month. This analysis helps to get an idea of low and
-- high-performing months and take strategic decisions.
-- The final report contains these columns:
-- Month
-- Year
-- Gross sales Amount


select
	month(s.date) as month,
	year(date) as year,
	round(sum(gross_price*sold_quantity)/1000000,2) as gross_sales_mln
from fact_sales_monthly s 
join fact_gross_price g 
	on s.product_code=g.product_code
join dim_customer c 
	on c.customer_code=s.customer_code
where c.customer="Atliq Exclusive"
group by month,year;
