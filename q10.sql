-- 10. Get the Top 3 products in each division that have a high
-- total_sold_quantity in the fiscal_year 2021? The final output contains these
-- fields,
-- division
-- product_code
-- product
-- total_sold_quantity
-- rank_order


WITH cte1 AS (
    SELECT 
        p.division,
        p.product_code,
        p.product,
        SUM(s.sold_quantity) AS sold_quantity
    FROM dim_product p 
    JOIN fact_sales_monthly s 
        ON p.product_code = s.product_code
    WHERE s.fiscal_year = 2021
    GROUP BY p.division, p.product_code, p.product
),
cte2 as
(SELECT
    division, product_code, product, sold_quantity,
   RANK() OVER(PARTITION BY division ORDER BY sold_quantity DESC) AS rnk
FROM cte1
ORDER BY division, rnk)
select 
	cte1.division,
	cte1.product_code,
	cte1.product,
	cte1.sold_quantity,
	cte2.rnk
from cte1 
join cte2
	ON cte1.product_code = cte2.product_code
WHERE cte2.rnk IN (1,2,3);
