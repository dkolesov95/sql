-- https://datalemur.com/questions/sql-bloomberg-stock-min-max-1

-- The Bloomberg terminal is the go-to resource for financial professionals, offering convenient access to a wide array of financial datasets. As a Data Analyst at Bloomberg, you have access to historical data on stock performance.

-- Currently, you're analyzing the highest and lowest open prices for each FAANG stock by month over the years.

-- For each FAANG stock, display the ticker symbol, the month and year ('Mon-YYYY') with the corresponding highest and lowest open prices (refer to the Example Output format). Ensure that the results are sorted by ticker symbol.


-- stock_prices Schema:

-- date	datetime
-- ticker	varchar
-- open	decimal
-- high	decimal
-- low     decimal
-- close   decimal


WITH max_price AS (
  SELECT ticker
    , TO_CHAR(date, 'Mon-YYYY') date
    , MAX(open) maxp
  FROM stock_prices
  GROUP BY ticker, TO_CHAR(date, 'Mon-YYYY')
), min_price AS (
  SELECT ticker
    , TO_CHAR(date, 'Mon-YYYY') date
    , MIN(open) minp
  FROM stock_prices
  GROUP BY ticker, TO_CHAR(date, 'Mon-YYYY')
)


SELECT 
  maxp.ticker
  , maxp.date highest_mth
  , maxp.maxp highest_open
  , minp.date lowest_mth
  , minp.minp lowest_open
FROM (SELECT *, ROW_NUMBER() OVER(PARTITION BY ticker ORDER BY maxp DESC) rn FROM max_price) maxp
  LEFT JOIN (SELECT *, ROW_NUMBER() OVER(PARTITION BY ticker ORDER BY minp ASC) rn FROM min_price) minp 
  ON maxp.ticker = minp.ticker and maxp.rn = minp.rn
WHERE maxp.rn = 1
ORDER BY maxp.ticker;