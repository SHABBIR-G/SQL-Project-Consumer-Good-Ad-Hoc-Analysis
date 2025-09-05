-- 6. Generate a report which contains the top 5 customers who received an
-- average high pre_invoice_discount_pct for the fiscal year 2021 and in the
-- Indian market. The final output contains these fields,
-- customer_code
-- customer
-- average_discount_percentage


select
	c.customer_code,
	c.customer,
	avg(p.pre_invoice_discount_pct) as avg_pre_invoice_discount_pct
from dim_customer c
join fact_pre_invoice_deductions p 
	on c.customer_code=p.customer_code
where market="india" and p.fiscal_year=2021
group by c.customer_code
order by avg_pre_invoice_discount_pct desc
limit 5