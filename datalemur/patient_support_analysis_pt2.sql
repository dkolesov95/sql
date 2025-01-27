-- https://datalemur.com/questions/uncategorized-calls-percentage

-- UnitedHealth Group (UHG) has a program called Advocate4Me, which allows policy holders (or, members) to call an advocate and receive support for their health care needs – whether that's claims and benefits support, drug coverage, pre- and post-authorisation, medical records, emergency assistance, or member portal services.

-- Calls to the Advocate4Me call centre are classified into various categories, but some calls cannot be neatly categorised. These uncategorised calls are labeled as “n/a”, or are left empty when the support agent does not enter anything into the call category field.

-- Write a query to calculate the percentage of calls that cannot be categorised. Round your answer to 1 decimal place. For example, 45.0, 48.5, 57.7.


-- callers Table:

-- policy_holder_id    integer
-- case_id             varchar
-- call_category       varchar
-- call_date           timestamp
-- call_duration_secs	integer


WITH na AS (
  SELECT *
  FROM callers 
  WHERE call_category IN ('n/a', '') OR call_category IS NULL
)

SELECT ROUND((SELECT COUNT(*) FROM na) * 1.0 / COUNT(*) * 100, 1)
FROM callers;