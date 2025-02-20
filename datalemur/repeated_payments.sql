-- https://datalemur.com/questions/repeated-payments

-- Sometimes, payment transactions are repeated by accident; it could be due to user error, API failure or a retry error that causes a credit card to be charged twice.

-- Using the transactions table, identify any payments made at the same merchant with the same credit card for the same amount within 10 minutes of each other. Count such repeated payments.


-- transactions Table

-- transaction_id          integer
-- merchant_id	            integer
-- credit_card_id	        integer
-- amount	                integer
-- transaction_timestamp	datetime


SELECT count(*) payment_count
FROM (SELECT *
        , EXTRACT(EPOCH FROM (transaction_timestamp - LAG(transaction_timestamp) 
                    OVER(PARTITION BY merchant_id, credit_card_id, amount ORDER BY merchant_id))) / 60 time_diff
    FROM transactions) t
WHERE time_diff <= 10;