-- 5. Get the products that have the highest and lowest manufacturing costs.
-- The final output should contain these fields,
-- product_code
-- product
-- manufacturing_cost



select 
	p.product_code,
	p.product,
	m.manufacturing_cost
from dim_product p
join fact_manufacturing_cost m 
	on p.product_code=m.product_code
WHERE manufacturing_cost= 
	(SELECT min(manufacturing_cost) FROM fact_manufacturing_cost)
	or 
	manufacturing_cost = 
	(SELECT max(manufacturing_cost) FROM fact_manufacturing_cost) 
ORDER BY manufacturing_cost DESC;
