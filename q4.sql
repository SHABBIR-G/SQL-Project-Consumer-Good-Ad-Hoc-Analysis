-- 4. Follow-up: Which segment had the most increase in unique products in
-- 2021 vs 2020? The final output contains these fields,
-- segment
-- product_count_2020
-- product_count_2021
-- difference


WITH CTE1 AS (
    SELECT 
        P.segment AS segment,
        COUNT(DISTINCT S.product_code) AS product_count_2020
    FROM dim_product P
    JOIN fact_sales_monthly S
        ON P.product_code = S.product_code
    WHERE S.fiscal_year = 2020
    GROUP BY P.segment
),
CTE2 AS (
    SELECT 
        P.segment AS segment,
        COUNT(DISTINCT S.product_code) AS product_count_2021
    FROM dim_product P
    JOIN fact_sales_monthly S
        ON P.product_code = S.product_code
    WHERE S.fiscal_year = 2021
    GROUP BY P.segment
)
SELECT 
    CTE1.segment,
    CTE1.product_count_2020,
    CTE2.product_count_2021,
    (CTE2.product_count_2021 - CTE1.product_count_2020) AS difference
FROM CTE1
JOIN CTE2
    ON CTE1.segment = CTE2.segment
ORDER BY difference DESC;
