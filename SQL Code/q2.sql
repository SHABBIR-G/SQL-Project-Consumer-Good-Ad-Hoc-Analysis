-- 2. What is the percentage of unique product increase in 2021 vs. 2020? The
-- final output contains these fields,
-- unique_products_2020
-- unique_products_2021
-- percentage_chg

with cte1 as 
	(select 
	count(distinct p.product_code) as product_2020
	from dim_product p 
	join fact_sales_monthly s 
	on p.product_code=s.product_code
	where s.fiscal_year=2020),
cte2 as
	(
	select 
	count(distinct p.product_code) as product_2021
	from dim_product p 
	join fact_sales_monthly s 
	on p.product_code=s.product_code
	where s.fiscal_year=2021
	)

select 
	c1.product_2021,
	c2.product_2020,
	round((product_2021-product_2020)/ product_2020 *100,2)as diff
from cte2 c1
join cte1 c2;
