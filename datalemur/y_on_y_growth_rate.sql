-- Assume you're given a table containing information about Wayfair user transactions for different products. Write a query to calculate the year-on-year growth rate for the total spend of each product, grouping the results by product ID.

-- The output should include the year in ascending order, product ID, current year's spend, previous year's spend and year-on-year growth percentage, rounded to 2 decimal places.


-- user_transactions Table:

-- transaction_id       integer
-- product_id           integer
-- spend                decimal
-- transaction_date     datetime


WITH year_growth AS (
  SELECT 
    EXTRACT(YEAR FROM transaction_date::timestamp) as year
    , product_id
    , SUM(spend) curr_year_spend
  FROM user_transactions
  GROUP BY 
    EXTRACT(YEAR FROM transaction_date::timestamp)
    , product_id
), year_growth_2 AS (
  SELECT *
    , LAG(curr_year_spend) OVER(PARTITION BY product_id ORDER BY year) prev_year_spend
  FROM year_growth
)

SELECT *
  , ROUND((curr_year_spend - prev_year_spend) / prev_year_spend * 100, 2) yoy_rate
FROM year_growth_2;