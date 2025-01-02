-- https://platform.stratascratch.com/coding/10296-facebook-accounts?code_type=1

-- Calculate the ratio of accounts closed on January 10th, 2020 using the fb_account_status table.

-- Table: fb_account_status

-- acc_id:     bigint
-- date:       date
-- status:     text

WITH tbl AS (
    SELECT *
    FROM fb_account_status
    WHERE date = '2020-01-10'
)

SELECT COUNT(DISTINCT CASE WHEN status = 'closed' THEN acc_id END) * 1.0 / COUNT(DISTINCT acc_id) ratio
FROM tbl;
