-- 9. Which channel helped to bring more gross sales in the fiscal year 2021
-- and the percentage of contribution? The final output contains these fields,
-- channel
-- gross_sales_mln
-- percentage



with cte1 as 
	(select
	c.channel,
	SUM(g.gross_price * s.sold_quantity) AS total_sales
	from dim_customer c 
	join fact_sales_monthly s 
	on c.customer_code=s.customer_code
	join fact_gross_price g 
	on s.product_code=g.product_code
	where s.fiscal_year=2021
	GROUP BY c.channel
	)
select 
	channel,
	ROUND(total_sales / 1000000, 2) AS gross_sales_mln,
	ROUND(total_sales * 100.0 / SUM(total_sales) OVER (), 2) AS percentage
from cte1
order by percentage desc;

