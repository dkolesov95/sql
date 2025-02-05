-- https://datalemur.com/questions/user-retention

-- Assume you're given a table containing information on Facebook user actions. Write a query to obtain number of monthly active users (MAUs) in July 2022, including the month in numerical format "1, 2, 3".


-- user_actions Table:

-- user_id	    integer
-- event_id	integer
-- event_type	string
-- event_date	datetime



SELECT 
  EXTRACT(MONTH FROM event_date::TIMESTAMP) AS month
  , COUNT(DISTINCT user_id) monthly_active_users
FROM user_actions 
WHERE EXTRACT(MONTH FROM event_date::TIMESTAMP) = 7
  AND user_id in (SELECT user_id FROM user_actions WHERE EXTRACT(MONTH FROM event_date::TIMESTAMP) = 6)
GROUP BY EXTRACT(MONTH FROM event_date::TIMESTAMP);